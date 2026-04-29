import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_regularization_bloc.dart';
import '../bloc/attendance_regularization_state.dart';
import '../widgets/attendance_regularization_body.dart';

class AttendanceRegularizationScreen extends StatelessWidget {
  const AttendanceRegularizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AttendanceRegularizationBloc, AttendanceRegularizationState>(
      listenWhen: (previous, current) =>
          current.maybeMap(
            error: (_) => true,
            success: (_) => previous.maybeMap(
              success: (_) => false,
              orElse: () => true,
            ),
            orElse: () => false,
          ),
      listener: (context, state) {
        state.whenOrNull(
          error: (_, message) => ToastUtils.showError(message),
          success: (_, isFileUploadSuccess, isSubmissionSuccess) {
            if (isFileUploadSuccess) {
              ToastUtils.showSuccess(l10n.fileUploadSuccess);
            }
            if (isSubmissionSuccess) {
              ToastUtils.showSuccess(l10n.submissionSuccess);
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.onSurface,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            l10n.regularizeAttendance,
            style: AppTextStyle.h3,
          ),
          centerTitle: false,
        ),
        body: const AttendanceRegularizationBody(),
      ),
    );
  }
}
