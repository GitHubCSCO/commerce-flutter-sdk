import 'dart:async';
import 'dart:developer' as developer;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:commerce_flutter_sdk/src/core/config/log_config.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';

/// Notification handler service for managing Firebase and local notifications
class NotificationHandler {
  // Private constructor for singleton pattern
  NotificationHandler._(this._coreServiceProvider);

  static NotificationHandler? _instance;

  /// Get the singleton instance
  static NotificationHandler getInstance(ICoreServiceProvider coreServiceProvider) {
    _instance ??= NotificationHandler._(coreServiceProvider);
    return _instance!;
  }

  final ICoreServiceProvider _coreServiceProvider;

  // Constants
  static const String _channelId = 'commerce_notifications';
  static const String _channelName = 'Commerce Notifications';
  static const String _channelDescription =
      'Notifications for commerce app updates and alerts';
  static const String _androidIcon = '@mipmap/ic_launcher';
  static const String _logPrefix = '[NotificationHandler]';

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _backgroundSubscription;

  /// Initialize the notification handler
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      await _requestPermissions();
      await _initializeLocalNotifications();
      await _setupFirebaseListeners();
      _isInitialized = true;
    } catch (e, stackTrace) {
      _logError('Failed to initialize notification handler', e, stackTrace);
      rethrow;
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
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

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        _logWarning('User denied notification permissions');
      }
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
        requestAlertPermission: false, // Already requested via Firebase
        requestBadgePermission: false, // Already requested via Firebase
        requestSoundPermission: false, // Already requested via Firebase
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
        onDidReceiveNotificationResponse: (response) async {
          await _onNotificationResponse(response);
        },
      );

      // Create notification channel for Android
      await _createNotificationChannel();
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
        // Track notification clicked event for app opened from terminated state
        await _trackNotificationClicked();
        await _processNotificationAction(initialMessage);
      }
    } catch (e, stackTrace) {
      _logError('Failed to handle initial message', e, stackTrace);
    }
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    try {
      // Track notification received event
      await _trackNotificationReceived();
      
      // Always show local notification for foreground messages
      await _showLocalNotification(message);
    } catch (e, stackTrace) {
      _logError('Failed to handle foreground message', e, stackTrace);
    }
  }

  /// Handle message when app is opened from background
  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    try {
      // Track notification clicked event
      await _trackNotificationClicked();
      
      await _processNotificationAction(message);
    } catch (e, stackTrace) {
      _logError('Failed to handle message opened app', e, stackTrace);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      // For data-only messages, create a default notification
      String title =
          message.notification?.title ?? message.data['title'] ?? 'New Message';
      String body = message.notification?.body ??
          message.data['body'] ??
          'You have a new notification';

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
        title,
        body,
        notificationDetails,
        payload: _createPayload(message),
      );
    } catch (e, stackTrace) {
      _logError('Failed to show local notification', e, stackTrace);
    }
  }

  /// Handle notification response (when user taps notification)
  Future<void> _onNotificationResponse(NotificationResponse response) async {
    try {
      // Track notification clicked event (users only tap local notifications)
      await _trackNotificationClicked();
      
      // TODO: Implement notification tap handling
      // Example: Parse payload and navigate to appropriate screen
    } catch (e, stackTrace) {
      _logError('Failed to handle notification response', e, stackTrace);
    }
  }

  /// Process notification action (navigation, deep linking, etc.)
  Future<void> _processNotificationAction(RemoteMessage message) async {
    // TODO: Implement notification action handling
    // Example: Extract action/route from message.data and navigate
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
  }

  /// Track notification received analytics event
  Future<void> _trackNotificationReceived() async {
    try {
      final trackingService = _coreServiceProvider.getTrackingService();
      
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventNotificationReceived,
        'Push Notification',
      );

      await trackingService.trackEvent(analyticsEvent);
    } catch (e, stackTrace) {
      _logError('Failed to track notification received event', e, stackTrace);
    }
  }

  /// Track notification clicked analytics event
  Future<void> _trackNotificationClicked() async {
    try {
      final trackingService = _coreServiceProvider.getTrackingService();
      
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventNotificationClicked,
        'Push Notification',
      );

      await trackingService.trackEvent(analyticsEvent);
    } catch (e, stackTrace) {
      _logError('Failed to track notification clicked event', e, stackTrace);
    }
  }

  // Essential logging methods
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
  // Handle background message processing here
  // Keep it lightweight as this runs in isolate
  
  try {
    // Track notification received in background
    await _trackBackgroundNotificationReceived(message);
  } catch (e) {
    // Log error but don't throw to avoid breaking the background handler
    developer.log('Background notification tracking failed: $e', name: 'NotificationHandler');
  }
}

/// Track background notification received (must be top-level accessible)
Future<void> _trackBackgroundNotificationReceived(RemoteMessage message) async {
  try {
    // Since this runs in isolate, we need to use a simple tracking approach
    // You could also store this data and sync when app comes to foreground
    developer.log('Background notification received: ${message.messageId}', name: 'NotificationHandler');
    
    // If you have access to analytics in background isolate, track here
    // Otherwise, consider storing the event and syncing when app becomes active
  } catch (e) {
    developer.log('Failed to track background notification: $e', name: 'NotificationHandler');
  }
}
