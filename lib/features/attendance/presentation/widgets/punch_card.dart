import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final bool showDateAndTime;
  final Color? breakButtonColor;
  final Color? punchOutColor;

  const PunchCard({
    super.key,
    this.showBackground = true,
    this.padding,
    this.showDateAndTime = true,
    this.breakButtonColor,
    this.punchOutColor,
  });

  @override
  State<PunchCard> createState() => _PunchCardState();
}

class _PunchCardState extends State<PunchCard> with WidgetsBindingObserver {
  Timer? _pollingTimer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopPolling();
    } else if (state == AppLifecycleState.resumed) {
      _startPolling();
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        context.read<AttendanceBloc>().add(
          const AttendanceEvent.checkStatusRequested(),
        );
      }
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Timer? _timer;
  int _workedSeconds = 0;
  int? _serverTimeMs;
  bool _isPunchedIn = false;
  bool _isOnBreak = false;
  String? _firstIn;

  int get _computedWorkedSeconds {
    if (!_isPunchedIn || _isOnBreak) {
      return _workedSeconds;
    }
    if (_serverTimeMs == null) {
      return _workedSeconds;
    }
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final elapsedSeconds = (nowMs - _serverTimeMs!) ~/ 1000;
    return _workedSeconds + elapsedSeconds;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() {}); // Trigger rebuild to update time text visually
          }
        });

        _startPolling();

        _fetchInitialData();
      }
    });
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;
    final bloc = context.read<AttendanceBloc>();

    final l10n = AppLocalizations.of(context)!;

    // Sync with existing state if already loaded
    bloc.state.mapOrNull(
      loaded: (loadedState) {
        _handleStatusLoaded(loadedState.status, l10n);
      },
    );

    bloc.add(const AttendanceEvent.checkStatusRequested());
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
        _workedSeconds = status.workedSeconds ?? 0;
        _serverTimeMs = status.serverTimeMs;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _stopPolling();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
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
      listenWhen: (previous, current) =>
          current.mapOrNull(loaded: (_) => true, error: (_) => true) == true,
      listener: (context, state) {
        state.mapOrNull(
          loaded: (loadedState) {
            _handleStatusLoaded(loadedState.status, l10n);
            if (loadedState.status.message != null && loadedState.status.message!.isNotEmpty) {
              ToastUtils.showSuccess(loadedState.status.message!);
            }
          },
          error: (errorState) {
            ToastUtils.showError(errorState.message);
          },
        );
      },
      builder: (context, state) {
        final timeFormatted = _formatDuration(_computedWorkedSeconds);
        final loadingType = state.mapOrNull(loading: (s) => s.actionType);

        if (state.mapOrNull(loading: (s) => s.actionType) ==
            AttendanceActionType.checkStatus) {
          return Padding(
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: AppConstants.p15),
            child: const PunchCardSkeleton(),
          );
        }

        final showHeader = _isPunchedIn || widget.showDateAndTime;

        return Padding(
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Container(
            decoration: widget.showBackground
                ? BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16.r),
                    border: (widget.showDateAndTime || _isPunchedIn)
                        ? Border.all(
                            color: AppColors.of(context).profileBadgeBorder,
                            width: 1.w,
                          )
                        : null,
                  )
                : null,
            child: Column(
              children: [
                if (showHeader) ...[
                  PunchHeader(
                    isPunchedIn: _isPunchedIn,
                    isOnBreak: _isOnBreak,
                    firstIn: _firstIn,
                    timeFormatted: timeFormatted,
                    dateFormatted: dateFormatted,
                  ),
                        SizedBox(height: 16.h),
                ],
                PunchActionButtonRow(
                  padding: widget.showDateAndTime
                      ? null
                      : (_isPunchedIn
                            ?       EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 8.h,
                              )
                            : EdgeInsets.zero),
                  breakButtonColor: widget.breakButtonColor,
                  punchOutColor: widget.punchOutColor,
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
      _isPunchedIn = true;
      _isOnBreak = false;
      _serverTimeMs = DateTime.now().millisecondsSinceEpoch;
    });
    context.read<AttendanceBloc>().add(
      const AttendanceEvent.punchInRequested(),
    );
  }

  void _onPunchOut(BuildContext context) {
    final currentTotalMinutes = _computedWorkedSeconds ~/ 60;
    if (currentTotalMinutes < (9 * 60 + 30)) {
      showPunchOutDialog(
        context: context,
        getWorkedSeconds: () => _computedWorkedSeconds,
        onConfirm: () {
          setState(() {
            _isPunchedIn = false;
          });
          context.read<AttendanceBloc>().add(
            const AttendanceEvent.punchOutRequested(),
          );
        },
      );
    } else {
      setState(() {
        _isPunchedIn = false;
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
