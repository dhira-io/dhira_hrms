class DashboardUtils {
  DashboardUtils._();

  /// Formats the holiday string by taking the first two segments separated by '-'
  /// Example: '15-Aug-2023' -> '15 Aug'
  static String formatHoliday(String holiday) {
    if (holiday.isEmpty) return holiday;
    final parts = holiday.split('-');
    if (parts.length >= 2) {
      return parts.sublist(0, 2).join(' ');
    }
    return holiday;
  }
}
