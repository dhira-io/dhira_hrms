import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as fln;
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
  final fln.FlutterLocalNotificationsPlugin _localNotifications = fln.FlutterLocalNotificationsPlugin();
  
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
      final initializationSettingsAndroid =
          fln.AndroidInitializationSettings(LocalNotificationConstants.iconPath);
      final initializationSettingsIOS = fln.DarwinInitializationSettings();
      
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
      const fln.AndroidNotificationChannel channel = fln.AndroidNotificationChannel(
        LocalNotificationConstants.channelId,
        LocalNotificationConstants.channelName,
        description: LocalNotificationConstants.channelDescription,
        importance: fln.Importance.max,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<fln.AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // 4. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          _showLocalNotification(message, channel);
        }
        _refreshNotificationList();
      });

      // 5. Handle Background/Terminated click
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationClick(jsonEncode(message.data));
        _refreshNotificationList();
      });

      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
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
          if (Get.isRegistered<StoreFcmTokenUseCase>() && Get.isRegistered<DeviceIdService>()) {
            final deviceIdService = Get.find<DeviceIdService>();
            final deviceId = await deviceIdService.getDeviceId();
            final platform = deviceIdService.getPlatform();
            await Get.find<StoreFcmTokenUseCase>().call(
              token: token, 
              deviceId: deviceId, 
              platform: platform
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
      final token = _storage?.getFcmToken() ?? await _firebaseMessaging.getToken();
      if (token != null) {
        if (Get.isRegistered<DeactivateDeviceUseCase>() && Get.isRegistered<DeviceIdService>()) {
          final deviceIdService = Get.find<DeviceIdService>();
          final deviceId = await deviceIdService.getDeviceId();
          final platform = deviceIdService.getPlatform();
          await Get.find<DeactivateDeviceUseCase>().call(
            token: token,
            deviceId: deviceId,
            platform: platform
          );
        }
      }
    } catch (e) {}
  }

  /// Show local notification when app is in foreground
  void _showLocalNotification(RemoteMessage message, fln.AndroidNotificationChannel channel) {
    // Extract title and body from notification object OR data payload as fallback
    final String title = message.notification?.title ?? 
                        message.data['title']?.toString() ?? 
                        message.data['subject']?.toString() ?? 
                        'New Notification';
    
    final String body = message.notification?.body ?? 
                       message.data['message']?.toString() ?? 
                       message.data['content']?.toString() ?? 
                       message.data['body']?.toString() ?? 
                       '';

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
        ),
        iOS: const fln.DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Handle Notification Click
  void _handleNotificationClick(String? payload) {
    if (payload == null || payload.isEmpty) return;
    try {
      final Map<String, dynamic> data = jsonDecode(payload);
      final String type = data['type']?.toString().toLowerCase() ?? '';
      final String docName = data['docname']?.toString() ?? '';
      final String title = data['title']?.toString() ?? data['subject']?.toString() ?? '';
      AppRouter.navigateByNotification(type: type, docName: docName, title: title);
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
