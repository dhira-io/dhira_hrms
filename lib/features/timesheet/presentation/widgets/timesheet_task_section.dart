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
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';
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
          previous.status != current.status ||
          previous.isActionLoading != current.isActionLoading,
      builder: (context, state) {
        final assignments = state.assignmentsForSelectedDay;
        final isLoading =
            state.status == TimesheetStateStatus.loading ||
            state.isActionLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.taskEntries,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.of(context).textPrimary,
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
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: Divider(
                height: 1,
                thickness: 0.8,
                color: AppColors.of(context).tableBorder,
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
                  color: AppColors.of(context).tableBorder,
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
                          color: AppColors.of(context).slate100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/clock.svg',
                          colorFilter: ColorFilter.mode(
                            AppColors.of(context).slate400,
                            BlendMode.srcIn,
                          ),
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        l10n.noTasksLogged,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        l10n.logWorkHoursPrompt,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.of(context).textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 26.h,
                        width: 100.w,
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
              )
            else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: assignments.length,
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
                      final confirmed = await showModalBottomSheet<bool>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => CommonConfirmationBottomSheet(
                          icon: Icon(
                            Icons.error_outline,
                            color: AppColors.of(context).absentText,
                            size: 20.w,
                          ),
                          iconBackgroundColor: AppColors.confirmationRedBg,
                          title: l10n.confirmDeletion,
                          subtitle: l10n.deleteTaskConfirmationSubtitle,
                          cancelAction: ConfirmationAction(
                            label: l10n.cancel,
                            onTap: () => Navigator.of(context).pop(false),
                          ),
                          confirmAction: ConfirmationAction(
                            label: l10n.delete,
                            onTap: () => Navigator.of(context).pop(true),
                          ),
                        ),
                      );

                      if (confirmed == true && context.mounted) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<TimesheetBloc>().add(
                          TimesheetEvent.deleteTaskRequested(task: task),
                        );
                      }
                    },
                  );
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
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.of(context).slate200, width: 1.w),
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
                  color: AppColors.of(context).white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColors.of(context).slate200,
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
