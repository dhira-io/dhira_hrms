class RegexUtils {
  RegexUtils._();

  /// Regex to extract numbers before 'h' (e.g., "9h 30m" -> 9)
  static final RegExp hoursRegex = RegExp(r'(\d+)h');

  /// Regex to extract numbers before 'm' (e.g., "9h 30m" -> 30)
  static final RegExp minutesRegex = RegExp(r'(\d+)m');

  /// Safely extracts an integer value from a string using a regex pattern.
  static int? extractInt(String text, RegExp regex, {int group = 1}) {
    final match = regex.firstMatch(text);
    if (match != null && match.groupCount >= group) {
      return int.tryParse(match.group(group)!);
    }
    return null;
  }

  /// Specialized method to parse time strings like "1h 30m" into (hours, minutes)
  static (int hours, int minutes) parseHoursMinutes(String text) {
    final hours = extractInt(text, hoursRegex) ?? 0;
    final minutes = extractInt(text, minutesRegex) ?? 0;
    return (hours, minutes);
  }
}
