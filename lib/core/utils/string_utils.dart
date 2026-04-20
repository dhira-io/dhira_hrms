class StringUtils {
  static String formatNameFromEmail(String email, {bool capitalizeEach = false}) {
    // 1. Remove domain part (everything from '@' onward)
    final atIndex = email.indexOf('@');
    String namePart = (atIndex >= 0) ? email.substring(0, atIndex) : email;

    // 2. Replace the first dot (.) with a space
    namePart = namePart.replaceFirst('.', ' ');

    if (capitalizeEach) {
      // 3. Capitalize each word
      final parts = namePart.split(' ');
      final capitalized = parts.map((w) {
        if (w.isEmpty) return w;
        return w[0].toUpperCase() + w.substring(1);
      }).toList();
      namePart = capitalized.join(' ');
    }
    return namePart;
  }
}

extension StringExtensions on String {
  /// Whether the string is a full URL (starts with http/https).
  bool get isAbsoluteUrl => startsWith('http');
}
