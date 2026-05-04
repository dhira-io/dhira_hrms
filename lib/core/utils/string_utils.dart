import '../constants/app_constants.dart';

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

  static String stripHtml(String htmlString) {
    if (htmlString.isEmpty) return htmlString;
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}

extension StringExtensions on String {
  /// Whether the string is a full URL (starts with http/https).
  bool get isAbsoluteUrl => startsWith(AppConstants.httpPrefix);

  /// Removes HTML tags and &nbsp; entities.
  String get stripHtml => StringUtils.stripHtml(this);

  /// Converts the string to an absolute URL using the provided base URL.
  String toAbsoluteUrl(String baseUrl) {
    if (isAbsoluteUrl) return this;
    return '${AppConstants.baseUrl}$baseUrl';
  }
}
