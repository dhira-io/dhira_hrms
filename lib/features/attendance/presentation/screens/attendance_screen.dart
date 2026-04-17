import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
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
                  error: (message, events) => ToastUtils.showError(message),
                );
              },
            ),
            BlocListener<BottomNavCubit, int>(
              listener: (context, state) async {
                if (state == 1) {
                  final prefs = await SharedPreferences.getInstance();
                  final empid = prefs.getString(StorageConstants.empId);
                  if (empid != null && context.mounted) {
                    context.read<AttendanceBloc>().add(
                      AttendanceEvent.checkStatusRequested(empid),
                    );
                  }
                }
              },
            ),
          ],
          child: RefreshIndicator(
            onRefresh: () async {
              final prefs = await SharedPreferences.getInstance();
              final empid = prefs.getString(StorageConstants.empId);
              if (empid != null && mounted) {
                final bloc = context.read<AttendanceBloc>();
                // fetchStatusRequested reloads status, logs, and durations
                bloc.add(AttendanceEvent.checkStatusRequested(empid));
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const AttendanceHeader(),
                  const PunchCard(),
                  const SizedBox(height: 12),
                  const AttendanceLogList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
