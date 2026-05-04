import '../../../../core/network/dio_client.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAllAsRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dioClient;

  NotificationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final response = await dioClient.post(
      '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs',
      data: {'limit': 20},
    );

    final dynamic message = response.data['message'];

    if (message != null) {
      List<dynamic> list = [];

      if (message is List) {
        list = message;
      } else if (message is Map && message.containsKey('notifications')) {
        // Handle case where Frappe returns a Map containing the list
        list = message['notifications'] as List? ?? [];
      } else if (message is Map && message.containsKey('data')) {
        // Another common Frappe pattern
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
}
