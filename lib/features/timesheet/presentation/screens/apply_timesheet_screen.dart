import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/project_assignment_entity.dart';
import '../widgets/timesheet_theme.dart';

import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../widgets/timesheet_apply_form.dart';
import '../widgets/timesheet_stats_bento.dart';
import '../widgets/timesheet_week_selector.dart';
import '../widgets/timesheet_task_section.dart';
import '../widgets/timesheet_submit_bar.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;
  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<TimesheetBloc>();
      
      if (widget.timesheetId == "current") {
        bloc.add(const TimesheetEvent.loadCurrentWeekRequested());
      } else if (widget.timesheetId == "0") {
        bloc.add(const TimesheetEvent.assignmentsChanged([]));
        final now = DateTime.now();
        final from = now.subtract(Duration(days: now.weekday - 1));
        final to = from.add(const Duration(days: 6));
        bloc.add(TimesheetEvent.fromDateChanged(from));
        bloc.add(TimesheetEvent.toDateChanged(to));
        bloc.add(TimesheetEvent.daySelected(now));
      } else {
        bloc.add(TimesheetEvent.fetchDetailsRequested(widget.timesheetId));
      }
      bloc.add(const TimesheetEvent.userInitRequested());
    });
  }

  void _submitWeekly(BuildContext context, TimesheetState state) {
    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;
    final assignments = state.editAssignments;

    if (from == null || to == null) return;

    if (widget.timesheetId == "0") {
      context.read<TimesheetBloc>().add(TimesheetEvent.submitRequested(
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        assignments: assignments,
      ));
    } else {
      context.read<TimesheetBloc>().add(TimesheetEvent.updateRequested(
        name: widget.timesheetId,
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        approved: 0,
        hoursTotal: assignments.fold(0.0, (sum, item) => sum + item.spentHours),
        assignments: assignments,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimesheetBloc>.value(
      value: Get.find<TimesheetBloc>(),
      child: BlocListener<TimesheetBloc, TimesheetState>(
        listenWhen: (previous, current) {
          return previous.maybeMap(loading: (_) => true, orElse: () => false) &&
              current.maybeMap(loaded: (_) => true, orElse: () => false);
        },
        listener: (context, state) {
          state.maybeWhen(
            loaded: (timesheets, hasMore, isFetchingMore, user, from, to, selectedDate, assignments, projects) {
              ToastUtils.showSuccess("Saved successfully");
              context.pop();
            },
            error: (message, _, __, ___, ____, _____, ______, _______, ________) {
              ToastUtils.showError(message);
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<TimesheetBloc, TimesheetState>(
          builder: (context, state) {
            final selectedDate = state.selectedDate ?? DateTime.now();
            final assignmentsForDay = state.editAssignments.where((a) {
              if (a.date == null) return false;
              final d = DateTime.tryParse(a.date!);
              return d?.year == selectedDate.year &&
                  d?.month == selectedDate.month &&
                  d?.day == selectedDate.day;
            }).toList();

            final totalSpent = state.editAssignments.fold(0.0, (sum, a) => sum + a.spentHours);

            return Scaffold(
              backgroundColor: TimesheetColors.background,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: TimesheetColors.primary),
                  onPressed: () => context.pop(),
                ),
                title: Text(
                  "Timesheet Entry",
                  style: TimesheetStyles.h3.copyWith(color: TimesheetColors.primary, fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                surfaceTintColor: Colors.transparent,
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TimesheetBentoStats(
                          filled: totalSpent,
                          approved: 24.0, // Mocked for design
                          pending: totalSpent - 24.0 > 0 ? totalSpent - 24.0 : 0.0, // Mocked
                          rejected: 0.0,
                          upcoming: 4.0,
                        ),
                        const SizedBox(height: 24),
                        TimesheetWeekSelector(
                          selectedDate: selectedDate,
                          onDateSelected: (date) => context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(date)),
                          onPreviousWeek: () {
                            final newDate = selectedDate.subtract(const Duration(days: 7));
                            context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(newDate));
                            context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));
                          },
                          onNextWeek: () {
                            final newDate = selectedDate.add(const Duration(days: 7));
                            context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(newDate));
                            context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));
                          },
                        ),
                        const SizedBox(height: 24),
                        TimesheetTaskSection(
                          tasks: assignmentsForDay,
                          onEdit: (idx) {
                            // Find absolute index
                            // TODO: Implement edit in-form
                          },
                          onDelete: (idx) {
                            final task = assignmentsForDay[idx];
                            final updated = List<ProjectAssignmentEntity>.from(state.editAssignments)..remove(task);
                            context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(updated));
                          },
                        ),
                        const SizedBox(height: 24),
                        TimesheetApplyForm(timesheetId: widget.timesheetId),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TimesheetSubmitBar(
                      onCancel: () => context.pop(),
                      onSubmit: () => _submitWeekly(context, state),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


