import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';

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

  /// Check if notification permissions are granted
  bool get hasNotificationPermissions => _hasNotificationPermissions;

  static const String _channelId = 'commerce_notifications';
  static const String _channelName = 'Commerce Notifications';
  static const String _channelDescription =
      'Notifications for commerce app updates and alerts';
  static const String _androidIcon = '@mipmap/ic_launcher';

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _hasNotificationPermissions = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {

      // Only proceed with initialization if permissions are granted
      if (hasNotificationPermissions) {
        await _initializeLocalNotifications();
      }

      _isInitialized = true;
    } catch (e) {
      unawaited(_coreServiceProvider.getTrackingService().trackError(e));
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
        },
      );

      await _createNotificationChannel();
    } catch (e) {
      unawaited(_coreServiceProvider.getTrackingService().trackError(e));
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
    } catch (e) {
      unawaited(_coreServiceProvider.getTrackingService().trackError(e));
    }
  }

  /// Generate unique notification ID
  int _generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  Future<void> dispose() async {
    _isInitialized = false;
  }

  Future<void> _trackNotificationClicked() async {
    final trackingService = _coreServiceProvider.getTrackingService();
    try {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventNotificationClicked,
        'Push Notification',
      );

      unawaited(trackingService.trackEvent(analyticsEvent));
    } catch (e) {
      unawaited(trackingService.trackError(e));
    }
  }
}
