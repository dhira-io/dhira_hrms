class NotificationApiConstants {

  static const String getNotifications = '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs';
  static const String markAllAsRead = '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_all_as_read';
  static const String markAsRead = '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_as_read';
  
  // Firebase FCM
  static const String registerDevice = '/api/method/dhira_hrms.api.firebase.register_device';
  static const String deactivateDevice = '/api/method/dhira_hrms.api.firebase.deactivate_device';
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
