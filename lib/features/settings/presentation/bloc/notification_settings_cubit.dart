import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/approvals/domain/usecases/get_approvals_access_usecase.dart';
import 'package:dhira_hrms/features/settings/domain/entities/notification_settings_entity.dart';
import 'package:dhira_hrms/features/settings/domain/usecases/get_notification_settings_usecase.dart';
import 'package:dhira_hrms/features/settings/domain/usecases/update_notification_settings_usecase.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_state.dart';
import 'package:dhira_hrms/features/settings/data/constants/notification_settings_constants.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final GetNotificationSettingsUseCase _getNotificationSettingsUseCase;
  final UpdateNotificationSettingsUseCase _updateNotificationSettingsUseCase;
  final GetApprovalsAccessUseCase _getApprovalsAccessUseCase;

  NotificationSettingsCubit(
    this._getNotificationSettingsUseCase,
    this._updateNotificationSettingsUseCase,
    this._getApprovalsAccessUseCase,
  ) : super(const NotificationSettingsState.initial()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    emit(const NotificationSettingsState.loading());
    try {
      final accessResult = await _getApprovalsAccessUseCase();
      final isManager = accessResult.fold(
        (_) => false,
        (access) => access.canAccess,
      );

      final settingsResult = await _getNotificationSettingsUseCase(NoParams());

      settingsResult.fold(
        (failure) {
          emit(NotificationSettingsState.error(failure.message));
        },
        (settings) {
          emit(
            NotificationSettingsState.loaded(
              settings: settings,
              isManager: isManager,
            ),
          );
        },
      );
    } catch (e) {
      emit(NotificationSettingsState.error(e.toString()));
    }
  }

  void clearError() {
    state.maybeWhen(
      loaded: (settings, isManager, isActionLoading, errorMessage) {
        if (errorMessage != null) {
          emit(
            NotificationSettingsState.loaded(
              settings: settings,
              isManager: isManager,
              isActionLoading: isActionLoading,
              errorMessage: null,
            ),
          );
        }
      },
      orElse: () {},
    );
  }

  Future<void> toggleItem(
    String sectionId,
    String itemId,
    bool value,
    AppLocalizations l10n,
  ) async {
    state.maybeWhen(
      loaded: (settings, isManager, isActionLoading, errorMessage) async {
        if (isActionLoading) return;

        // Set individual item loading state
        final updatedSettings = _updateItemLoadingState(settings, itemId, true);
        emit(
          NotificationSettingsState.loaded(
            settings: updatedSettings,
            isManager: isManager,
            isActionLoading: true,
          ),
        );

        final result = await _updateNotificationSettingsUseCase(
          UpdateNotificationSettingsParams(field: itemId, value: value),
        );

        result.fold(
          (failure) {
            // Reset loading on error
            final resetSettings = _updateItemLoadingState(
              settings,
              itemId,
              false,
            );
            emit(
              NotificationSettingsState.loaded(
                settings: resetSettings,
                isManager: isManager,
                isActionLoading: false,
                errorMessage: failure.message,
              ),
            );
          },
          (_) {
            // Update local state value and reset loading
            final finalSettings = _updateItemValue(settings, itemId, value);
            emit(
              NotificationSettingsState.loaded(
                settings: finalSettings,
                isManager: isManager,
                isActionLoading: false,
              ),
            );

            if (itemId.startsWith('push_')) {
              ToastUtils.showSuccess(l10n.pushNotificationPreferenceSuccess);
            } else if (itemId.startsWith('email_')) {
              ToastUtils.showSuccess(l10n.emailAlertsPreferenceSuccess);
            }
          },
        );
      },
      orElse: () {},
    );
  }

  NotificationSettingsEntity _updateItemLoadingState(
    NotificationSettingsEntity settings,
    String itemId,
    bool isLoading,
  ) {
    final updatedSections = settings.sections.map((section) {
      final updatedItems = section.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isLoading: isLoading);
        }
        return item;
      }).toList();
      return section.copyWith(items: updatedItems);
    }).toList();
    return settings.copyWith(sections: updatedSections);
  }

  NotificationSettingsEntity _updateItemValue(
    NotificationSettingsEntity settings,
    String itemId,
    bool value,
  ) {
    final updatedSections = settings.sections.map((section) {
      final updatedItems = section.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(value: value, isLoading: false);
        }
        return item;
      }).toList();
      return section.copyWith(items: updatedItems);
    }).toList();
    return settings.copyWith(sections: updatedSections);
  }

  String getRowTitle(String baseId, AppLocalizations l10n) {
    switch (baseId) {
      case NotificationSettingsConstants.baseLeave:
        return l10n.leaveApplications;
      case NotificationSettingsConstants.baseAttendance:
        return l10n.attendanceRegularization;
      case NotificationSettingsConstants.baseTimesheet:
        return l10n.timesheet;
      case NotificationSettingsConstants.baseCompOff:
        return l10n.compOffRequest;
      default:
        return baseId;
    }
  }
}
