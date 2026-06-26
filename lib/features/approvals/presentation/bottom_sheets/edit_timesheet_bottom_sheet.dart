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
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    EditTimesheetHeader(onClose: () => Navigator.pop(context), dateRange: ""),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Summary Card Shimmer
                          ShimmerLoading(
                            width: double.infinity,
                            height: 100.h,
                            borderRadius: 16.r,
                          ),
                          SizedBox(height: 16.h),
                          // Day Section Shimmers
                          ...List.generate(3, (index) => Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: colors.slateBorder),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                ShimmerLoading(
                                  width: 40.w,
                                  height: 40.h,
                                  borderRadius: 8.r,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ShimmerLoading(width: 120.w, height: 16.h),
                                      SizedBox(height: 8.h),
                                      ShimmerLoading(width: 80.w, height: 12.h),
                                    ],
                                  ),
                                ),
                                ShimmerLoading(width: 50.w, height: 16.h),
                                SizedBox(width: 16.w),
                                ShimmerLoading(width: 24.w, height: 24.h, borderRadius: 12.r),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                  ),
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
                child: SafeArea(
                  child: EditTimesheetForm(
                    timesheet: timesheet,
                    projects: s.data.projects,
                    employees: s.data.employees,
                  ),
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
