import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
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
      title:
          (json['subject'] ?? json['title'] ?? json['message'])?.toString() ??
          PushNotificationValues.noSubject,
      description:
          (json['email_content'] ??
                  json['content'] ??
                  json['body'] ??
                  json['description'])
              ?.toString() ??
          PushNotificationValues.defaultDescription,
      // Fallback to 'modified' if 'creation' is missing
      time: json['creation']?.toString() ?? json['modified']?.toString() ?? '',
      // Prefer document_type for redirection logic
      type:
          (json['document_type'] ?? json['type'])?.toString() ??
          NotificationTypeKeys.alert,
      isRead: isReadValue,
      group: '',
      docName: json['document_name']?.toString() ?? '',
    );
  }

  NotificationEntity toEntity() {
    // Handle Frappe's time format (usually UTC) and convert to local
    final DateTime parsedTime = DateTimeUtils.isISOFormat(time)
        ? DateTime.parse(time)
        : DateTime.tryParse(time.replaceFirst(' ', 'T')) ?? DateTime.now();

    return NotificationEntity(
      id: id,
      title: _stripHtml(title),
      description: _stripHtml(description),
      time: parsedTime,
      type: _mapType(type),
      isRead: isRead,
      group: group,
      rawType: type,
      docName: docName,
    );
  }

  static String _stripHtml(String input) {
    if (input.isEmpty) return '';

    String text = input.trim();

    // 1. Try to parse as JSON or Python-style dict string
    final trimmed = input.trim();
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      try {
        // Attempt 1: Standard JSON decode
        final Map<String, dynamic> data = jsonDecode(trimmed);
        if (data.containsKey('message')) {
          text = data['message'].toString();
        } else if (data.containsKey('content')) {
          text = data['content'].toString();
        } else if (data.containsKey('body')) {
          text = data['body'].toString();
        }
      } catch (_) {
        try {
          // Attempt 2: Python-style dict (single quotes) to JSON
          // Replace single quotes with double quotes, but be wary of nested quotes
          // This is a naive implementation but often works for simple dicts
          String jsonReady = trimmed
              .replaceAll("': '", '": "')
              .replaceAll("', '", '", "')
              .replaceAll("{'", '{"')
              .replaceAll("'}", '"}')
              .replaceAll("': ", '": ');

          final Map<String, dynamic> data = jsonDecode(jsonReady);
          if (data.containsKey('message')) {
            text = data['message'].toString();
          } else if (data.containsKey('content')) {
            text = data['content'].toString();
          } else if (data.containsKey('body')) {
            text = data['body'].toString();
          }
        } catch (_) {
          // Attempt 3: More flexible extraction
          // Look for "message": "...", 'message': '...', message: "...", etc.
          final patterns = [
            RegExp(
              r"['"
              "]?message['"
              "]?:\s*['"
              "](.*?)['"
              "](?=\s*[,}])",
              dotAll: true,
            ),
            RegExp(
              r"['"
              "]?content['"
              "]?:\s*['"
              "](.*?)['"
              "](?=\s*[,}])",
              dotAll: true,
            ),
            RegExp(
              r"['"
              "]?body['"
              "]?:\s*['"
              "](.*?)['"
              "](?=\s*[,}])",
              dotAll: true,
            ),
          ];

          for (final pattern in patterns) {
            final match = pattern.firstMatch(trimmed);
            if (match != null && match.groupCount >= 1) {
              text = match.group(1) ?? text;
              break;
            }
          }
        }
      }
    }

    // 2. Strip HTML tags and entities
    return text
        .replaceAll(RegExp(r'<[^>]*>'), ' ') // Basic tag removal
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll(RegExp(r'\s+'), ' ') // Normalize whitespace
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
