import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// A secure logging utility that masks sensitive information and only logs in debug mode.
class SecureLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      dateTimeFormat: DateTimeFormat
          .dateAndTime, // Should each log print contain a timestamp
    ),
  );

  /// Keys that should be masked in log outputs
  static const List<String> _sensitiveKeys = [
    'password',
    'pwd',
    'token',
    'access_token',
    'refresh_token',
    'api_key',
    'api_secret',
    'sid',
    'authorization',
    'cookie',
    'set-cookie',
    'otp',
  ];

  /// Log a message at level [Level.debug].
  static void d(String message, [dynamic data]) {
    if (kDebugMode) {
      _logger.d(_formatMessage(message, data));
    }
  }

  /// Log a message at level [Level.info].
  static void i(String message, [dynamic data]) {
    if (kDebugMode) {
      _logger.i(_formatMessage(message, data));
    }
  }

  /// Log a message at level [Level.warning].
  static void w(String message, [dynamic data, dynamic error]) {
    if (kDebugMode) {
      _logger.w(_formatMessage(message, data), error: error);
    }
  }

  /// Log a message at level [Level.error].
  static void e(
    String message, {
    dynamic data,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      _logger.e(
        _formatMessage(message, data),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Public utility to mask sensitive data for external use (e.g., in interceptors)
  static dynamic mask(dynamic data) => _performMask(data);

  /// Format the message by appending masked data if provided
  static String _formatMessage(String message, dynamic data) {
    if (data == null) return message;
    try {
      final masked = mask(data);
      return '$message | Data: $masked';
    } catch (e) {
      return '$message | [Error masking data]';
    }
  }

  /// Recursively mask sensitive keys in a Map or List
  static dynamic _performMask(dynamic data) {
    if (data == null) return null;

    if (data is Map) {
      final Map<String, dynamic> maskedMap = {};
      data.forEach((key, value) {
        final String keyStr = key.toString().toLowerCase();
        if (_sensitiveKeys.any((k) => keyStr.contains(k))) {
          maskedMap[key.toString()] = '********';
        } else {
          maskedMap[key.toString()] = _performMask(value);
        }
      });
      return maskedMap;
    }

    if (data is List) {
      return data.map((item) => _performMask(item)).toList();
    }

    return data;
  }
}
