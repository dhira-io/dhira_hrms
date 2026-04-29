import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/profile/domain/entities/profile_entities.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    ProfileEntity? userProfile,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    String? successMessage,
    @Default(false) bool isLoggedOut,
  }) = _SettingsState;
}
