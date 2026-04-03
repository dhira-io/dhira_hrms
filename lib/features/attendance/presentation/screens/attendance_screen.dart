import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
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
      _empid = prefs.getString('empid');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_empid == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider<AttendanceBloc>(
      create: (context) => Get.find<AttendanceBloc>()..add(AttendanceEvent.started(_empid!)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Attendance'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<AttendanceBloc>().add(AttendanceEvent.checkStatusRequested(_empid!));
              },
            ),
          ],
        ),
        body: BlocListener<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => AppDialogs.showAlertDialog(context, message),
            );
          },
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<AttendanceBloc>().add(AttendanceEvent.logRequested(_empid!));
              context.read<AttendanceBloc>().add(AttendanceEvent.checkStatusRequested(_empid!));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const AttendanceHeader(),
                  const PunchCard(),
                  const SizedBox(height: 20),
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
