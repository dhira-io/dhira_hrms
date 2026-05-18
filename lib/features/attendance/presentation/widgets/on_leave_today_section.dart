import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/team_leave_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/string_utils.dart';

class OnLeaveTodaySection extends StatelessWidget {
  final List<TeamLeaveEntity>? leaves;

  const OnLeaveTodaySection({super.key, this.leaves});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Text(
            l10n.teamOnLeave,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (leaves == null)
          const _LoadingView()
        else if (leaves!.isEmpty)
          const _EmptyView()
        else
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
              itemCount: leaves!.length,
              itemBuilder: (context, index) {
                return _LeaveCard(leave: leaves![index]);
              },
            ),
          ),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.all(AppConstants.p16),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppConstants.r20),
              border: Border.all(color: AppColors.of(context).border.withValues(alpha: 0.5)),
            ),
            child: Shimmer.fromColors(
              baseColor: AppColors.of(context).shimmerBase,
              highlightColor: AppColors.of(context).shimmerHighlight,
              child: Column(
                children: [
                   CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.of(context).white,
                  ),
                  const SizedBox(height: AppConstants.p12),
                  Container(
                    height: 14,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 10,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).white,
                      borderRadius: BorderRadius.circular(AppConstants.r24),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.p20),
        decoration: BoxDecoration(
          color: AppColors.of(context).surface,
          borderRadius: BorderRadius.circular(AppConstants.r16),
          border: Border.all(color: AppColors.of(context).border.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: AppColors.of(context).textPrimary.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          l10n.noOneOnLeaveToday,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final TeamLeaveEntity leave;

  const _LeaveCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    final imageUrl = leave.image;
    final fullImageUrl = imageUrl != null && imageUrl.isNotEmpty
        ? (imageUrl.isAbsoluteUrl
              ? imageUrl
              : '${ApiConstants.baseUrl}${imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl}')
        : null;

    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.of(context).slate100,
            backgroundImage: fullImageUrl != null
                ? NetworkImage(fullImageUrl)
                : null,
            child: fullImageUrl == null
                ? Icon(Icons.person, size: 30, color: AppColors.of(context).slate400)
                : null,
          ),
          const SizedBox(height: AppConstants.p12),
          Text(
            leave.employeeName,
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.of(context).textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            leave.designation ?? '',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
              fontSize: AppConstants.fs11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          _LeaveTypeChip(leaveType: leave.leaveType),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _LeaveTypeChip extends StatelessWidget {
  final String leaveType;

  const _LeaveTypeChip({required this.leaveType});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color bgColor = AppColors.of(context).infoBg;
    Color textColor = AppColors.of(context).info;
    String displayLabel = leaveType;

    final t = leaveType.toLowerCase();
    if (t.contains(LeaveType.sick)) {
      bgColor = AppColors.of(context).sickTrack;
      textColor = AppColors.of(context).sickText;
      displayLabel = l10n.sick;
    } else if (t.contains(LeaveType.casual)) {
      bgColor = AppColors.of(context).casualTrack;
      textColor = AppColors.of(context).casualText;
      displayLabel = l10n.casual;
    } else if (t.contains(LeaveType.earned)) {
      bgColor = AppColors.of(context).earnedTrack;
      textColor = AppColors.of(context).earnedText;
      displayLabel = l10n.earned;
    } else if (t.contains(LeaveType.privileged)) {
      bgColor = AppColors.of(context).earnedTrack;
      textColor = AppColors.of(context).earnedText;
      displayLabel = l10n.privileged;
    } else if (t.contains(LeaveType.bereavement)) {
      bgColor = AppColors.of(context).bereavementTrack;
      textColor = AppColors.of(context).bereavementText;
      displayLabel = l10n.bereavement;
    } else if (t.contains(LeaveType.paternity)) {
      bgColor = AppColors.of(context).paternityTrack;
      textColor = AppColors.of(context).paternityText;
      displayLabel = l10n.paternity;
    } else if (t.contains(LeaveType.maternity)) {
      bgColor = AppColors.of(context).maternityTrack;
      textColor = AppColors.of(context).maternityText;
      displayLabel = l10n.maternity;
    } else if (t.contains(LeaveType.restricted)) {
      bgColor = AppColors.of(context).restrictedTrack;
      textColor = AppColors.of(context).restrictedText;
      displayLabel = l10n.restricted;
    } else if (t.contains(LeaveType.compensatory)) {
      bgColor = AppColors.of(context).compensatoryTrack;
      textColor = AppColors.of(context).compensatoryText;
      displayLabel = l10n.compensatory;
    } else if (t.contains(LeaveType.vacation)) {
      bgColor = AppColors.of(context).slate100;
      textColor = AppColors.of(context).slate600;
      displayLabel = l10n.vacation;
    } else if (t.contains(AttendanceStatus.halfDay) || t.contains('half')) {
      bgColor = AppColors.of(context).halfDayBg;
      textColor = AppColors.of(context).halfDayText;
      displayLabel = l10n.halfDay;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.r24),
      ),
      child: Text(
        displayLabel,
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: AppConstants.fs11,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
