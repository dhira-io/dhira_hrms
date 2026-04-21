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
  final bool showBackground;
  final EdgeInsets? padding;

  const PunchCard({
    super.key,
    this.showBackground = true,
    this.padding,
  });

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
  String? _firstIn;

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
        _firstIn = status.firstIn;
      });
    }
  }

  void _handleDurationsLoaded(AttendanceWorkDurationsEntity durations) {
    if (mounted) {
      setState(() {
        int parsedHours = 0;
        int parsedMinutes = 0;
        if (durations.todayLabel.isNotEmpty) {
          final hMatch = RegExp(r'(\d+)h').firstMatch(durations.todayLabel);
          final mMatch = RegExp(r'(\d+)m').firstMatch(durations.todayLabel);
          if (hMatch != null) parsedHours = int.parse(hMatch.group(1)!);
          if (mMatch != null) parsedMinutes = int.parse(mMatch.group(1)!);
        }

        // Extract current ticking seconds to preserve them
        int currentSeconds = (_baseDuration + _stopwatch.elapsed).inSeconds.remainder(60);

        // If it's a brand new day (0h 0m) and not punched in, reset seconds to 0
        if (parsedHours == 0 && parsedMinutes == 0 && !_isPunchedIn) {
          currentSeconds = 0;
        }

        // Directly set the base duration to the new parsed time + current seconds
        _baseDuration = Duration(
          hours: parsedHours,
          minutes: parsedMinutes,
          seconds: currentSeconds,
        );

        // Reset stopwatch so it starts fresh from 0, avoiding any subtraction math
        _stopwatch.reset();

        // Keep stopwatch running state in sync with status
        if (_isPunchedIn && !_isOnBreak) {
          _stopwatch.start();
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



  @override
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
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Container(
            decoration: widget.showBackground
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFB3E5FC),
                      width: 1,
                    ),
                  )
                : null,
            child: Column(
              children: [
                // Header section with timer
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F5FE).withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        if (_isPunchedIn && _firstIn != null)
                          Text(
                            l10n.startedDayAt(
                              DateTimeUtils.convertDateStringToTime(_firstIn!),
                            ),
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        else if (!_isPunchedIn)
                          Text(
                            dateFormatted,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              timeFormatted,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: _isOnBreak
                                    ? const Color(0xFFFF6D00)
                                    : const Color(0xFF0000CC),
                                letterSpacing: 1.5,
                              ),
                            ),
                            if (_isOnBreak) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.pause,
                                color: Color(0xFFFF6D00),
                                size: 28,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isOnBreak ? l10n.onBreak : l10n.timeElapsed,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // The Action Button Row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      if (!_isPunchedIn)
                        // Case A: Not Punched In
                        _buildButton(
                          label: l10n.letsGo,
                          icon: Icons.login_outlined,
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
                            icon: Icons.pause_circle_outline,
                            color: loadingType == AttendanceActionType.takeBreak
                                ? const Color(0xFFFF6D00).withValues(alpha: 0.5)
                                : const Color(0xFFFF6D00),
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
                            icon: Icons.history_toggle_off,
                            color: loadingType == AttendanceActionType.punchOut
                                ? const Color(0xFFD32F2F).withValues(alpha: 0.5)
                                : const Color(0xFFD32F2F),
                            onTap: loadingType != null
                                ? null
                                : () => _onPunchOut(context),
                            isSpecificLoading:
                                loadingType == AttendanceActionType.punchOut,
                            loadingLabel: l10n.processing,
                          ),
                        ]
                      else
                        // Case C: Punched In, On Break
                        ...[
                          _buildButton(
                            label: l10n.resume,
                            icon: Icons.play_arrow,
                            color: loadingType == AttendanceActionType.endBreak
                                ? const Color(0xFFFF6D00).withValues(alpha: 0.5)
                                : const Color(0xFFFF6D00),
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
                            icon: Icons.history_toggle_off,
                            color: loadingType == AttendanceActionType.punchOut
                                ? const Color(0xFFD32F2F).withValues(alpha: 0.5)
                                : const Color(0xFFD32F2F),
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