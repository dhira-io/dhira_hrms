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
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastUtils.showError(state.errorMessage!);
        }
        if (state.successMessage != null &&
            !state.isSubmitting &&
            !state.isUploading) {
          ToastUtils.showSuccess(state.successMessage!);
        }
        if (state.isSubmissionSuccess) {
          ToastUtils.showSuccess(l10n.submissionSuccess);
        }
        if (state.isFileUploadSuccess) {
          ToastUtils.showSuccess(l10n.fileUploadSuccess);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primaryContainer,
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
