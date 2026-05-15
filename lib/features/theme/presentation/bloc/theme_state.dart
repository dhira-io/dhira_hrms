import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.initial() = _Initial;
  const factory ThemeState.loading() = _Loading;
  const factory ThemeState.loaded(ThemeMode mode) = _Loaded;
  const factory ThemeState.error(String message) = _Error;
  const factory ThemeState.success(String message, ThemeMode mode) = _Success;
}
