import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_entity.dart';
import '../constants/notification_constants.dart';

part 'notification_model.freezed.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String description,
    required String time,
    required String type,
    required bool isRead,
    @Default('') String group,
    @Default('') String docName,
  }) = _NotificationModel;

  const NotificationModel._();

  /// Custom fromJson to handle Frappe's field naming and mixed bool/int
  /// 'read' field — does NOT delegate to the generated _$NotificationModelFromJson.
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final readValue = json['read'];
    bool isReadValue = false;
    if (readValue is bool) {
      isReadValue = readValue;
    } else if (readValue is int) {
      isReadValue = readValue == 1;
    }

    return NotificationModel(
      id: json['name']?.toString() ?? '',
      title: (json['subject'] ?? json['title'] ?? json['message'])?.toString() ?? 'No Subject',
      description: (json['email_content'] ?? json['content'] ?? json['body'] ?? json['description'])?.toString() ?? '',
      // Fallback to 'modified' if 'creation' is missing
      time: json['creation']?.toString() ??
          json['modified']?.toString() ??
          '',
      // Prefer document_type for redirection logic
      type: (json['document_type'] ?? json['type'])?.toString() ?? NotificationTypeKeys.alert,
      isRead: isReadValue,
      group: '',
      docName: json['document_name']?.toString() ?? '',
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      description: _stripHtml(description),
      time: DateTime.tryParse(time) ?? DateTime.now(),
      type: _mapType(type),
      isRead: isRead,
      group: group,
      rawType: type,
      docName: docName,
    );
  }

  static String _stripHtml(String htmlString) {
    if (htmlString.isEmpty) return '';
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ' ')
        .trim();
  }

  static NotificationType _mapType(String type) {
    switch (type.toLowerCase()) {
      case NotificationTypeKeys.alert:
      case NotificationTypeKeys.policy:
        return NotificationType.policy;
      case NotificationTypeKeys.leave:
      case NotificationTypeKeys.leaveApplication:
      case NotificationTypeKeys.attendance:
      case NotificationTypeKeys.attendanceRegularization:
        return NotificationType.leave;
      case NotificationTypeKeys.timesheet:
        return NotificationType.timesheet;
      case 'team':
      case 'message':
        return NotificationType.team;
      default:
        return NotificationType.policy;
    }
  }
}
