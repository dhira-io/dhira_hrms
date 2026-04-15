import 'env.dart';

/// Immutable configuration for a specific [Environment].
///
/// Contains all environment-specific values:
/// - API base URL
/// - SSO callback scheme
/// - Logging / Chucker / dev tools toggles
///
/// Access the current config via [AppConfigService.config], not directly.
class AppConfig {
  final String appName;
  final String baseUrl;
  final String ssoCallbackScheme;
  final bool enableLogs;
  final bool enableChucker;
  final bool enableDevTools;

  const AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.ssoCallbackScheme,
    required this.enableLogs,
    required this.enableChucker,
    required this.enableDevTools,
  });

  /// Returns the [AppConfig] for the given [env].
  static AppConfig forEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        return const AppConfig(
          appName: 'DHIRA Dev',
          baseUrl: 'https://dev-hrms.akashic.dhira.io/',
          ssoCallbackScheme: 'com.dhira.hrms.dev',
          enableLogs: true,
          enableChucker: true,
          enableDevTools: true,
        );
      case Environment.qa:
        return const AppConfig(
          appName: 'DHIRA QA',
          baseUrl: 'https://qa-hrms.akashic.dhira.io/',
          ssoCallbackScheme: 'com.dhira.hrms.qa',
          enableLogs: true,
          enableChucker: true,
          enableDevTools: true,
        );
      case Environment.prod:
        return const AppConfig(
          appName: 'DHIRA',
          baseUrl: 'https://hrms.akashic.dhira.io/',
          ssoCallbackScheme: 'com.dhira.hrms',
          enableLogs: false,
          enableChucker: false,
          enableDevTools: false,
        );
    }
  }
}
