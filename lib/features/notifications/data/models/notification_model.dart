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
    // Handling Frappe's varied boolean/int 'read' status
    final readValue = json['read'];
    bool isReadValue = false;
    if (readValue is bool) {
      isReadValue = readValue;
    } else if (readValue is int) {
      isReadValue = readValue == 1;
    }

    return NotificationModel(
      id: json['name']?.toString() ?? '',
      title: json['subject']?.toString() ?? 'No Subject',
      description: json['email_content']?.toString() ?? '',
      // Fallback to 'modified' if 'creation' is missing
      time: json['creation']?.toString() ?? json['modified']?.toString() ?? '',
      type: json['type']?.toString() ?? 'alert',
      isRead: isReadValue,
      group: '', 
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
    if (htmlString.isEmpty) return "";
    // Basic HTML stripping and &nbsp; replacement
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ' ')
        .trim();
  }

  static NotificationType _mapType(String type) {
    switch (type.toLowerCase()) {
      case 'alert':
      case 'policy':
        return NotificationType.policy;
      case 'leave':
      case 'attendance':
        return NotificationType.leave;
      case 'team':
      case 'message':
        return NotificationType.team;
      default:
        return NotificationType.policy;
    }
  }
}
