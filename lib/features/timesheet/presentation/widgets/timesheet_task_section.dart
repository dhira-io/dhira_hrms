import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bottomsheet/add_task_bottom_sheet.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/shared/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/dashed_border_painter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'timesheet_task_card.dart';

class TimesheetTaskSection extends StatefulWidget {
  const TimesheetTaskSection({super.key});

  @override
  State<TimesheetTaskSection> createState() => _TimesheetTaskSectionState();
}

class _TimesheetTaskSectionState extends State<TimesheetTaskSection> {
  bool _isExpanded = false;

  void _openAddTask(BuildContext context) {
    final bloc = context.read<TimesheetBloc>();
    final timesheetId =
        bloc.state.currentWeekActiveId ?? bloc.state.initialTimesheetId ?? '0';
    AddTaskBottomSheet.show(context, timesheetId: timesheetId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.assignmentsForSelectedDay !=
              current.assignmentsForSelectedDay ||
          previous.selectedDate != current.selectedDate ||
          previous.status != current.status,
      builder: (context, state) {
        final assignments = state.assignmentsForSelectedDay;
        final isLoading = state.status == TimesheetStateStatus.loading;

        final displayCount = _isExpanded
            ? assignments.length
            : min(2, assignments.length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.taskEntries,
                  style: TextStyle(
                    color: AppColors.of(context).textPrimary,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (assignments.isNotEmpty && !isLoading)
                  InkWell(
                    onTap: () => _openAddTask(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Text(
                        l10n.addTask,
                        style: TextStyle(
                          color: AppColors.of(context).primaryContainer,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: Divider(
                height: 1,
                thickness: 0.8,
                color: AppColors.of(context).border,
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
              CustomPaint(
                foregroundPainter: DashedBorderPainter(
                  color: AppColors.of(context).border,
                  borderRadius: 12.r,
                  strokeWidth: 2.0,
                  dashWidth: 7,
                  dashSpace: 3,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/clock.svg',
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFA1A1A1),
                            BlendMode.srcIn,
                          ),
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        l10n.noTasksLogged,
                        style: TextStyle(
                          color: AppColors.of(context).textPrimary,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        l10n.logWorkHoursPrompt,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.of(context).textSecondary,
                          fontSize: 10.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65.w),
                        child: CommonButton(
                          text: l10n.addTask,
                          onPressed: () => _openAddTask(context),
                          icon: Icons.add,
                          borderRadius: 8.r,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayCount,
                itemBuilder: (context, index) {
                  final task = assignments[index];
                  return TimesheetTaskCard(
                    task: task,
                    index: index,
                    onEdit: (task, index) {
                      final bloc = context.read<TimesheetBloc>();
                      final realIndex = bloc.state.editAssignments.indexOf(
                        task,
                      );
                      bloc.add(
                        TimesheetEvent.editTaskRequested(
                          task: task,
                          index: realIndex,
                        ),
                      );
                      final timesheetId =
                          bloc.state.currentWeekActiveId ??
                          bloc.state.initialTimesheetId ??
                          '0';
                      AddTaskBottomSheet.show(
                        context,
                        timesheetId: timesheetId,
                        editingTask: task,
                        editingIndex: realIndex,
                      );
                    },
                    onDelete: (task) async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final confirmed = await AppDialogs.showConfirmation(
                        context: context,
                        title: l10n.confirmDeletion,
                        message: l10n.deleteTaskConfirmationSubtitle,
                        confirmLabel: l10n.delete,
                        isDestructive: true,
                      );

                      if (confirmed && context.mounted) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<TimesheetBloc>().add(
                          TimesheetEvent.deleteTaskRequested(task: task),
                        );
                      }
                    },
                  );
                },
              ),
              if (assignments.length > 2)
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? l10n.showLess : l10n.showMore,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(height: 40.h, width: 40.w, borderRadius: 12),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(height: 16.h, width: 120.w, borderRadius: 4),
                    Row(
                      children: [
                        ShimmerLoading(
                          height: 20.h,
                          width: 60.w,
                          borderRadius: 99,
                        ),
                        SizedBox(width: 8.w),
                        ShimmerLoading(
                          height: 18.h,
                          width: 18.w,
                          borderRadius: 99,
                        ),
                        SizedBox(width: 4.w),
                        ShimmerLoading(
                          height: 18.h,
                          width: 18.w,
                          borderRadius: 99,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ShimmerLoading(
                  height: 14.h,
                  width: double.infinity,
                  borderRadius: 4,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(height: 14.h, width: 50.w, borderRadius: 4),
                    ShimmerLoading(height: 14.h, width: 50.w, borderRadius: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
