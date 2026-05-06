import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorageService _storageService;

  ThemeCubit(this._storageService) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final isDarkMode = _storageService.getThemeMode();
    // For now, only supporting bool in storage, so map to Light/Dark
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> changeTheme(ThemeMode mode) async {
    await _storageService.saveThemeMode(mode == ThemeMode.dark);
    emit(mode);
  }
}
