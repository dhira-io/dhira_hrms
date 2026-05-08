import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../bloc/timesheet_success_type.dart';
import '../widgets/timesheet_apply_form.dart';
import '../widgets/timesheet_task_section.dart';
import '../widgets/timesheet_stats_bento.dart';
import '../widgets/timesheet_week_selector.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../l10n/app_localizations.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;

  const ApplyTimesheetScreen({
    super.key,
    required this.timesheetId,
  });

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now();

      context.read<TimesheetBloc>().add(
        TimesheetEvent.daySelected(today),
      );

      context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchMonthWiseRequested(
          month: today.month,
          year: today.year,
        ),
      );

      context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchOverviewRequested(
          month: today.month,
          year: today.year,
        ),
      );

      context.read<TimesheetBloc>().add(TimesheetEvent.started(timesheetId: widget.timesheetId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) =>
          current.maybeMap(success: (_) => true, error: (_) => true, orElse: () => false),
      listener: (context, state) {
        state.mapOrNull(
          success: (s) {
            final displayMessage = _getSuccessMessage(s.successType, s.message, l10n);
            ToastUtils.showSuccess(displayMessage);

            if (s.successType == TimesheetSuccessType.timesheetSubmitted) {
              context.pop();
            }
          },
          error: (e) {
            ToastUtils.showError(e.message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.timesheetEntry, style: AppTextStyle.h3),
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: AppConstants.iconSmall),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<TimesheetBloc, TimesheetState>(
          buildWhen: (previous, current) {
            if (previous.runtimeType != current.runtimeType) return true;
            if (previous.selectedDate != current.selectedDate) return true;
            return false;
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                final selected = state.selectedDate ?? DateTime.now();

                final startOfWeek = selected.subtract(
                  Duration(days: selected.weekday - 1),
                );

                final dominantMonth =
                DateTimeUtils.getDominantMonthOfWeek(
                  startOfWeek,
                );

                final dominantYear =
                DateTimeUtils.getDominantYearOfWeek(
                  startOfWeek,
                );



               context.read<TimesheetBloc>().add(
                  TimesheetEvent.fetchOverviewRequested(
                    month: dominantMonth,
                    year: dominantYear,
                  ),
                );

              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(AppConstants.p20, AppConstants.p20, AppConstants.p20, 0),
                    sliver: SliverToBoxAdapter(
                      child: TimesheetBentoStats(),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(AppConstants.p20, AppConstants.p24, AppConstants.p20, 0),
                    sliver: SliverToBoxAdapter(
                      child: TimesheetWeekSelector(),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(AppConstants.p20, AppConstants.p24, AppConstants.p20, 0),
                    sliver: TimesheetTaskSection(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(AppConstants.p20, AppConstants.p24, AppConstants.p20, 0),
                    sliver: SliverToBoxAdapter(
                      child: TimesheetApplyForm(
                        timesheetId: widget.timesheetId,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppConstants.p20),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isActionLoading
                              ? null
                              : () {
                            context.read<TimesheetBloc>().add(const TimesheetEvent.submitWeeklyRequested());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
                            elevation: 0,
                          ),
                          child: state.isActionLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(l10n.submitWeeklyTimesheet, style: AppTextStyle.button),
                        ),
                      ),
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

  String _getSuccessMessage(TimesheetSuccessType? type, String defaultMsg, AppLocalizations l10n) {
    if (type == null) return defaultMsg;
    return switch (type) {
      TimesheetSuccessType.taskAdded => l10n.taskAddedToDay,
      TimesheetSuccessType.timesheetSubmitted => l10n.timesheetSubmittedSuccessfully,
      TimesheetSuccessType.taskUpdated => l10n.taskUpdatedSuccessfully,
      TimesheetSuccessType.taskDeleted => l10n.taskDeletedSuccessfully,
    };
  }
}
