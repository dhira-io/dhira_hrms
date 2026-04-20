import 'dart:async';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_work_durations_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../dialogs/punch_out_dialog.dart';

class PunchCard extends StatefulWidget {
  const PunchCard({super.key});

  @override
  State<PunchCard> createState() => _PunchCardState();
}

class _PunchCardState extends State<PunchCard> {
  Timer? _pollingTimer;

  late Timer _timer;
  final Stopwatch _stopwatch = Stopwatch();
  Duration _baseDuration = Duration.zero;
  bool _isPunchedIn = false;
  bool _isOnBreak = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopwatch.isRunning && mounted) {
        setState(() {}); // Trigger rebuild to update stopwatch text
      }
    });

    // Step 6 Polling: Every 30 seconds call lightweight status and work durations sync
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        context.read<AttendanceBloc>().add(
          const AttendanceEvent.workDurationsRequested(),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;
    final bloc = context.read<AttendanceBloc>();

    final l10n = AppLocalizations.of(context)!;

    // Sync with existing state if already loaded
    bloc.state.maybeWhen(
      loaded: (status, logs, calendarEvents, workDurations) {
        _handleStatusLoaded(status, l10n);
        if (workDurations != null) _handleDurationsLoaded(workDurations);
      },
      orElse: () {},
    );

    bloc.add(const AttendanceEvent.checkStatusRequested());
    bloc.add(const AttendanceEvent.workDurationsRequested());
  }

  void _handleStatusLoaded(status, AppLocalizations l10n) {
    if (!status.success) {
      ToastUtils.showError(l10n.somethingWentWrong);
      return;
    }

    if (mounted) {
      setState(() {
        _isPunchedIn = status.punchedIn;
        _isOnBreak = status.onBreak;
      });
    }
  }

  void _handleDurationsLoaded(AttendanceWorkDurationsEntity durations) {
    if (mounted) {
      setState(() {
        // Sync base duration for internal logic (like the 9h30m check)
        _baseDuration = Duration(
          milliseconds: (durations.todayHours * 3600 * 1000).toInt(),
        );
        _stopwatch.reset();

        // Still keep stopwatch for internal logic if needed, but display uses label
        if (_isPunchedIn && !_isOnBreak) {
          if (!_stopwatch.isRunning) _stopwatch.start();
        } else {
          _stopwatch.stop();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pollingTimer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }



  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final dateFormatted = DateTimeUtils.formatToFullDate(DateTime.now());

    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (status, logs, calendarEvents, workDurations) {
            _handleStatusLoaded(status, l10n);
            if (workDurations != null) _handleDurationsLoaded(workDurations);
            if (status.message != null && status.message!.isNotEmpty) {
              ToastUtils.showSuccess(status.message!);
            }
          },
          error: (message, events) {
            ToastUtils.showError(message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final timeFormatted = _formatDuration(
          _baseDuration + _stopwatch.elapsed,
        );
        AttendanceActionType? loadingType;
        if (state is Loading) {
          loadingType = state.actionType;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Column(
            children: [
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
                        color: _isOnBreak
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (_isPunchedIn) ...[
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
                              decoration: BoxDecoration(
                                color: _isOnBreak
                                    ? AppColors.warning
                                    : AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isOnBreak ? l10n.onBreak : l10n.present,
                              style: AppTextStyle.label.copyWith(
                                color: _isOnBreak
                                    ? AppColors.warning
                                    : AppColors.success,
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

              // The Action Button Row
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p4,
                ),
                child: Row(
                  children: [
                    if (!_isPunchedIn)
                      // Case A: Not Punched In
                      _buildButton(
                        label: l10n.punchIn,
                        icon: Icons.exit_to_app,
                        color: (loadingType == AttendanceActionType.punchIn)
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : AppColors.primary,
                        onTap: (loadingType != null)
                            ? null
                            : () => _onPunchIn(context),
                        isSpecificLoading:
                            loadingType == AttendanceActionType.punchIn,
                        loadingLabel: l10n.processing,
                      )
                    else if (!_isOnBreak)
                    // Case B: Punched In, Not on Break
                    ...[
                      _buildButton(
                        label: l10n.takeBreak,
                        icon: Icons.pause,
                        color: loadingType == AttendanceActionType.takeBreak
                            ? Colors.orange.withValues(alpha: 0.5)
                            : Colors.orange,
                        onTap: loadingType != null
                            ? null
                            : () => _onTakeBreak(context),
                        isSpecificLoading:
                            loadingType == AttendanceActionType.takeBreak,
                        loadingLabel: l10n.processing,
                      ),
                      const SizedBox(width: 12),
                      _buildButton(
                        label: l10n.thatsAllForToday,
                        icon: Icons.schedule,
                        color: loadingType == AttendanceActionType.punchOut
                            ? Colors.red.withValues(alpha: 0.5)
                            : Colors.red,
                        onTap: loadingType != null
                            ? null
                            : () => _onPunchOut(context),
                        isSpecificLoading:
                            loadingType == AttendanceActionType.punchOut,
                        loadingLabel: l10n.processing,
                      ),
                    ] else
                    // Case C: Punched In, On Break
                    ...[
                      _buildButton(
                        label: l10n.resume,
                        icon: Icons.play_arrow,
                        color: loadingType == AttendanceActionType.endBreak
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : AppColors.primary,
                        onTap: loadingType != null
                            ? null
                            : () => _onEndBreak(context),
                        isSpecificLoading:
                            loadingType == AttendanceActionType.endBreak,
                        loadingLabel: l10n.processing,
                      ),
                      const SizedBox(width: 12),
                      _buildButton(
                        label: l10n.thatsAllForToday,
                        icon: Icons.schedule,
                        color: loadingType == AttendanceActionType.punchOut
                            ? Colors.red.withValues(alpha: 0.5)
                            : Colors.red,
                        onTap: loadingType != null
                            ? null
                            : () => _onPunchOut(context),
                        isSpecificLoading:
                            loadingType == AttendanceActionType.punchOut,
                        loadingLabel: l10n.processing,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    required bool isSpecificLoading,
    required String loadingLabel,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSpecificLoading ? Icons.hourglass_bottom : icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  isSpecificLoading ? loadingLabel : label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPunchIn(BuildContext context) {
    setState(() {
      if (!_stopwatch.isRunning) _stopwatch.start();
    });
    context.read<AttendanceBloc>().add(
      const AttendanceEvent.punchInRequested(),
    );
  }

  void _onPunchOut(BuildContext context) {
    final currentTotal = _baseDuration + _stopwatch.elapsed;
    if (currentTotal.inMinutes < (9 * 60 + 30)) {
      showPunchOutDialog(
        context: context,
        baseDuration: _baseDuration,
        stopwatch: _stopwatch,
        onConfirm: () {
          setState(() {
            if (_stopwatch.isRunning) _stopwatch.stop();
          });
          context.read<AttendanceBloc>().add(
            const AttendanceEvent.punchOutRequested(),
          );
        },
      );
    } else {
      setState(() {
        if (_stopwatch.isRunning) _stopwatch.stop();
      });
      context.read<AttendanceBloc>().add(
        const AttendanceEvent.punchOutRequested(),
      );
    }
  }

  void _onTakeBreak(BuildContext context) {
    context.read<AttendanceBloc>().add(
      const AttendanceEvent.takeBreakRequested(),
    );
  }

  void _onEndBreak(BuildContext context) {
    context.read<AttendanceBloc>().add(
      const AttendanceEvent.endBreakRequested(),
    );
  }
}
