import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/notification_model.dart';
import 'dart:developer' as dev;

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset});
  Future<void> markAllAsRead();
  Future<void> storeFcmToken(String token);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dioClient;

  NotificationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset}) async {
    try {
      print('📡 [NotificationAPI] Request: limit=$limit, offset=$offset');
      
      final response = await dioClient.post(
        '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs',
        data: {
          'limit': limit ?? 20,
          'limit_start': offset ?? 0,
        },
      );

      print('📡 [NotificationAPI] Status: ${response.statusCode}');
      print('📡 [NotificationAPI] Body: ${response.data}');

      final dynamic message = response.data['message'];

      if (message != null) {
        List<dynamic> list = [];

        if (message is List) {
          list = message;
        } else if (message is Map) {
          // Frappe sometimes returns { "message": { "notifications": [...], "count": 10 } }
          list = (message['notification_logs'] ?? message['notifications'] ?? message['data'] ?? message['results']) as List? ?? [];
        }

        print('📡 [NotificationAPI] Successfully parsed ${list.length} items');
        return list.map((json) => NotificationModel.fromJson(json as Map<String, dynamic>)).toList();
      }
      
      print('📡 [NotificationAPI] Message field is null or missing. Full Response: ${response.data}');
      return [];
    } catch (e, stack) {
      print('❌ [NotificationAPI] Exception: $e');
      if (e is DioException) {
        print('❌ [NotificationAPI] Dio Error Data: ${e.response?.data}');
      }
      print('❌ [NotificationAPI] StackTrace: $stack');
      return [];
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await dioClient.post(
        '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_all_as_read',
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } catch (e) {
      print('❌ [NotificationAPI] Error marking all read: $e');
    }
  }

  @override
  Future<void> storeFcmToken(String token) async {
    print('📝 [FCM] storeFcmToken: $token');
  }
}
