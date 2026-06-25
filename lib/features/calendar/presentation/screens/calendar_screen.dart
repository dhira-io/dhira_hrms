import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_events_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_team_leaves_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_punch_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:dhira_hrms/features/calendar/presentation/widgets/calendar_body_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarBloc>(
      create: (context) => CalendarBloc(
        getCalendarEventsUseCase: Get.find<GetCalendarMonthEventsUseCase>(),
        getCalendarSummaryUseCase: Get.find<GetCalendarSummaryUseCase>(),
        getTeamLeavesUseCase: Get.find<GetTeamLeavesUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
        getAttendancePunchSummaryUseCase: Get.find<GetAttendancePunchSummaryUseCase>(),
        getLeaveHistoryUseCase: Get.find<GetLeaveHistoryUseCase>(),
      ),
      child: const CalendarScreenContent(),
    );
  }
}

class CalendarScreenContent extends StatefulWidget {
  const CalendarScreenContent({super.key});

  @override
  State<CalendarScreenContent> createState() => _CalendarScreenContentState();
}

class _CalendarScreenContentState extends State<CalendarScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CalendarBloc>().add(const CalendarEvent.started());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listenWhen: (previous, current) =>
          current.maybeMap(error: (_) => true, orElse: () => false),
      listener: (context, state) {
        state.maybeWhen(
          error: (message) => ToastUtils.showError(message),
          orElse: () {},
        );
      },
      child: const CalendarBodyWidget(),
    );
  }
}
