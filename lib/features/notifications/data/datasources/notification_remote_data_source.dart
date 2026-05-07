import '../../../../core/network/dio_client.dart';
import '../models/notification_model.dart';

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
      print('📡 [NotificationAPI] Initiating fetch: limit=$limit, offset=$offset');
      
      print('📡 [NotificationAPI] Request (GET): limit=$limit, offset=$offset');
      
      final response = await dioClient.get(
        '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs',
        queryParameters: {
          'limit_page_length': limit ?? 20,
          'limit_start': offset ?? 0,
        },
      );

      print('📡 [NotificationAPI] Status: ${response.statusCode}');
      
      if (response.data == null) {
        print('📡 [NotificationAPI] Response data is null');
        return [];
      }

      final dynamic message = response.data['message'];
      print('📡 [NotificationAPI] Message type: ${message.runtimeType}');

      if (message != null) {
        List<dynamic> list = [];

        if (message is List) {
          list = message;
        } else if (message is Map) {
          print('📡 [NotificationAPI] Message Keys: ${message.keys}');
          // Checking all known Frappe notification keys
          list = (message['notification_logs'] ?? 
                  message['notifications'] ?? 
                  message['data'] ?? 
                  message['results']) as List? ?? [];
        }

        print('📡 [NotificationAPI] Successfully parsed ${list.length} items');
        return list.map((json) => NotificationModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      print('📡 [NotificationAPI] Message field is null or missing. Full Body: ${response.data}');
      return [];
    } catch (e, stack) {
      print('❌ [NotificationAPI] Error: $e');
      print('❌ [NotificationAPI] StackTrace: $stack');
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
  Future<void> storeFcmToken(String token) async {
    // TODO: Update with actual API endpoint when available
    // await dioClient.post(
    //   '/api/method/dhira_hrms.api.notification.store_fcm_token',
    //   data: {'fcm_token': token},
    // );
    print('📝 [FCM] storeFcmToken called with: $token (API currently disabled)');
  }
}
