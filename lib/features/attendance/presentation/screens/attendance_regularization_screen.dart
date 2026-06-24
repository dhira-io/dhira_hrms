import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_regularization_bloc.dart';
import '../bloc/attendance_regularization_state.dart';
import '../widgets/attendance_regularization_body.dart';
import '../../../../core/widgets/common_app_bar.dart';
import 'package:get/get.dart';

class AttendanceRegularizationScreen extends StatelessWidget {
  const AttendanceRegularizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<
      AttendanceRegularizationBloc,
      AttendanceRegularizationState
    >(
      listenWhen: (previous, current) => current.maybeMap(
        error: (_) => true,
        success: (_) =>
            previous.maybeMap(success: (_) => false, orElse: () => true),
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          error: (_, message, validationError) => ToastUtils.showError(
            message ?? _validationMessage(l10n, validationError),
          ),
          success: (_, kind) {
            if (kind == RegularizationSuccessKind.fileUpload) {
              ToastUtils.showSuccess(l10n.fileUploadSuccess);
            }
            if (kind == RegularizationSuccessKind.submission) {
              // Switch to Approvals tab and show Raised Requests for Attendance
              Get.find<BottomNavCubit>().changeIndex(
                BottomNavCubit.approvalsIndex,
              );
              Get.find<ApprovalsBloc>().add(
                const ApprovalsEvent.started(
                  initialCategory: ApprovalCategory.raised,
                  initialType: ApprovalType.attendance,
                ),
              );

              // Return to Dashboard (where the tab switch will be visible)
              context.pop();
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: CommonAppBar(title: l10n.regularizeAttendance),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: const AttendanceRegularizationBody(),
        ),
      ),
    );
  }

  String _validationMessage(
    AppLocalizations l10n,
    RegularizationValidationError? error,
  ) {
    switch (error) {
      case RegularizationValidationError.dateRequired:
        return l10n.pleaseSelectDate;
      case RegularizationValidationError.timeRequired:
        return l10n.pleaseSelectTimes;
      case RegularizationValidationError.reasonTooShort:
        return l10n.reasonMinTenError;
      case null:
        return l10n.submissionError;
    }
  }
}
