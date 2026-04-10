import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
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
  String? _empid;

  @override
  void initState() {
    super.initState();
    _loadEmpId();
  }

  Future<void> _loadEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _empid = prefs.getString(StorageConstants.empId);
    });
    print('ebdfufeu _empid: $_empid');
  }

  @override
  Widget build(BuildContext context) {
    if (_empid == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: BlocListener<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            state.whenOrNull(error: (message) => ToastUtils.showError(message));
          },
        child: Column(
          children: [
            const AttendanceHeader(),
            const PunchCard(),
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
