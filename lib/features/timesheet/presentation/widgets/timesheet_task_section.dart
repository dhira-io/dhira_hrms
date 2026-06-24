import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bottomsheet/add_task_bottom_sheet.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'timesheet_empty_state.dart';
import 'timesheet_task_card.dart';

class TimesheetTaskSection extends StatelessWidget {
  const TimesheetTaskSection({super.key});

  void _openAddTask(BuildContext context) {
    final state = context.read<TimesheetBloc>().state;
    AddTaskBottomSheet.show(
      context,
      timesheetId: state.activeTimesheetIdOrDefault,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.assignmentsForSelectedDay !=
              current.assignmentsForSelectedDay ||
          previous.selectedDate != current.selectedDate ||
          previous.status != current.status ||
          previous.isActionLoading != current.isActionLoading,
      builder: (context, state) {
        final assignments = state.assignmentsForSelectedDay;
        final isLoading =
            state.status == TimesheetStateStatus.loading ||
            state.isActionLoading;
        final colors = AppColors.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.taskEntries,
                    style: AppTextStyle.headingSmallTwo.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  if (assignments.isNotEmpty && !isLoading)
                    SizedBox(
                      height: 26.h,
                      width: 110.w,
                      child: CommonButton(
                        fontWeight: FontWeight.w100,
                        text: l10n.addTask,
                        onPressed: () => _openAddTask(context),
                        icon: Icons.add,
                        borderRadius: 8.r,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: Divider(
                height: 1,
                thickness: 0.8,
                color: colors.tableBorder,
              ),
            ),
            if (isLoading)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const TaskCardSkeleton();
                },
              )
            else if (assignments.isEmpty)
              TimesheetEmptyState(onAddTask: () => _openAddTask(context))
            else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final task = assignments[index];
                  return TimesheetTaskCard(task: task, index: index);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}

class TaskCardSkeleton extends StatelessWidget {
  const TaskCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.slate200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      height: 14.h,
                      width: 140.w,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 4.h),
                    ShimmerLoading(
                      height: 10.h,
                      width: 180.w,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
              ),
              ShimmerLoading(height: 22.h, width: 64.w, borderRadius: 9999.r),
            ],
          ),
          SizedBox(height: 11.h),
          Row(
            children: [
              ShimmerLoading(height: 14.h, width: 14.w, borderRadius: 4.r),
              SizedBox(width: 4.w),
              ShimmerLoading(height: 12.h, width: 60.w, borderRadius: 4.r),
              SizedBox(width: 24.w),
              ShimmerLoading(height: 12.h, width: 70.w, borderRadius: 4.r),
            ],
          ),
          SizedBox(height: 11.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(height: 12.h, width: 80.w, borderRadius: 4.r),
              SizedBox(height: 4.h),
              Container(
                width: double.infinity,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: colors.slate200,
                    width: 1.w,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ShimmerLoading(
                    height: 10.h,
                    width: double.infinity,
                    borderRadius: 4.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 11.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(height: 24.h, width: 90.w, borderRadius: 8.r),
              Row(
                children: [
                  ShimmerLoading(height: 24.h, width: 24.w, borderRadius: 6.r),
                  SizedBox(width: 8.w),
                  ShimmerLoading(height: 24.h, width: 24.w, borderRadius: 6.r),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
