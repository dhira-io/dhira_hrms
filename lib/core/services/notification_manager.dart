import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';
import '../../features/notifications/presentation/bloc/notification_event.dart';
import '../../features/notifications/domain/usecases/store_fcm_token_usecase.dart';
import '../../features/notifications/domain/usecases/deactivate_device_usecase.dart';
import 'local_storage_service.dart';
import 'device_id_service.dart';
import '../routing/app_router.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  LocalStorageService? _storage;

  /// Initialize Firebase and Notification settings
  Future<void> init({LocalStorageService? storage}) async {
    log('NotificationManager: Initializing...');
    print('≡ƒöî NotificationManager: Initializing...');
    _storage = storage;
    try {
      // 1. Request Permissions (iOS/Android 13+)
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Permission granted
      } else {
        // Permission declined
      }

      // 2. Setup Local Notifications for Foreground
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      
      const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await _localNotifications.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          _handleNotificationClick(response.payload);
        },
      );

      // 3. Create Android Notification Channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // 4. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Foreground Message received: ${message.notification?.title}');
        log('Message data: ${message.data}');
        if (message.notification != null) {
          _showLocalNotification(message, channel);
        }

        // Auto-refresh the notification list in the UI
        try {
          if (Get.isRegistered<NotificationBloc>()) {
            Get.find<NotificationBloc>().add(const NotificationEvent.load());
          }
        } catch (e) {
          // Silent fail
        }
      });

      // 5. Handle Background/Terminated click
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationClick(jsonEncode(message.data));
        
        // Refresh list when app is opened via notification
        _refreshNotificationList();
      });

      // Check if the app was opened from a terminated state via a notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationClick(jsonEncode(initialMessage.data));
        _refreshNotificationList();
      }

      // 6. Get and Print FCM Token
      await getToken();


    } catch (e) {
      // Silent fail
    }
  }

  /// Get FCM Token
  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      log('FCM TOKEN: $token');
      print('≡ƒöÑ FCM TOKEN: $token ≡ƒöÑ');

      if (token != null) {
        // Save locally for logout deactivation
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
        } catch (e) {
          // Silent fail
        }
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
    } catch (e) {
      // Silent fail
    }
  }


  /// Show local notification when app is in foreground
  void _showLocalNotification(RemoteMessage message, AndroidNotificationChannel channel) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Handle Notification Click
  void _handleNotificationClick(String? payload) {
    if (payload == null || payload.isEmpty) return;
    log('Notification clicked with payload: $payload');
    
    try {
      // 1. Parse the payload
      final Map<String, dynamic> data = jsonDecode(payload);
      
      // 2. Extract identifying information (assuming Frappe/HRMS standard keys)
      final String type = data['type']?.toString().toLowerCase() ?? '';
      final String docName = data['docname']?.toString() ?? '';

      // 3. Navigate based on type
      switch (type) {
        case 'leave application':
          AppRouter.router.push(AppRouter.applyLeavePath, extra: {
            'employeeId': '', 
            'leave': null,    
          });
          break;

        case 'timesheet':
          AppRouter.router.push(AppRouter.applyTimesheetPath, extra: docName);
          break;

        case 'attendance':
        case 'attendance regularization':
          AppRouter.router.push(AppRouter.attendanceRegularizationPath);
          break;

        case 'performance':
        case 'self assessment':
          AppRouter.router.push(AppRouter.performanceSelfAssessmentPath);
          break;

        default:
          AppRouter.router.push(AppRouter.notificationsPath);
          break;
      }
    } catch (e) {
      log('Error handling notification click: $e');
      // Fallback to the main notifications screen
      AppRouter.router.push(AppRouter.notificationsPath);
    }
  }

  /// Subscribe to Topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  /// Unsubscribe from Topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  /// Helper to refresh the notification list
  void _refreshNotificationList() {
    try {
      if (Get.isRegistered<NotificationBloc>()) {
        Get.find<NotificationBloc>().add(const NotificationEvent.load());
      }
    } catch (_) {}
  }

  /// Send a test notification locally to verify the configuration
  Future<void> sendTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await _localNotifications.show(
      id: 0,
      title: 'Test Notification',
      body: 'This is a test notification to verify FCM setup!',
      notificationDetails: platformChannelSpecifics,
      payload: 'test_payload',
    );

    // Also trigger refresh for the test
    _refreshNotificationList();
  }
}


/// Top-level background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `Firebase.initializeApp()` before using other Firebase services.
  await Firebase.initializeApp();
}
