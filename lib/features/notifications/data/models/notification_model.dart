import '../../domain/entities/notification_entity.dart';
import 'package:intl/intl.dart';

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
    return NotificationModel(
      id: json['name'] as String? ?? '',
      title: json['subject'] as String? ?? '',
      description: json['email_content'] as String? ?? '',
      time: (json['creation'] ?? json['modified']) as String? ?? '',
      type: json['type'] as String? ?? 'policy',
      isRead: json['read'] == 1 || json['read'] == true,
      group: '', 
    );
  }

  NotificationEntity toEntity() {
    final dateTime = DateTime.tryParse(time) ?? DateTime.now();
    return NotificationEntity(
      id: id,
      title: title,
      description: _stripHtml(description),
      time: dateTime,
      type: _mapType(type),
      isRead: isRead,
      group: _calculateGroup(dateTime),
    );
  }

  static String _calculateGroup(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else {
      return 'Earlier';
    }
  }

  static String _stripHtml(String htmlString) {
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
