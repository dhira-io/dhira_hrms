import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/attendance/presentation/widgets/leave_details_section.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendance_log_list.dart';
import '../widgets/leave_history_section.dart';
import '../widgets/on_leave_today_section.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AttendanceBloc>().add(const AttendanceEvent.started());
      }
    });
  }

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
                  error: (message, events, _, _, _, _, _, _, _) =>
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
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const AttendanceLogList(),
                      BlocBuilder<AttendanceBloc, AttendanceState>(
                        buildWhen: (previous, current) =>
                            previous.leaveDetails != current.leaveDetails ||
                            previous.leaveHistory != current.leaveHistory ||
                            previous.teamLeaves != current.teamLeaves,
                        builder: (context, state) {
                          return Column(
                            children: [
                              if (state.leaveDetails != null)
                                LeaveDetailsSection(
                                  key: ValueKey(
                                    state.leaveDetails!.leaveAllocation.length,
                                  ),
                                  details: state.leaveDetails!,
                                ),
                              if (state.leaveHistory != null)
                                LeaveHistorySection(
                                  history: state.leaveHistory!,
                                ),
                              OnLeaveTodaySection(leaves: state.teamLeaves),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}
