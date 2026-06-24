import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/widgets/edit_timesheet/edit_timesheet_form.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import '../dialogs/widgets/edit_timesheet/edit_timesheet_error_view.dart';
import '../dialogs/widgets/edit_timesheet/edit_timesheet_header.dart';

class EditTimesheetBottomSheet extends StatelessWidget {
  const EditTimesheetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ApprovalsBloc, ApprovalsState>(
      builder: (context, state) {
        return state.maybeMap(
          success: (s) {
            if (s.data.isTimesheetLoading) {
              return Container(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLowest,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EditTimesheetHeader(onClose: () => Navigator.pop(context)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(4, (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ShimmerLoading(width: double.infinity, height: 40),
                        )),
                      ),
                    ),
                  ],
                ),
              );
            }

            final timesheet = s.data.editingTimesheet;

            if (timesheet == null) {
              return EditTimesheetErrorView(
                errorMessage: s.data.errorMessage,
                onClose: () => Navigator.pop(context),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: EditTimesheetForm(
                  timesheet: timesheet,
                  projects: s.data.projects,
                  employees: s.data.employees,
                ),
              ),
            );
          },
          orElse: () => Center(child: Text(l10n.invalidStateForEdit)),
        );
      },
    );
  }
}
