import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'env.dart';
import 'app_config.dart';

/// Manages the active environment and supports runtime switching in dev/QA.
///
/// Architecture:
/// - `--dart-define=ENV=...` sets the compile-time default via [EnvConfig].
/// - In non-prod builds, the user can override the environment at runtime.
/// - The override is persisted to [SharedPreferences] → survives app restart.
/// - When the environment changes, [onEnvironmentChanged] emits so the DI
///   layer can re-initialize the network stack.
/// - Runtime switching is **completely blocked** in prod compile-time builds.
class AppConfigService {
  static const String _envOverrideKey = 'env_override';

  final SharedPreferences _prefs;

  late Environment _activeEnvironment;
  late AppConfig _activeConfig;

  /// Stream that fires when the environment is switched at runtime.
  final _envChangeController = StreamController<Environment>.broadcast();
  Stream<Environment> get onEnvironmentChanged => _envChangeController.stream;

  AppConfigService(this._prefs);

  /// Initialize: check for a persisted override, else use compile-time default.
  /// Must be called once at app startup before accessing [config].
  void init() {
    final override = _prefs.getString(_envOverrideKey);
    if (override != null && !EnvConfig.isCompileTimeProd) {
      // Only honor persisted overrides in non-prod builds
      _activeEnvironment = Environment.values.firstWhere(
        (e) => e.name == override,
        orElse: () => EnvConfig.compileTimeDefault,
      );
    } else {
      _activeEnvironment = EnvConfig.compileTimeDefault;
    }
    _activeConfig = AppConfig.forEnvironment(_activeEnvironment);
  }

  /// The currently active environment.
  Environment get environment => _activeEnvironment;

  /// The currently active configuration.
  AppConfig get config => _activeConfig;

  /// Switch environment at runtime (dev/QA builds only).
  ///
  /// Returns `true` if the switch was successful, `false` if blocked (prod).
  /// After switching, consumers should call
  /// `DependencyInjection.reinitializeNetwork()` to re-create the DioClient.
  Future<bool> switchEnvironment(Environment newEnv) async {
    // Hard gate: never allow runtime switching in prod builds
    if (EnvConfig.isCompileTimeProd) return false;

    _activeEnvironment = newEnv;
    _activeConfig = AppConfig.forEnvironment(newEnv);
    await _prefs.setString(_envOverrideKey, newEnv.name);
    _envChangeController.add(newEnv);
    return true;
  }

  /// Clear the persisted override and revert to compile-time default.
  Future<void> clearOverride() async {
    await _prefs.remove(_envOverrideKey);
    _activeEnvironment = EnvConfig.compileTimeDefault;
    _activeConfig = AppConfig.forEnvironment(_activeEnvironment);
    _envChangeController.add(_activeEnvironment);
  }

  void dispose() {
    _envChangeController.close();
  }
}
