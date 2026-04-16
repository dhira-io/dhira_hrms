import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Duration _baseDuration = Duration.zero;
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
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final empIdValue = prefs.getString(StorageConstants.empId);

    setState(() {
      _empid = empIdValue;
    });

    final bloc = context.read<AttendanceBloc>();

    // Sync with existing state if already loaded
    bloc.state.maybeWhen(
      loaded: (status, logs, calendarEvents) => _handleStatusLoaded(status),
      orElse: () {},
    );

    if (_empid != null) {
      bloc.add(AttendanceEvent.checkStatusRequested(_empid!));
    }
  }

  void _handleStatusLoaded(status) {
    if (!status.success) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (mounted) {
      setState(() {
        _isPunchedInDummy = status.punchedIn;
        if (_isPunchedInDummy) {
          if (status.firstIn != null && status.firstIn!.isNotEmpty) {
            try {
              final firstIn = DateTime.parse(status.firstIn!);
              if (!_stopwatch.isRunning) {
                _baseDuration = DateTime.now().difference(firstIn);
                _stopwatch.reset();
                _stopwatch.start();
              }
            } catch (e) {
              if (!_stopwatch.isRunning) _stopwatch.start();
            }
          } else {
            if (!_stopwatch.isRunning) _stopwatch.start();
          }
        } else {
          if (_stopwatch.isRunning) _stopwatch.stop();
        }
      });
    }
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

  void _showPunchOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            final currentTotal = _baseDuration + _stopwatch.elapsed;
            final formattedTime = _formatDuration(currentTotal);
            final isLess = currentTotal.inMinutes < (9 * 60 + 30);
            final title = isLess
                ? "You're logging out before completing 9hr 30min"
                : "Confirm Logout";

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              content: Text(
                "You've worked $formattedTime hrs. Are you sure you want to log out?",
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              actions: [
                SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      setState(() {
                        if (_stopwatch.isRunning) _stopwatch.stop();
                      });
                      context.read<AttendanceBloc>().add(
                        AttendanceEvent.punchOutRequested(_empid!),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Yes, log out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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
          loaded: (status, logs, calendarEvents) {
            _handleStatusLoaded(status);
            if (status.message != null && status.message!.isNotEmpty) {
              Fluttertoast.showToast(
                msg: status.message!,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
            }
          },
          error: (message, events) {
            Fluttertoast.showToast(
              msg: message,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final timeFormatted = _formatDuration(
          _baseDuration + _stopwatch.elapsed,
        );
        final isLoading = state is Loading;

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
                                fontSize: 13,
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
                onTap: isLoading
                    ? null
                    : () {
                        if (!_isPunchedInDummy) {
                          setState(() {
                            if (!_stopwatch.isRunning) _stopwatch.start();
                          });
                          context.read<AttendanceBloc>().add(
                            AttendanceEvent.punchInRequested(_empid!),
                          );
                        } else {
                          final currentTotal =
                              _baseDuration + _stopwatch.elapsed;
                          if (currentTotal.inMinutes < (9 * 60 + 30)) {
                            _showPunchOutDialog(context);
                          } else {
                            setState(() {
                              if (_stopwatch.isRunning) _stopwatch.stop();
                            });
                            context.read<AttendanceBloc>().add(
                              AttendanceEvent.punchOutRequested(_empid!),
                            );
                          }
                        }
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
                      color: isLoading
                          ? const Color(0xFF90CAF9).withOpacity(
                              0.8,
                            ) // Light blue for "Hang In There!"
                          : _isPunchedInDummy
                          ? Colors.orange
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isLoading
                              ? Icons.hourglass_bottom
                              : _isPunchedInDummy
                              ? Icons.logout
                              : Icons.exit_to_app,
                          color: isLoading
                              ? const Color(0xFF0D47A1)
                              : Colors.white,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isLoading
                              ? "Hang In There!"
                              : _isPunchedInDummy
                              ? "That's All For Today!"
                              : "Let's Start The Day!",
                          style: TextStyle(
                            color: isLoading
                                ? const Color(0xFF0D47A1)
                                : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
