import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/env.dart';
import '../config/app_config.dart';
import '../config/app_config_service.dart';
import '../di/dependency_injection.dart';
import '../routing/app_router.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

/// Wraps the child widget with a floating dev tools button in dev/QA builds.
///
/// The FAB displays the current environment name (color-coded) and tapping
/// it opens a bottom sheet to switch environments at runtime.
///
/// This widget is completely removed in prod compile-time builds via
/// [EnvConfig.isCompileTimeProd] — there is zero overhead in production.
class DevToolsOverlay extends StatefulWidget {
  final Widget child;
  const DevToolsOverlay({super.key, required this.child});

  @override
  State<DevToolsOverlay> createState() => _DevToolsOverlayState();
}

class _DevToolsOverlayState extends State<DevToolsOverlay> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    if (!EnvConfig.isCompileTimeProd) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _insertOverlay();
      });
    }
  }

  void _insertOverlay() {
    // Wait until the navigator is definitely available
    final overlayState = AppRouter.navigatorKey.currentState?.overlay;
    if (overlayState == null) {
      // If not available yet, try again next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _insertOverlay();
      });
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 16,
        bottom: 100,
        child: Material(
          type: MaterialType.transparency,
          child: _EnvIndicatorFAB(),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return the child unmodified to prevent layout boundary/semantics collisions
    return widget.child;
  }
}

class _EnvIndicatorFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final configService = Get.find<AppConfigService>();
    final env = configService.environment;

    return FloatingActionButton.small(
      heroTag: 'dev_tools_fab',
      backgroundColor: _envColor(env),
      onPressed: () => _showEnvSwitcher(context),
      child: Text(
        env.name.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _envColor(Environment env) {
    switch (env) {
      case Environment.dev:
        return Colors.green;
      case Environment.qa:
        return Colors.orange;
      case Environment.prod:
        return Colors.red;
    }
  }

  void _showEnvSwitcher(BuildContext context) {
    final configService = Get.find<AppConfigService>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Switch Environment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ...Environment.values.map((env) => ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: _envColor(env),
                    size: 16,
                  ),
                  title: Text(env.name.toUpperCase()),
                  subtitle: Text(AppConfig.forEnvironment(env).baseUrl),
                  trailing: configService.environment == env
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () async {
                    Navigator.pop(context);
                    if (configService.environment != env) {
                      final switched =
                          await configService.switchEnvironment(env);
                      if (switched) {
                        // Re-initialize network layer with new config
                        DependencyInjection.reinitializeNetwork();
                        // Navigate to splash to force a fresh auth check
                        AppRouter.router.go('/');
                      }
                    }
                  },
                )),
            if (configService.config.enableChucker) ...[
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.network_check, color: Colors.blue),
                title: const Text('Network Logs (Chucker)'),
                subtitle: const Text('Inspect API requests and responses'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  ChuckerFlutter.showChuckerScreen();
                },
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
