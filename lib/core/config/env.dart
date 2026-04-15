/// Supported application environments.
enum Environment { dev, qa, prod }

/// Reads the compile-time `--dart-define=ENV=...` value.
///
/// This serves as the DEFAULT environment for runtime —
/// it can be overridden in dev/QA via [AppConfigService].
///
/// Usage:
/// ```bash
/// flutter run --flavor dev --dart-define=ENV=dev
/// flutter run --flavor qa --dart-define=ENV=qa
/// flutter run --flavor prod --dart-define=ENV=prod
/// ```
class EnvConfig {
  EnvConfig._();

  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');

  /// The compile-time default environment determined by `--dart-define`.
  static Environment get compileTimeDefault {
    switch (_env) {
      case 'qa':
        return Environment.qa;
      case 'prod':
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }

  /// Whether the app was compiled for production.
  /// Used as a hard gate to block dev tools and runtime switching.
  static bool get isCompileTimeProd => compileTimeDefault == Environment.prod;
}
