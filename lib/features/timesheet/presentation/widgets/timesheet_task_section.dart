import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import 'timesheet_task_card.dart';

class TimesheetTaskSection extends StatefulWidget {
  const TimesheetTaskSection({super.key});

  @override
  State<TimesheetTaskSection> createState() => _TimesheetTaskSectionState();
}

class _TimesheetTaskSectionState extends State<TimesheetTaskSection> {
  bool _isExpanded = false;

  void _onEdit(BuildContext context, ProjectAssignmentEntity task, TimesheetState state) {
    context.read<TimesheetBloc>().add(TimesheetEvent.editTaskRequested(
      task: task,
      index: state.editAssignments.indexOf(task),
    ));
  }

  void _onDelete(BuildContext context, ProjectAssignmentEntity task, TimesheetState state, AppLocalizations l10n) async {
    final confirmed = await AppDialogs.showConfirmation(
      context: context,
      title: l10n.deleteTask,
      message: l10n.deleteTaskConfirmation(task.description ?? task.project),
      confirmLabel: l10n.delete,
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      final tasksForWeek = state.editAssignments
          .where((e) => e.parent == task.parent)
          .toList();

      final isLastTask = tasksForWeek.length == 1;
      if (isLastTask) {
        context.read<TimesheetBloc>().add(
          TimesheetEvent.deleteTimesheetRequested(
            timesheetName: task.parent ?? "",
          ),
        );
        return;
      }

      if (task.name != null) {
        context.read<TimesheetBloc>().add(TimesheetEvent.deleteEntryRequested(
          name: task.name!,
          parent: task.parent ?? "",
          date: task.date ?? "",
        ));
      } else {
        final updated = List<ProjectAssignmentEntity>.from(state.editAssignments)..remove(task);
        context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(updated));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous.assignmentsForSelectedDay != current.assignmentsForSelectedDay) return true;
        if (previous.selectedDate != current.selectedDate) return true;
        return false;
      },
      builder: (context, state) {
        final assignments = state.assignmentsForSelectedDay;
        final selectedDate = state.selectedDate;

        final title = (selectedDate != null &&
            !DateTimeUtils.isToday(selectedDate))
            ? l10n.timesheetDateTasks(
          selectedDate.format('EEEE, MMM d'),
        )
            : l10n.timesheetTodaysTasks;

        final displayCount = _isExpanded
            ? assignments.length
            : min(2, assignments.length);

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: AppTextStyle.h3.copyWith(fontSize: 14)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryFixed,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          assignments.length.toString(),
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.onPrimaryFixedVariant,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (assignments.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          l10n.timesheetNoTasksForDay,
                          style: AppTextStyle.bodySmall,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (assignments.isNotEmpty)
              SliverList.builder(
                itemCount: displayCount,
                itemBuilder: (context, index) {
                  final task = assignments[index];
                  return TimesheetTaskCard(
                    task: task,
                    index: index,
                    onEdit: (t, i) => _onEdit(context, t, state),
                    onDelete: (t) => _onDelete(context, t, state, l10n),
                  );
                },
              ),
            if (assignments.length > 2)
              SliverToBoxAdapter(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? l10n.showLess : l10n.showMore,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
  }

