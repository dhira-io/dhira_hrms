import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/regularization_constants.dart';

class RegularizationRequestTypeWidget extends StatelessWidget {
  final RegularizationRequestType selectedType;
  final Function(RegularizationRequestType) onTypeSelected;

  const RegularizationRequestTypeWidget({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<_RequestTypeItemData> types = [
      _RequestTypeItemData(
        type: RegularizationRequestType.missedPunch,
        label: l10n.missedPunch,
      ),
      _RequestTypeItemData(
        type: RegularizationRequestType.systemError,
        label: l10n.systemError,
      ),
      _RequestTypeItemData(
        type: RegularizationRequestType.networkIssues,
        label: l10n.networkIssues,
      ),
      _RequestTypeItemData(
        type: RegularizationRequestType.onFieldDuty,
        label: l10n.onFieldDuty,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.requestType, style: AppTextStyle.h3),
        const SizedBox(height: AppConstants.p16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 64,
          ),
          itemCount: types.length,
          itemBuilder: (context, index) {
            final item = types[index];
            final isSelected = selectedType == item.type;

            return GestureDetector(
              onTap: () => onTypeSelected(item.type),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    _CustomRadioButton(isSelected: isSelected),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.label,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: AppConstants.fs13,
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

class _RequestTypeItemData {
  final RegularizationRequestType type;
  final String label;

  _RequestTypeItemData({required this.type, required this.label});
}

class _CustomRadioButton extends StatelessWidget {
  final bool isSelected;

  const _CustomRadioButton({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.outlineVariant,
          width: isSelected ? 5 : 1.5,
        ),
        color: AppColors.white,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
              ),
            )
          : null,
    );
  }
}
