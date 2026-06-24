extension DoubleFormatX on double {
  /// Formats the double as a string with 0 or 1 decimal places depending on
  /// whether it has a fractional part.
  /// Example:
  /// - `48.0` -> `'48'`
  /// - `9.5` -> `'9.5'`
  String formatHours() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }
}
