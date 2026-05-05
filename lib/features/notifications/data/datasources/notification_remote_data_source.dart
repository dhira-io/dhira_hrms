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
    final response = await dioClient.post(
      '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs',
      data: {
        if (limit != null) 'limit_page_length': limit,
        if (offset != null) 'limit_start': offset,
      },
    );

    final dynamic message = response.data['message'];

    if (message != null) {
      List<dynamic> list = [];

      if (message is List) {
        list = message;
      } else if (message is Map && message.containsKey('notifications')) {
        list = message['notifications'] as List? ?? [];
      } else if (message is Map && message.containsKey('data')) {
        list = message['data'] as List? ?? [];
      }

      return list.map((json) => NotificationModel.fromJson(json)).toList();
    }
    return [];
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
