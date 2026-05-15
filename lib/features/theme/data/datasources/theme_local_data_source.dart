import 'package:flutter/material.dart';
import '../../../../core/services/local_storage_service.dart';

abstract class IThemeLocalDataSource {
  Future<void> saveThemeMode(ThemeMode mode);
  ThemeMode getThemeMode();
}

class ThemeLocalDataSourceImpl implements IThemeLocalDataSource {
  final LocalStorageService storageService;

  ThemeLocalDataSourceImpl(this.storageService);

  @override
  ThemeMode getThemeMode() {
    final modeStr = storageService.getThemeMode();
    if (modeStr == null) return ThemeMode.system;
    
    try {
      return ThemeMode.values.byName(modeStr);
    } catch (_) {
      return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    await storageService.saveThemeMode(mode.name);
  }
}
