import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorageService _storageService;

  ThemeCubit(this._storageService) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final modeStr = _storageService.getThemeModeString();
    emit(_mapStringToMode(modeStr));
  }

  Future<void> changeTheme(ThemeMode mode) async {
    await _storageService.saveThemeModeString(_mapModeToString(mode));
    emit(mode);
  }

  static ThemeMode _mapStringToMode(String mode) => switch (mode) {
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.system,
  };

  static String _mapModeToString(ThemeMode mode) => switch (mode) {
    ThemeMode.dark => 'dark',
    ThemeMode.light => 'light',
    ThemeMode.system => 'system',
  };
}
