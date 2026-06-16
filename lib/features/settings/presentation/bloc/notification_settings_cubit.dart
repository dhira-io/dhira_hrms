import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../approvals/domain/usecases/get_approvals_access_usecase.dart';
import '../../domain/entities/notification_settings_entity.dart';
import '../../domain/repositories/notification_settings_repository.dart';
import 'notification_settings_state.dart';
import '../../data/constants/notification_settings_constants.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final INotificationSettingsRepository _repository;
  final GetApprovalsAccessUseCase _getApprovalsAccessUseCase;

  NotificationSettingsCubit(
    this._repository,
    this._getApprovalsAccessUseCase,
  ) : super(const NotificationSettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final accessResult = await _getApprovalsAccessUseCase();
      final isManager = accessResult.fold(
        (_) => false,
        (access) => access.canAccess,
      );

      final settings = await _repository.getSettings();
      emit(state.copyWith(
        isLoading: false,
        settings: settings,
        isManager: isManager,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> toggleItem(
    String sectionId,
    String itemId,
    bool value,
    AppLocalizations l10n,
  ) async {
    if (state.settings == null || state.isActionLoading) return;

    // Set individual item loading state
    final updatedSettings = _updateItemLoadingState(itemId, true);
    emit(state.copyWith(settings: updatedSettings, isActionLoading: true));

    try {
      // The itemId in entity matches the API field name
      await _repository.updateItem(itemId, value);

      // Update local state value and reset loading
      final finalSettings = _updateItemValue(itemId, value);
      emit(state.copyWith(settings: finalSettings, isActionLoading: false));

      if (itemId.startsWith('push_')) {
        ToastUtils.showSuccess(l10n.pushNotificationPreferenceSuccess);
      } else if (itemId.startsWith('email_')) {
        ToastUtils.showSuccess(l10n.emailAlertsPreferenceSuccess);
      }
    } catch (e) {
      // Reset loading on error
      final resetSettings = _updateItemLoadingState(itemId, false);
      emit(
        state.copyWith(
          settings: resetSettings,
          isActionLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  NotificationSettingsEntity _updateItemLoadingState(
    String itemId,
    bool isLoading,
  ) {
    final updatedSections = state.settings!.sections.map((section) {
      final updatedItems = section.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isLoading: isLoading);
        }
        return item;
      }).toList();
      return section.copyWith(items: updatedItems);
    }).toList();
    return state.settings!.copyWith(sections: updatedSections);
  }

  NotificationSettingsEntity _updateItemValue(String itemId, bool value) {
    final updatedSections = state.settings!.sections.map((section) {
      final updatedItems = section.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(value: value, isLoading: false);
        }
        return item;
      }).toList();
      return section.copyWith(items: updatedItems);
    }).toList();
    return state.settings!.copyWith(sections: updatedSections);
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
