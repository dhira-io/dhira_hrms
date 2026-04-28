import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/constants/attendance_api_constants.dart';

class RegularizationRequestType extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const RegularizationRequestType({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final types = [
      _RequestTypeItem(
        id: RegularizationRequestTypeConstants.forgotToPunch,
        label: l10n.forgotToPunch,
        icon: Icons.person_off_rounded,
        color: AppColors.primary,
      ),
      _RequestTypeItem(
        id: RegularizationRequestTypeConstants.wrongPunchTime,
        label: l10n.wrongPunchTime,
        icon: Icons.schedule_rounded,
        color: AppColors.primary,
      ),
      _RequestTypeItem(
        id: RegularizationRequestTypeConstants.systemError,
        label: l10n.systemError,
        icon: Icons.error_outline_rounded,
        color: AppColors.primary,
      ),
      _RequestTypeItem(
        id: RegularizationRequestTypeConstants.networkIssue,
        label: l10n.networkIssue,
        icon: Icons.wifi_off_rounded,
        color: AppColors.primary,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.requestType,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2,
          ),
          itemCount: types.length,
          itemBuilder: (context, index) {
            final type = types[index];
            final isSelected = selectedType == type.id;

            return InkWell(
              onTap: () => onTypeSelected(type.id),
              borderRadius: BorderRadius.circular(AppConstants.r8),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.p16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          type.icon,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.onSurfaceVariant,
                          size: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type.label,
                          style: AppTextStyle.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.onSurface,
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.outlineVariant,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RequestTypeItem {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  _RequestTypeItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}
