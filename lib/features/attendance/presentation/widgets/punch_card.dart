import 'dart:async';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_work_durations_entity.dart';
import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_action_buttons.dart';
import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_card_skeleton.dart';
import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../dialogs/punch_out_dialog.dart';

class PunchCard extends StatefulWidget {
  final bool showBackground;
  final EdgeInsets? padding;

  const PunchCard({super.key, this.showBackground = true, this.padding});

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

    // Polling: Every 30 seconds call lightweight status and work durations sync
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
      loaded: (status, logs, calendarEvents, workDurations, _, __, _, _, _, _) {
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
        final parsedDuration = DateTimeUtils.parseDurationLabel(
          durations.todayLabel,
        );
        int parsedHours = parsedDuration.inHours;
        int parsedMinutes = parsedDuration.inMinutes.remainder(60);

        // Extract current ticking seconds to preserve them
        int currentSeconds = (_baseDuration + _stopwatch.elapsed).inSeconds
            .remainder(60);

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
          loaded:
              (status, logs, calendarEvents, workDurations, _, __, _, _, _, _) {
                _handleStatusLoaded(status, l10n);
                if (workDurations != null)
                  _handleDurationsLoaded(workDurations);
                if (status.message != null && status.message!.isNotEmpty) {
                  ToastUtils.showSuccess(status.message!);
                }
              },
          error: (message, events, _, __, _, _, _, _) {
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

        if (state is Loading &&
            state.actionType == AttendanceActionType.checkStatus) {
          return Padding(
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: AppConstants.p15),
            child: const PunchCardSkeleton(),
          );
        }

        return Padding(
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Container(
            decoration: widget.showBackground
                ? BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.profileBadgeBorder,
                      width: 1,
                    ),
                  )
                : null,
            child: Column(
              children: [
                PunchHeader(
                  isPunchedIn: _isPunchedIn,
                  isOnBreak: _isOnBreak,
                  firstIn: _firstIn,
                  timeFormatted: timeFormatted,
                  dateFormatted: dateFormatted,
                ),
                const SizedBox(height: 16),
                PunchActionButtonRow(
                  isPunchedIn: _isPunchedIn,
                  isOnBreak: _isOnBreak,
                  loadingType: loadingType,
                  onPunchIn: () => _onPunchIn(context),
                  onTakeBreak: () => _onTakeBreak(context),
                  onPunchOut: () => _onPunchOut(context),
                  onEndBreak: () => _onEndBreak(context),
                ),
              ],
            ),
          ),
        );
      },
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
