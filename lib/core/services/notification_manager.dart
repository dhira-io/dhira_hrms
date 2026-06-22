import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:get/get.dart';
import '../../features/notifications/data/constants/notification_constants.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';
import '../../features/notifications/presentation/bloc/notification_event.dart';
import '../../features/notifications/domain/usecases/store_fcm_token_usecase.dart';
import '../../features/notifications/domain/usecases/deactivate_device_usecase.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/device_id_service.dart';
import '../routing/app_router.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final fln.FlutterLocalNotificationsPlugin _localNotifications =
      fln.FlutterLocalNotificationsPlugin();

  LocalStorageService? _storage;

  /// Initialize Firebase and Notification settings
  Future<void> init({LocalStorageService? storage}) async {
    _storage = storage;
    try {
      // 1. Request Permissions
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // 2. Setup Local Notifications
      final initializationSettingsAndroid = fln.AndroidInitializationSettings(
        LocalNotificationConstants.iconPath,
      );
      final initializationSettingsIOS = fln.DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      );

      final settings = fln.InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await _localNotifications.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (details) {
          _handleNotificationClick(details.payload);
        },
      );

      // 3. Create Android Notification Channel
      const fln.AndroidNotificationChannel channel =
          fln.AndroidNotificationChannel(
            LocalNotificationConstants.channelId,
            LocalNotificationConstants.channelName,
            description: LocalNotificationConstants.channelDescription,
            importance: fln.Importance.max,
            playSound: true,
            enableVibration: true,
          );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
            fln.AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      // 4. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Show local notification for both formal notification objects AND data-only payloads
        _showLocalNotification(message, channel);
        _refreshNotificationList();
      });

      // 5. Handle Background/Terminated click
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationClick(jsonEncode(message.data));
        _refreshNotificationList();
      });

      RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationClick(jsonEncode(initialMessage.data));
        _refreshNotificationList();
      }

      // 6. Get FCM Token
      await getToken();
    } catch (e) {
      // Silent fail
    }
  }

  /// Get FCM Token
  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _storage?.saveFcmToken(token);
        try {
          if (Get.isRegistered<StoreFcmTokenUseCase>() &&
              Get.isRegistered<DeviceIdService>()) {
            final deviceIdService = Get.find<DeviceIdService>();
            final deviceId = await deviceIdService.getDeviceId();
            final platform = deviceIdService.getPlatform();
            await Get.find<StoreFcmTokenUseCase>().call(
              token: token,
              deviceId: deviceId,
              platform: platform,
            );
          }
        } catch (e) {}
      }
      return token;
    } catch (e) {
      return null;
    }
  }

  /// Deactivate device on logout
  Future<void> deactivate() async {
    try {
      final token =
          _storage?.getFcmToken() ?? await _firebaseMessaging.getToken();
      if (token != null) {
        if (Get.isRegistered<DeactivateDeviceUseCase>() &&
            Get.isRegistered<DeviceIdService>()) {
          final deviceIdService = Get.find<DeviceIdService>();
          final deviceId = await deviceIdService.getDeviceId();
          final platform = deviceIdService.getPlatform();
          await Get.find<DeactivateDeviceUseCase>().call(
            token: token,
            deviceId: deviceId,
            platform: platform,
          );
        }
      }
    } catch (e) {}
  }

  /// Show local notification when app is in foreground
  void _showLocalNotification(
    RemoteMessage message,
    fln.AndroidNotificationChannel channel,
  ) {
    // Extract title and body from notification object OR data payload as fallback
    final String? notificationTitle = message.notification?.title;
    final String? notificationBody = message.notification?.body;

    final String title =
        notificationTitle?.trim() ??
        message.data[PushNotificationPayloadKeys.title]?.toString()?.trim() ??
        message.data[PushNotificationPayloadKeys.subject]?.toString()?.trim() ??
        PushNotificationValues.defaultTitle;

    String body =
        (notificationBody ??
                message.data[PushNotificationPayloadKeys.message]?.toString() ??
                message.data[PushNotificationPayloadKeys.content]?.toString() ??
                message.data[PushNotificationPayloadKeys.body]?.toString() ??
                '')
            .trim();

    if (message.notification == null &&
        body.isEmpty &&
        (title.toLowerCase().trim() ==
            PushNotificationValues.defaultTitle.toLowerCase().trim())) {
      return;
    }

    // Section 7 Edge Cases: items JSON fails to parse on bulk -> show generic message
    if (message.data[PushNotificationPayloadKeys.isBulk] ==
        PushNotificationValues.trueString) {
      try {
        final itemsStr =
            message.data[PushNotificationPayloadKeys.items]?.toString() ??
            PushNotificationValues.defaultItemsJson;
        jsonDecode(itemsStr);
      } catch (e) {
        body = PushNotificationValues.genericPendingBody;
      }
    }

    _localNotifications.show(
      id: message.hashCode,
      title: title,
      body: body,
      notificationDetails: fln.NotificationDetails(
        android: fln.AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: fln.Importance.max,
          priority: fln.Priority.high,
          playSound: true,
          enableVibration: true,
          fullScreenIntent: true,
        ),
        iOS: const fln.DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Handle Notification Click
  void _handleNotificationClick(String? payload) {
    if (payload == null || payload.isEmpty) return;
    try {
      final Map<String, dynamic> data = jsonDecode(payload);

      // Intercept local file open payloads
      if (data.containsKey('localFilePath')) {
        final filePath = data['localFilePath'] as String;
        if (filePath.isNotEmpty) {
          final file = File(filePath);
          if (file.existsSync()) {
            OpenFilex.open(filePath);
          }
        }
        return;
      }

      // Section 4 & 6: Check for digest/bulk notification first
      if (data[PushNotificationPayloadKeys.isBulk] ==
          PushNotificationValues.trueString) {
        final int count =
            int.tryParse(
              data[PushNotificationPayloadKeys.count]?.toString() ??
                  PushNotificationValues.defaultCount,
            ) ??
            0;

        List items = [];
        try {
          items = jsonDecode(
            data[PushNotificationPayloadKeys.items]?.toString() ??
                PushNotificationValues.defaultItemsJson,
          );
        } catch (e) {
          // Section 7 Edge Cases: items JSON fails to parse
          // Show generic "You have pending approvals" message
          try {
            Get.snackbar(
              PushNotificationValues.genericPendingTitle,
              PushNotificationValues.genericPendingBody,
              snackPosition: SnackPosition.BOTTOM,
            );
          } catch (_) {
            // Safe fallback if Get context is not ready
          }
        }

        final String mobileUrl =
            data[PushNotificationPayloadKeys.mobileUrl]?.toString() ?? '';

        // Open Notifications List screen (by navigating to mobile_url / fallbackPath)
        AppRouter.navigateByMobileUrl(
          mobileUrl,
          fallbackPath: AppRouter.notificationsPath,
        );
        return;
      }

      // Immediate notification logic
      final String type =
          data[PushNotificationPayloadKeys.type]?.toString() ?? '';
      final String referenceDoctype =
          data[PushNotificationPayloadKeys.referenceDoctype]?.toString() ?? '';

      // Support both spec's reference_name and legacy docname for safety
      final String referenceName =
          data[PushNotificationPayloadKeys.referenceName]?.toString() ??
          data[PushNotificationPayloadKeys.docName]?.toString() ??
          '';

      final String mobileUrl =
          data[PushNotificationPayloadKeys.mobileUrl]?.toString() ?? '';

      if (mobileUrl.isNotEmpty) {
        // Navigate using mobile_url directly
        AppRouter.navigateByMobileUrl(
          mobileUrl,
          referenceDoctype: referenceDoctype,
          referenceName: referenceName,
          type: type,
        );
      } else {
        // Build route from reference_doctype + reference_name
        AppRouter.navigateByNotification(
          type: referenceDoctype.isNotEmpty ? referenceDoctype : type,
          docName: referenceName,
        );
      }
    } catch (e) {
      AppRouter.router.push(AppRouter.notificationsPath);
    }
  }

  /// Helper to refresh the notification list
  void _refreshNotificationList() {
    try {
      if (Get.isRegistered<NotificationBloc>()) {
        Get.find<NotificationBloc>().add(const NotificationEvent.load());
      }
    } catch (_) {}
  }

  /// Show a custom local notification (e.g., for file downloads)
  Future<void> showCustomLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      const fln.AndroidNotificationDetails androidPlatformChannelSpecifics =
          fln.AndroidNotificationDetails(
            LocalNotificationConstants.channelId,
            LocalNotificationConstants.channelName,
            channelDescription: LocalNotificationConstants.channelDescription,
            importance: fln.Importance.max,
            priority: fln.Priority.high,
          );
      const fln.NotificationDetails platformChannelSpecifics =
          fln.NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: fln.DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          );

      await _localNotifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformChannelSpecifics,
        payload: payload,
      );
    } catch (e, stack) {
      print("Error in showCustomLocalNotification: $e\n$stack");
    }
  }

  /// Send a test notification locally
  Future<void> sendTestNotification() async {
    const fln.AndroidNotificationDetails androidPlatformChannelSpecifics =
        fln.AndroidNotificationDetails(
          LocalNotificationConstants.channelId,
          LocalNotificationConstants.channelName,
          channelDescription: LocalNotificationConstants.channelDescription,
          importance: fln.Importance.max,
          priority: fln.Priority.high,
          ticker: 'ticker',
        );
    const fln.NotificationDetails platformChannelSpecifics =
        fln.NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      id: 0,
      title: 'Test Notification',
      body: 'This is a test notification to verify FCM setup!',
      notificationDetails: platformChannelSpecifics,
      payload: 'test_payload',
    );

    _refreshNotificationList();
  }
}
