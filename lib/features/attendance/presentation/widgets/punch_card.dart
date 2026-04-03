import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

class PunchCard extends StatefulWidget {
  const PunchCard({super.key});

  @override
  State<PunchCard> createState() => _PunchCardState();
}

class _PunchCardState extends State<PunchCard> {
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
    if (_empid == null) return const SizedBox.shrink();

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (status, logs) {
            final isPunchedIn = status.isPunchedIn;
            final primaryColor = isPunchedIn ? Colors.orange : const Color(0xff1100CC);

            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isPunchedIn) {
                        context.read<AttendanceBloc>().add(AttendanceEvent.punchOutRequested(_empid!));
                      } else {
                        context.read<AttendanceBloc>().add(AttendanceEvent.punchInRequested(_empid!));
                      }
                    },
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withValues(alpha: 0.1),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.touch_app, size: 50, color: primaryColor),
                            const SizedBox(height: 10),
                            Text(
                              isPunchedIn ? 'PUNCH OUT' : 'PUNCH IN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    status.statusText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
