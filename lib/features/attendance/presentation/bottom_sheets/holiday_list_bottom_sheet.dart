import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/holiday_list_leave_policy_entity.dart';
import '../../domain/entities/attendance_month_summary_entity.dart';

class HolidayListBottomSheet extends StatelessWidget {
  final List<HolidayEntity> regularHolidays;
  final List<RestrictedHolidayEntity> optionalHolidays;
  final bool isYearly;

  const HolidayListBottomSheet({
    super.key,
    required this.regularHolidays,
    required this.optionalHolidays,
    this.isYearly = true,
  });

  static Future<void> showYearly(
    BuildContext context,
    HolidayListLeavePolicyEntity policy,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final saturdayStr = l10n.saturday.toLowerCase();
    final sundayStr = l10n.sunday.toLowerCase();

    // Filter holidays
    final regularHolidays = policy.holidayList.holidays.where((h) {
      final desc = h.description.toLowerCase();
      return !desc.contains(saturdayStr) && !desc.contains(sundayStr);
    }).toList();

    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.r20),
        ),
      ),
      builder: (context) => HolidayListBottomSheet(
        regularHolidays: regularHolidays,
        optionalHolidays: policy.holidayList.customRestrictedHolidays,
        isYearly: true,
      ),
    );
  }

  static Future<void> showMonthly(
    BuildContext context,
    List<HolidayDetailEntity> holidays,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.r20),
        ),
      ),
      builder: (context) => HolidayListBottomSheet(
        regularHolidays: holidays
            .map(
              (h) => HolidayEntity(
                holidayDate: h.date,
                description: h.name,
                weeklyOff: 0,
              ),
            )
            .toList(),
        optionalHolidays: const [],
        isYearly: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed Header
          _HolidayHeader(
            isYearly: isYearly,
            regularHolidaysCount: regularHolidays.length,
            optionalHolidaysCount: optionalHolidays.length,
            l10n: l10n,
            onClose: () => Navigator.pop(context),
          ),

          // Scrollable List
          Flexible(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppConstants.p24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Regular Holidays Section
                      _SectionHeader(
                        title: isYearly
                            ? l10n.regularHolidays
                            : l10n.monthlyHolidays,
                      ),
                      const SizedBox(height: 16),
                      ...regularHolidays.map(
                        (h) => _HolidayCard(
                          date: h.holidayDate,
                          name: h.description,
                          isOptional: false,
                        ),
                      ),

                      if (isYearly && optionalHolidays.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        // Optional Holidays Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionHeader(title: l10n.optionalHolidays),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.p8,
                                vertical: AppConstants.p4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.tertiaryContainer.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.r24,
                                ),
                              ),
                              child: Text(
                                "(${l10n.restricted})",
                                style: AppTextStyle.labelSmall.copyWith(
                                  color: AppColors.tertiaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...optionalHolidays.map(
                          (h) => _HolidayCard(
                            date: h.holidayDate,
                            name: h.description,
                            isOptional: true,
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HolidayHeader extends StatelessWidget {
  final bool isYearly;
  final int regularHolidaysCount;
  final int optionalHolidaysCount;
  final AppLocalizations l10n;
  final VoidCallback onClose;

  const _HolidayHeader({
    required this.isYearly,
    required this.regularHolidaysCount,
    required this.optionalHolidaysCount,
    required this.l10n,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.holidayList,
                  style: AppTextStyle.h1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                    fontSize: AppConstants.iconMedium,
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (isYearly) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: l10n.regular,
                      count: regularHolidaysCount,
                      icon: Icons.calendar_month,
                      iconColor: AppColors.primary,
                      iconBg: AppColors.primaryFixed,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SummaryCard(
                      title: l10n.optional,
                      count: optionalHolidaysCount,
                      icon: Icons.event_available,
                      iconColor: AppColors.tertiaryContainer,
                      iconBg: AppColors.tertiaryContainer.withValues(
                        alpha: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppConstants.p6),
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: AppConstants.iconSmall,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                count.toString(),
                style: AppTextStyle.h1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                l10n.daysLabel,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.h2.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: AppConstants.iconSmall,
        color: AppColors.onSurface,
      ),
    );
  }
}

class _HolidayCard extends StatelessWidget {
  final String date;
  final String name;
  final bool isOptional;

  const _HolidayCard({
    required this.date,
    required this.name,
    required this.isOptional,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.tryParse(date) ?? DateTime.now();
    final dayNumber = DateTimeUtils.getDayNumber(parsedDate);
    final monthAbbr = DateTimeUtils.getMonthAbbr(parsedDate);
    final dayName = DateTimeUtils.getDayName(parsedDate);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayNumber,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                    height: 1.1,
                  ),
                ),
                Text(
                  monthAbbr,
                  style: AppTextStyle.labelSmall.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  dayName,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
