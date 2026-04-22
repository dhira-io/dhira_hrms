import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/toast_utils.dart';
import '../../../dashboard/presentation/bloc/bottom_nav_cubit.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendance_log_list.dart';
import '../widgets/punch_card.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // String? _empid;

  @override
  Widget build(BuildContext context) {
    // if (_empid == null) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message, events, _, _, _) =>
                      ToastUtils.showError(message),
                );
              },
            ),
            BlocListener<BottomNavCubit, int>(
              listener: (context, state) {
                if (state == BottomNavCubit.attendanceIndex) {
                  if (context.mounted) {
                    context.read<AttendanceBloc>().add(
                      const AttendanceEvent.checkStatusRequested(),
                    );
                  }
                }
              },
            ),
          ],
          child: Column(
            children: [
              const AttendanceHeader(),
              const SizedBox(height: 12),
              const Expanded(
                child: AttendanceLogList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}