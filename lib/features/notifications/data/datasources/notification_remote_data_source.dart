import '../../../../core/network/dio_client.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset});
  Future<void> markAllAsRead();
  Future<void> markAsRead(String id);
  Future<void> storeFcmToken(String token);
}


class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dioClient;

  NotificationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset}) async {
    try {
      final response = await dioClient.get(
        '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs',
        queryParameters: {
          'limit_page_length': limit ?? 20,
          'limit_start': offset ?? 0,
        },
      );

      final dynamic message = response.data['message'];

      if (message != null) {
        List<dynamic> list = [];

        if (message is List) {
          list = message;
        } else if (message is Map) {
          // Checking all known Frappe notification keys
          list = (message['notification_logs'] ?? 
                  message['notifications'] ?? 
                  message['data'] ?? 
                  message['results']) as List? ?? [];
        }

        return list.map((json) => NotificationModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      // Keep essential error logging
      print('❌ [NotificationAPI] Error: $e');
      return [];
    }
  }

  @override
  Future<void> markAllAsRead() async {
    await dioClient.post(
      '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_all_as_read',
    );
  }

  @override
  Future<void> markAsRead(String id) async {
    await dioClient.post(
      '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_as_read',
      data: {'docname': id},
    );
  }

  @override
  Future<void> storeFcmToken(String token) async {
    // TODO: Update with actual API endpoint when available
    // await dioClient.post(
    //   '/api/method/dhira_hrms.api.notification.store_fcm_token',
    //   data: {'fcm_token': token},
    // );
    print('📝 [FCM] storeFcmToken called with: $token (API currently disabled)');
  }
}
