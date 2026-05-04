import '../../domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final String type;
  final bool isRead;
  final String group;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isRead,
    required this.group,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // Frappe Notification Log fields:
    // name -> id
    // subject -> title
    // email_content -> description
    // read -> isRead
    // creation -> time
    // type -> type (Alert, Message, etc.)
    
    return NotificationModel(
      id: json['name'] as String? ?? '',
      title: json['subject'] as String? ?? '',
      description: json['email_content'] as String? ?? '',
      time: json['creation'] as String? ?? '',
      type: json['type'] as String? ?? 'policy',
      isRead: (json['read'] as int? ?? 0) == 1,
      group: '', // Will be calculated by UI or logic if needed
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
    );
  }

  static String _stripHtml(String htmlString) {
    // Basic HTML stripping if necessary
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  static NotificationType _mapType(String type) {
    switch (type.toLowerCase()) {
      case 'alert':
        return NotificationType.policy;
      case 'message':
        return NotificationType.team;
      default:
        return NotificationType.policy;
    }
  }
}

