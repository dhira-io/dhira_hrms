import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

class PunchCard extends StatelessWidget {
  const PunchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (status, logs) {
            final isPunchedIn = status.isPunchedIn;
            final punchColor = isPunchedIn ? AppColors.warning : AppColors.primary;

            return Container(
              padding: const EdgeInsets.all(AppConstants.p20),
              margin: const EdgeInsets.all(AppConstants.p15),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.r20),
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
                        context.read<AttendanceBloc>().add(const AttendanceEvent.punchOutRequested());
                      } else {
                        context.read<AttendanceBloc>().add(const AttendanceEvent.punchInRequested());
                      }
                    },
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: punchColor.withValues(alpha: 0.1),
                        border: Border.all(color: punchColor, width: 2),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.touch_app, size: 50, color: punchColor),
                            const SizedBox(height: AppConstants.p10),
                            Text(
                              isPunchedIn ? l10n.punchOut : l10n.punchIn,
                              style: AppTextStyle.h3.copyWith(
                                color: punchColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.p20),
                  Text(
                    status.statusText,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(AppConstants.p40), child: CircularProgressIndicator())),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
