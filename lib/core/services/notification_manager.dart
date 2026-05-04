import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';
import '../../features/notifications/presentation/bloc/notification_event.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// Initialize Firebase and Notification settings
  Future<void> init() async {
    try {
      // 1. Request Permissions (iOS/Android 13+)
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('🔔 [FCM] User granted permission');
      } else {
        print('⚠️ [FCM] User declined or has not accepted permission');
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
        print('📩 [FCM] Message received in FOREGROUND');
        print('📩 [FCM] Title: ${message.notification?.title}');
        print('📩 [FCM] Body: ${message.notification?.body}');
        print('📩 [FCM] Data: ${message.data}');

        if (message.notification != null) {
          _showLocalNotification(message, channel);
        }

        // Auto-refresh the notification list in the UI
        try {
          if (Get.isRegistered<NotificationBloc>()) {
            Get.find<NotificationBloc>().add(const NotificationEvent.load());
            log('Notification list refreshed via FCM');
          }
        } catch (e) {
          log('Error refreshing notifications: $e');
        }
      });

      // 5. Handle Background/Terminated click
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('🖱️ [FCM] Message clicked (App was in BACKGROUND)');
        print('📩 [FCM] Data: ${message.data}');
        _handleNotificationClick(message.data.toString());
        
        // Refresh list when app is opened via notification
        _refreshNotificationList();
      });

      // Check if the app was opened from a terminated state via a notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        print('🚀 [FCM] App launched from TERMINATED state via notification');
        print('📩 [FCM] Data: ${initialMessage.data}');
        _handleNotificationClick(initialMessage.data.toString());
        _refreshNotificationList();
      }

      // 6. Get and Print FCM Token
      await getToken();


    } catch (e) {
      print('❌ [FCM] Error initializing notifications: $e');
    }
  }

  /// Get FCM Token
  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('🔑 [FCM] TOKEN: $token');
      return token;
    } catch (e) {
      print('❌ [FCM] Error getting FCM token: $e');
      return null;
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
        payload: message.data.toString(),
      );
    }
  }

  /// Handle Notification Click
  void _handleNotificationClick(String? payload) {
    if (payload != null) {
      log('Notification Payload: $payload');
      // TODO: Implement navigation based on payload
      // Example: Use Get.toNamed() or GoRouter.of(context).push()
    }
  }

  /// Subscribe to Topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    log('Subscribed to topic: $topic');
  }

  /// Unsubscribe from Topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    log('Unsubscribed from topic: $topic');
  }

  /// Helper to refresh the notification list
  void _refreshNotificationList() {
    try {
      if (Get.isRegistered<NotificationBloc>()) {
        Get.find<NotificationBloc>().add(const NotificationEvent.load());
      }
    } catch (e) {
      log('Error refreshing notifications: $e');
    }
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
  log("Handling a background message: ${message.messageId}");
}
