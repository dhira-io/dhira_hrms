import 'dart:math';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bottomsheet/add_task_bottom_sheet.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/shared/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timesheet_task_card.dart';


class TimesheetTaskSection extends StatefulWidget {
  const TimesheetTaskSection({
    super.key,
  });

  @override
  State<TimesheetTaskSection> createState() => _TimesheetTaskSectionState();
}

class _TimesheetTaskSectionState extends State<TimesheetTaskSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.assignmentsForSelectedDay != current.assignmentsForSelectedDay ||
          previous.selectedDate != current.selectedDate ||
          previous.status != current.status,
      builder: (context, state) {
        final assignments = state.assignmentsForSelectedDay;
        final selectedDate = state.selectedDate;
        final isLoading = state.status == TimesheetStateStatus.loading;

        final title =
            (selectedDate != null &&
                !DateTimeUtils.isToday(selectedDate))
            ? l10n.timesheetDateTasks(DateTimeUtils.formatDate(selectedDate, pattern: 'EEEE, MMM d'))
            : l10n.timesheetTodaysTasks;

        final displayCount = _isExpanded
            ? assignments.length
            : min(2, assignments.length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: AppTextStyle.h3.copyWith(fontSize: 14)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primaryFixed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isLoading ? "0" : assignments.length.toString(),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).onPrimaryFixedVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    l10n.timesheetNoTasksForDay,
                    style: AppTextStyle.bodySmall,
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
                      final realIndex = bloc.state.editAssignments.indexOf(task);
                      bloc.add(
                        TimesheetEvent.editTaskRequested(
                          task: task,
                          index: realIndex,
                        ),
                      );
                      final timesheetId = bloc.state.currentWeekActiveId ?? bloc.state.initialTimesheetId ?? '0';
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
                        title: l10n.deleteTask,
                        message: l10n.deleteTaskConfirmation(
                          task.description ?? task.project,
                        ),
                        confirmLabel: l10n.delete,
                        isDestructive: true,
                      );

                      if (confirmed && context.mounted) {
                        FocusManager.instance.primaryFocus?.unfocus();

                        final bloc = context.read<TimesheetBloc>();
                        final tasksForWeek = bloc.state.editAssignments
                            .where((e) => e.parent == task.parent)
                            .toList();

                        final isLastTask = tasksForWeek.length == 1;
                        if (isLastTask) {
                          bloc.add(
                            TimesheetEvent.deleteTimesheetRequested(
                              timesheetName: task.parent ?? "",
                            ),
                          );
                          return;
                        }

                        if (task.name != null) {
                          bloc.add(
                            TimesheetEvent.deleteEntryRequested(
                              name: task.name!,
                              parent: task.parent ?? "",
                              date: task.date ?? "",
                            ),
                          );
                        } else {
                          final updated = List<ProjectAssignmentEntity>.from(
                            bloc.state.editAssignments,
                          )..remove(task);
                          bloc.add(TimesheetEvent.assignmentsChanged(updated));
                        }
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(height: 40, width: 40, borderRadius: 12),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ShimmerLoading(
                      height: 16,
                      width: 120,
                      borderRadius: 4,
                    ),
                    Row(
                      children: const [
                        ShimmerLoading(height: 20, width: 60, borderRadius: 99),
                        SizedBox(width: 8),
                        ShimmerLoading(height: 18, width: 18, borderRadius: 99),
                        SizedBox(width: 4),
                        ShimmerLoading(height: 18, width: 18, borderRadius: 99),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const ShimmerLoading(
                  height: 14,
                  width: double.infinity,
                  borderRadius: 4,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ShimmerLoading(height: 14, width: 50, borderRadius: 4),
                    ShimmerLoading(height: 14, width: 50, borderRadius: 4),
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
