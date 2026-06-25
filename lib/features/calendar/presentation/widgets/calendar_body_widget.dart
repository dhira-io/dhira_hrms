import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'calendar_header_widget.dart';
import 'calendar_view_widget.dart';
import 'calendar_legend_widget.dart';
import 'calendar_summary_widget.dart';
import 'calendar_skeleton_widget.dart';
import 'calendar_error_widget.dart';

class CalendarBodyWidget extends StatelessWidget {
  const CalendarBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: SafeArea(
        child: Column(
          children: [
            const CalendarHeaderWidget(),
            Expanded(
              child: BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const CalendarSkeletonWidget(),
                    error: (message) => CalendarErrorWidget(
                      message: message,
                      onRetry: () {
                        context.read<CalendarBloc>().add(const CalendarEvent.started());
                      },
                    ),
                    loaded: (events, summary, focusedMonth, selectedDay) {
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
                                CalendarViewWidget(
                                  focusedMonth: focusedMonth,
                                  events: events,
                                  selectedDay: selectedDay,
                                  onMonthChanged: (newMonth) {
                                    context.read<CalendarBloc>().add(
                                      CalendarEvent.monthChanged(newMonth),
                                    );
                                  },
                                  onDaySelected: (day) {
                                    context.read<CalendarBloc>().add(
                                      CalendarEvent.daySelected(day),
                                    );
                                  },
                                ),
                                SizedBox(height: 16.h),
                                const CalendarLegendWidget(),
                                SizedBox(height: 16.h),
                                CalendarSummaryWidget(summary: summary),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
