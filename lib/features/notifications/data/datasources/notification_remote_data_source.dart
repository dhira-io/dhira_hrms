import '../../../../core/network/dio_client.dart';
import '../constants/notification_constants.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset});
  Future<void> markAllAsRead();
  Future<void> markAsRead(String id);
  Future<void> storeFcmToken(String token);
  Future<void> deactivateDevice(String token);
}


class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dioClient;

  NotificationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications({int? limit, int? offset}) async {
    try {
      final response = await dioClient.get(
        NotificationApiConstants.getNotifications,
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
    } on Exception catch (e) {
      // Re-throw to be caught by repository and turned into a Failure
      print('❌ [NotificationAPI] Error fetching notifications: $e');
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    await dioClient.post(
      NotificationApiConstants.markAllAsRead,
    );
  }

  @override
  Future<void> markAsRead(String id) async {
    await dioClient.post(
      NotificationApiConstants.markAsRead,
      data: {'docname': id},
    );
  }

  @override
  Future<void> storeFcmToken(String token) async {
    await dioClient.post(
      NotificationApiConstants.registerDevice,
      data: {'token': token},
    );
  }

  @override
  Future<void> deactivateDevice(String token) async {
    await dioClient.post(
      NotificationApiConstants.deactivateDevice,
      data: {'token': token},
    );
  }
}
