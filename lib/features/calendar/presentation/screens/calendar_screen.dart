import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:dhira_hrms/features/calendar/presentation/widgets/calendar_body_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarBloc>(
      create: (context) => Get.find<CalendarBloc>()..add(const CalendarEvent.started()),
      child: const CalendarScreenContent(),
    );
  }
}

class CalendarScreenContent extends StatelessWidget {
  const CalendarScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listenWhen: (previous, current) =>
          current.status == CalendarStatus.error &&
          previous.status != CalendarStatus.error,
      listener: (context, state) {
        if (state.status == CalendarStatus.error && state.errorMessage != null) {
          ToastUtils.showError(state.errorMessage!);
        }
      },
      child: const CalendarBodyWidget(),
    );
  }
}
