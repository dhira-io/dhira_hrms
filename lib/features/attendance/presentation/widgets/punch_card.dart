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
          if (status.firstIn != null) {
            try {
              final firstIn = DateTime.parse(status.firstIn!);
              _baseDuration = DateTime.now().difference(firstIn);
              if (!_stopwatch.isRunning) {
                _stopwatch.start();
              }
            } catch (e) {
              _baseDuration = Duration.zero;
            }
          } else {}
        } else {
          _stopwatch.stop();
          _stopwatch.reset();
          _baseDuration = Duration.zero;
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
                          context.read<AttendanceBloc>().add(
                            AttendanceEvent.punchInRequested(_empid!),
                          );
                        } else {
                          context.read<AttendanceBloc>().add(
                            AttendanceEvent.punchOutRequested(_empid!),
                          );
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
