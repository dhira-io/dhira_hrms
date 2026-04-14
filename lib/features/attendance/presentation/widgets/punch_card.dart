import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
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
  late Timer _timer;
  final Stopwatch _stopwatch = Stopwatch();
  bool _isPunchedInDummy = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopwatch.isRunning && mounted) {
        setState(() {}); // Trigger rebuild to update stopwatch text
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEmpIdAndFetch();
    });
  }

  Future<void> _loadEmpIdAndFetch() async {
    print('inside');
    // final prefs = await SharedPreferences.getInstance();
    // final empId = prefs.getString(StorageConstants.empId);

    if (!mounted) return;

    setState(() {
      _empid = 'EMP-00055';
    });
    //  if (empId != null) {
    context.read<AttendanceBloc>().add(
      AttendanceEvent.checkStatusRequested("EMP-00055"),
    );
    //  }
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    if (_empid == null) return const SizedBox.shrink();

    final dateFormatted = DateFormat(
      'EEEE, MMMM d, yyyy',
    ).format(DateTime.now());

    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (status, logs) {
            // Unify local dummy state with the real server state if it loads successfully
            setState(() {
              _isPunchedInDummy = status.punchedIn;
              if (_isPunchedInDummy && !_stopwatch.isRunning) {
                _stopwatch.start();
              } else if (!_isPunchedInDummy && _stopwatch.isRunning) {
                _stopwatch.stop();
                _stopwatch.reset();
              }
            });
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final timeFormatted = _formatDuration(_stopwatch.elapsed);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Column(
            children: [
              // The Timer Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppConstants.r20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      dateFormatted,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      timeFormatted,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (_isPunchedInDummy) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Present',
                              style: AppTextStyle.label.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // The Action Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isPunchedInDummy = !_isPunchedInDummy;
                    if (_isPunchedInDummy) {
                      _stopwatch.reset();
                      _stopwatch.start();
                      context.read<AttendanceBloc>().add(
                        AttendanceEvent.punchInRequested(_empid!),
                      );
                    } else {
                      _stopwatch.stop();
                      _stopwatch.reset();
                      context.read<AttendanceBloc>().add(
                        AttendanceEvent.punchOutRequested(_empid!),
                      );
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p32,
                  ),
                  child: Container(
                    height: 44,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _isPunchedInDummy
                          ? Colors.orange
                          : AppColors.primary,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        Icon(
                          _isPunchedInDummy ? Icons.logout : Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 50),
                        Text(
                          _isPunchedInDummy
                              ? "That's All For Today!"
                              : "Let's Start The Day!",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
