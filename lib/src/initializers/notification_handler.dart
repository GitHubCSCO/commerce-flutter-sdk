import 'dart:async';
import 'dart:developer' as developer;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:commerce_flutter_sdk/src/core/config/log_config.dart';

/// Notification handler service for managing Firebase and local notifications
class NotificationHandler {
  // Private constructor for singleton pattern
  NotificationHandler._();

  static final NotificationHandler _instance = NotificationHandler._();

  /// Get the singleton instance
  static NotificationHandler get instance => _instance;

  // Constants
  static const String _channelId = 'commerce_notifications';
  static const String _channelName = 'Commerce Notifications';
  static const String _channelDescription =
      'Notifications for commerce app updates and alerts';
  static const String _androidIcon = '@mipmap/ic_launcher';
  static const String _handledKey = 'handled';
  static const String _logPrefix = '[NotificationHandler]';

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _backgroundSubscription;

  /// Initialize the notification handler
  Future<void> initialize() async {
    if (_isInitialized) {
      _logWarning('Notification handler already initialized');
      return;
    }

    try {
      await _requestPermissions();
      await _initializeLocalNotifications();
      await _setupFirebaseListeners();
      _isInitialized = true;
      _logInfo('Notification handler initialized successfully');
    } catch (e, stackTrace) {
      _logError('Failed to initialize notification handler', e, stackTrace);
      rethrow;
    }
  }

  /// Request notification permissions
  Future<NotificationSettings> _requestPermissions() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false,
      );

      _logInfo('Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        _logWarning('User denied notification permissions');
      }

      return settings;
    } catch (e, stackTrace) {
      _logError('Failed to request permissions', e, stackTrace);
      rethrow;
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    try {
      const androidSettings = AndroidInitializationSettings(_androidIcon);
      const iOSSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iOSSettings,
      );

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationResponse,
      );

      // Create notification channel for Android
      await _createNotificationChannel();

      _logInfo('Local notifications initialized');
    } catch (e, stackTrace) {
      _logError('Failed to initialize local notifications', e, stackTrace);
      rethrow;
    }
  }

  /// Create notification channel for Android
  Future<void> _createNotificationChannel() async {
    try {
      const channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
        showBadge: true,
        enableVibration: true,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      _logInfo('Notification channel created');
    } catch (e, stackTrace) {
      _logError('Failed to create notification channel', e, stackTrace);
    }
  }

  /// Setup Firebase message listeners
  Future<void> _setupFirebaseListeners() async {
    try {
      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

      // Handle initial message when app is opened from terminated state
      await _handleInitialMessage();

      // Listen for foreground messages
      _foregroundSubscription = FirebaseMessaging.onMessage.listen(
        _handleForegroundMessage,
        onError: (error) => _logError('Foreground message error', error),
      );

      // Listen for messages when app is opened from background
      _backgroundSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
        _handleMessageOpenedApp,
        onError: (error) => _logError('Message opened app error', error),
      );

      _logInfo('Firebase listeners configured');
    } catch (e, stackTrace) {
      _logError('Failed to setup Firebase listeners', e, stackTrace);
      rethrow;
    }
  }

  /// Handle initial message when app opens from terminated state
  Future<void> _handleInitialMessage() async {
    try {
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _logInfo(
            'App opened from terminated state with message: ${initialMessage.messageId}');
        await _processNotificationAction(initialMessage);
      }
    } catch (e, stackTrace) {
      _logError('Failed to handle initial message', e, stackTrace);
    }
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    try {
      _logInfo('Foreground message received: ${message.messageId}');

      // Show local notification if the app is in foreground
      if (_shouldShowLocalNotification(message)) {
        await _showLocalNotification(message);
      } else {
        _logInfo('Skipping local notification - already handled or invalid');
      }
    } catch (e, stackTrace) {
      _logError('Failed to handle foreground message', e, stackTrace);
    }
  }

  /// Handle message when app is opened from background
  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    try {
      _logInfo(
          'App opened from background via notification: ${message.messageId}');
      await _processNotificationAction(message);
    } catch (e, stackTrace) {
      _logError('Failed to handle message opened app', e, stackTrace);
    }
  }

  /// Check if local notification should be shown
  bool _shouldShowLocalNotification(RemoteMessage message) {
    // Don't show if already handled
    if (message.data.containsKey(_handledKey)) {
      return false;
    }

    // Don't show if notification is null (data-only message)
    if (message.notification == null) {
      return false;
    }

    return true;
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      if (notification == null) return;

      const androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        icon: _androidIcon,
        largeIcon: DrawableResourceAndroidBitmap(_androidIcon),
      );

      const iOSDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );

      // Generate unique ID
      final notificationId = _generateNotificationId();

      await _localNotifications.show(
        notificationId,
        notification.title ?? 'New Message',
        notification.body ?? 'You have a new notification',
        notificationDetails,
        payload: _createPayload(message),
      );

      _logInfo('Local notification shown: ${notification.title}');
    } catch (e, stackTrace) {
      _logError('Failed to show local notification', e, stackTrace);
    }
  }

  /// Handle notification response (when user taps notification)
  void _onNotificationResponse(NotificationResponse response) {
    try {
      _logInfo('Notification tapped with payload: ${response.payload}');

      if (response.payload != null) {
        // Parse payload and handle navigation
        _handleNotificationNavigation(response.payload!);
      }
    } catch (e, stackTrace) {
      _logError('Failed to handle notification response', e, stackTrace);
    }
  }

  /// Process notification action (navigation, deep linking, etc.)
  Future<void> _processNotificationAction(RemoteMessage message) async {
    try {
      // Extract action data from message
      final action = message.data['action'];
      final route = message.data['route'];

      _logInfo('Processing notification action: $action, route: $route');

      // Handle specific actions based on your app's requirements
      // This is where you would implement navigation logic
    } catch (e, stackTrace) {
      _logError('Failed to process notification action', e, stackTrace);
    }
  }

  /// Handle notification navigation
  void _handleNotificationNavigation(String payload) {
    try {
      // Parse payload and navigate to appropriate screen
      // Implementation depends on your navigation system
      _logInfo('Handling navigation for payload: $payload');
    } catch (e, stackTrace) {
      _logError('Failed to handle notification navigation', e, stackTrace);
    }
  }

  /// Generate unique notification ID
  int _generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  /// Create payload from message
  String _createPayload(RemoteMessage message) {
    return message.data.isNotEmpty
        ? message.data.entries.map((e) => '${e.key}=${e.value}').join('&')
        : 'default_payload';
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _foregroundSubscription?.cancel();
    await _backgroundSubscription?.cancel();
    _isInitialized = false;
    _logInfo('Notification handler disposed');
  }

  // Logging methods
  void _logInfo(String message) {
    if (LogConfig.isAllLogsEnabled) {
      developer.log('$_logPrefix $message', name: 'NotificationHandler');
    }
  }

  void _logWarning(String message) {
    if (LogConfig.isAllLogsEnabled) {
      developer.log('$_logPrefix WARNING: $message',
          name: 'NotificationHandler');
    }
  }

  void _logError(String message, [dynamic error, StackTrace? stackTrace]) {
    if (LogConfig.isAllLogsEnabled) {
      developer.log(
        '$_logPrefix ERROR: $message${error != null ? ' - $error' : ''}',
        name: 'NotificationHandler',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  try {
    if (LogConfig.isAllLogsEnabled) {
      developer.log(
        '[NotificationHandler] Background message received: ${message.messageId}',
        name: 'NotificationHandler',
      );
    }

    // Handle background message processing here
    // Keep it lightweight as this runs in isolate
  } catch (e, stackTrace) {
    if (LogConfig.isAllLogsEnabled) {
      developer.log(
        '[NotificationHandler] ERROR in background handler: $e',
        name: 'NotificationHandler',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
