class NotificationApiConstants {
  static const String getNotifications =
      '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs';
  static const String markAllAsRead =
      '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_all_as_read';
  static const String markAsRead =
      '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_as_read';

  // Firebase FCM
  static const String registerDevice =
      '/api/method/dhira_hrms.api.firebase.register_device';
  static const String deactivateDevice =
      '/api/method/dhira_hrms.api.firebase.deactivate_device';
}

class NotificationGroupConstants {
  static const String groupToday = 'Today';
  static const String groupYesterday = 'Yesterday';
  static const String groupEarlier = 'Earlier';

  static const List<String> groupOrder = [
    groupToday,
    groupYesterday,
    groupEarlier,
  ];
}

class LocalNotificationConstants {
  static const String channelId = 'high_importance_channel_v2';
  static const String channelName = 'High Importance Notifications';
  static const String channelDescription =
      'This channel is used for important notifications.';
  static const String iconPath = '@mipmap/ic_launcher';
}

class NotificationTypeKeys {
  static const String alert = 'alert';
  static const String policy = 'policy';
  static const String leave = 'leave';
  static const String leaveApplication = 'leave application';
  static const String attendance = 'attendance';
  static const String attendanceRegularization = 'attendance regularization';
  static const String timesheet = 'timesheet';
}

class PushNotificationPayloadKeys {
  static const String isBulk = 'is_bulk';
  static const String count = 'count';
  static const String items = 'items';
  static const String mobileUrl = 'mobile_url';
  static const String type = 'type';
  static const String referenceDoctype = 'reference_doctype';
  static const String referenceName = 'reference_name';
  static const String docName = 'docname';
  static const String title = 'title';
  static const String subject = 'subject';
  static const String message = 'message';
  static const String content = 'content';
  static const String body = 'body';
}

class PushNotificationValues {
  static const String trueString = '1';
  static const String defaultCount = '0';
  static const String defaultItemsJson = '[]';

  static const String genericPendingTitle = 'Pending Approvals';
  static const String genericPendingBody =
      'You have pending approvals requiring your attention.';

  static const String appPrefixWithSlashes = '/app/';
  static const String appPrefix = 'app/';

  // URL roots
  static const String urlNotifications = 'notifications';
  static const String urlLeaveApplication = 'leave-application';
  static const String urlLeave = 'leave';
  static const String urlTimesheet = 'timesheet';
  static const String urlAttendance = 'attendance';
  static const String urlRegularization = 'regularization';
  static const String urlAttendanceRegularization = 'attendance-regularization';
  static const String urlPerformance = 'performance';
  static const String urlSelfAssessment = 'self-assessment';

  static const String defaultTitle = 'New Notification';
}
