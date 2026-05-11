class ApiConstants {
  static const String baseUrl = "https://dev-api.hrms.dhira.io/";

  // Notifications
  static const String getNotifications = '/api/method/frappe.desk.doctype.notification_log.notification_log.get_notification_logs';
  static const String markAllAsRead = '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_all_as_read';
  static const String markAsRead = '/api/method/frappe.desk.doctype.notification_log.notification_log.mark_as_read';
}
