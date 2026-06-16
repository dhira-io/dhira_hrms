class NumberUtils {
  /// Formats a 0-based index as a 2-digit padded serial number string (e.g. 0 -> '01', 9 -> '10').
  static String formatSerialNumber(int index) {
    return (index + 1).toString().padLeft(2, '0');
  }
}
