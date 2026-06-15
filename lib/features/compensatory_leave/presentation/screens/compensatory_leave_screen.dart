import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_event.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_state.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_content_view.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/constants/compensatory_leave_constants.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';

class CompensatoryLeaveScreen extends StatefulWidget {
  const CompensatoryLeaveScreen({super.key});

  @override
  State<CompensatoryLeaveScreen> createState() =>
      _CompensatoryLeaveScreenState();
}

class _CompensatoryLeaveScreenState extends State<CompensatoryLeaveScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CompensatoryLeaveBloc>().add(
          const CompensatoryLeaveEvent.started(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.of(context).background,
          appBar: CommonAppBar(title: l10n.compensatoryLeaveRequest),
          body: BlocListener<CompensatoryLeaveBloc, CompensatoryLeaveState>(
            listenWhen: (prev, curr) =>
                (prev.status != curr.status &&
                    curr.status == CompensatoryLeaveStatus.success) ||
                (prev.errorMessage != curr.errorMessage &&
                    curr.errorMessage != null),
            listener: (context, state) {
              if (state.status == CompensatoryLeaveStatus.success) {
                ToastUtils.showSuccess(l10n.compOffSubmitSuccess);
                AppRouter.navigateToRaisedRequests(ApprovalType.compOff);
              } else if (state.errorMessage != null) {
                final err = state.errorMessage!;
                final message =
                    err == CompensatoryLeaveConstants.errorEmployeeIdNotFound
                    ? l10n.employeeIdNotFound
                    : err ==
                          CompensatoryLeaveConstants.errorPleaseSelectWorkDate
                    ? l10n.selectWorkDateError
                    : err == CompensatoryLeaveConstants.errorPleaseSelectProject
                    ? l10n.selectProjectValidation
                    : err ==
                          CompensatoryLeaveConstants
                              .errorPleaseEnterTaskDescription
                    ? l10n.taskValidation
                    : err;
                ToastUtils.showError(
                  err == CompensatoryLeaveConstants.errorPleaseEnterReason
                      ? l10n.enterReasonForExtraWork
                      : message,
                );
              }
            },
            child: const CompensatoryLeaveContentView(),
          ),
        ),
      ),
    );
  }
}
