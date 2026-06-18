import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';

class TimesheetBottomActions extends StatelessWidget {
  const TimesheetBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.hasDraftTasksInSelectedWeek !=
              current.hasDraftTasksInSelectedWeek ||
          previous.isSubmitWeeklyLoading != current.isSubmitWeeklyLoading ||
          previous.status != current.status ||
          previous.editAssignments.isEmpty != current.editAssignments.isEmpty,
      builder: (context, state) {
        final isLoading = state.isInitialLoading;
        final hasDraft = state.hasDraftTasksInSelectedWeek;

        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 5.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            border: Border(
              top: BorderSide(color: AppColors.of(context).tableBorder),
            ),
          ),
          child: SafeArea(
            child: isLoading
                ? ShimmerLoading(
                    height: 40.h,
                    width: double.infinity,
                    borderRadius: 12.r,
                  )
                : SizedBox(
                    height: 38.h,
                    width: double.infinity,
                    child: CommonButton(
                      text: l10n.submitWeeklyTimesheet,
                      width: double.infinity,
                      isLoading: state.isSubmitWeeklyLoading,
                      icon: Icons.check_circle_outlined,
                      onPressed: hasDraft
                          ? () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<TimesheetBloc>().add(
                                const TimesheetEvent.submitWeeklyRequested(),
                              );
                            }
                          : null,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
