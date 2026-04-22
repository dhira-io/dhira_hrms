import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../dashboard/presentation/bloc/bottom_nav_cubit.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendance_log_list.dart';
import '../widgets/leave_details_section.dart';
import '../widgets/leave_history_section.dart';
import '../widgets/on_leave_today_section.dart';
import '../widgets/punch_card.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message, events, _, _, _, _, _, _) =>
                      ToastUtils.showError(message),
                );
              },
            ),
            BlocListener<BottomNavCubit, int>(
              listener: (context, state) {
                if (state == BottomNavCubit.attendanceIndex) {
                  if (context.mounted) {
                    context.read<AttendanceBloc>().add(
                      const AttendanceEvent.started(),
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
              Expanded(
                child: BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const AttendanceLogList(),
                          if (state.leaveDetails != null)
                            LeaveDetailsSection(
                              key: ValueKey(
                                state.leaveDetails!.leaveAllocation.length,
                              ),
                              details: state.leaveDetails!,
                            ),
                          if (state.leaveHistory != null)
                            LeaveHistorySection(history: state.leaveHistory!),
                          OnLeaveTodaySection(leaves: state.teamLeaves),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
