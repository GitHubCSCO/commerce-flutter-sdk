import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/opti_logger_service_interface.dart';

/// Notification handler service for managing Firebase and local notifications
class NotificationHandler {
  NotificationHandler._(this._coreServiceProvider);

  static NotificationHandler? _instance;

  static NotificationHandler getInstance(
      ICoreServiceProvider coreServiceProvider) {
    _instance ??= NotificationHandler._(coreServiceProvider);
    return _instance!;
  }

  final ICoreServiceProvider _coreServiceProvider;

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

  Future<void> _initializeLocalNotifications() async {
    try {
      const androidSettings = AndroidInitializationSettings(_androidIcon);
      const iOSSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
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
      await _handleInitialMessage();

      _foregroundSubscription = FirebaseMessaging.onMessage.listen(
        _handleForegroundMessage,
        onError: (error) => _logError('Foreground message error', error),
      );

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
        await _trackNotificationClicked();
      }
    } catch (e, stackTrace) {
      _logError('Failed to handle initial message', e, stackTrace);
    }
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    try {
      await _showLocalNotification(message);
    } catch (e, stackTrace) {
      _logError('Failed to handle foreground message', e, stackTrace);
    }
  }

  /// Handle message when app is opened from background
  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    try {
      await _trackNotificationClicked();
    } catch (e, stackTrace) {
      _logError('Failed to handle message opened app', e, stackTrace);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
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
      await _trackNotificationClicked();
    } catch (e, stackTrace) {
      _logError('Failed to handle notification response', e, stackTrace);
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

  Future<void> dispose() async {
    await _foregroundSubscription?.cancel();
    await _backgroundSubscription?.cancel();
    _isInitialized = false;
  }

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

  void _logWarning(String message) {
    final optiLogger = sl<OptiLoggerService>();
    if (optiLogger.isDebugLogEnabled) {
      print('$_logPrefix WARNING: $message');
    }
  }

  void _logError(String message, [dynamic error, StackTrace? stackTrace]) {
    final optiLogger = sl<OptiLoggerService>();
    if (optiLogger.isErrorLogEnabled) {
      final errorText = error != null ? ' - $error' : '';
      print('$_logPrefix ERROR: $message$errorText');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
}
