import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'calendar_view_widget.dart';
import 'calendar_summary_widget.dart';
import 'calendar_on_leave_today_widget.dart';
import 'calendar_skeleton_widget.dart';
import '../bottom_sheets/attendance_details_bottom_sheet.dart';

class CalendarBodyWidget extends StatelessWidget {
  const CalendarBodyWidget({super.key});

  void _showAttendanceDetailsBottomSheet(BuildContext context, DateTime day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CalendarBloc>(),
        child: AttendanceDetailsBottomSheet(selectedDay: day),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.calendar,
        subtitle: l10n.calendarSubtitle,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocSelector<CalendarBloc, CalendarState, CalendarStatus>(
                selector: (state) => state.status,
                builder: (context, status) {
                  switch (status) {
                    case CalendarStatus.initial:
                      return const SizedBox.shrink();
                    case CalendarStatus.loading:
                      return const CalendarSkeletonWidget();
                    case CalendarStatus.error:
                      return BlocSelector<CalendarBloc, CalendarState, String?>(
                        selector: (state) => state.errorMessage,
                        builder: (context, errorMessage) {
                          return GenericErrorWidget(
                            message: errorMessage,
                            onRetry: () {
                              context.read<CalendarBloc>().add(
                                const CalendarEvent.started(),
                              );
                            },
                          );
                        },
                      );
                    case CalendarStatus.loaded:
                      return BlocSelector<CalendarBloc, CalendarState, DateTime>(
                        selector: (state) => state.focusedMonth,
                        builder: (context, focusedMonth) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<CalendarBloc>().add(
                                CalendarEvent.monthChanged(focusedMonth),
                              );
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(AppConstants.p16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<CalendarBloc, CalendarState>(
                                      buildWhen: (previous, current) =>
                                          previous.focusedMonth != current.focusedMonth ||
                                          previous.events != current.events ||
                                          previous.selectedDay != current.selectedDay,
                                      builder: (context, state) {
                                        return CalendarViewWidget(
                                          focusedMonth: state.focusedMonth,
                                          events: state.events,
                                          selectedDay: state.selectedDay,
                                          onMonthChanged: (newMonth) {
                                            context.read<CalendarBloc>().add(
                                              CalendarEvent.monthChanged(newMonth),
                                            );
                                          },
                                          onDaySelected: (day) {
                                            context.read<CalendarBloc>().add(
                                              CalendarEvent.daySelected(day),
                                            );
                                            _showAttendanceDetailsBottomSheet(
                                              context,
                                              day,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    BlocSelector<CalendarBloc, CalendarState, CalendarSummaryEntity>(
                                      selector: (state) => state.summary,
                                      builder: (context, summary) {
                                        return CalendarSummaryWidget(summary: summary);
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    BlocSelector<CalendarBloc, CalendarState, List<TeamLeaveEntity>?>(
                                      selector: (state) => state.teamLeaves,
                                      builder: (context, teamLeaves) {
                                        return CalendarOnLeaveTodayWidget(
                                          teamLeaves: teamLeaves,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
