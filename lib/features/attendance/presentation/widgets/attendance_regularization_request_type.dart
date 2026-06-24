import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Text.rich(
          TextSpan(
            text: l10n.requestType,
            style: AppTextStyle.labelLargeBold,
            children: [
              TextSpan(
                text: AppConstants.mandatoryIndicator,
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.of(context).absentText,
                ),
              ),
            ],
          ),
        ),

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
                      ? AppColors.of(context).primary.withValues(alpha: 0.05)
                      : AppColors.of(context).surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.of(context).primary
                        : AppColors.of(context).border,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    _CustomRadioButton(isSelected: isSelected),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        item.label,
                        style: (isSelected
                                ? AppTextStyle.bodyMediumOneBold
                                : AppTextStyle.bodyMediumOneMedium)
                            .copyWith(
                          color: AppColors.of(context).textPrimary,
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
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.of(context).primary
              : AppColors.of(context).outlineVariant,
          width: isSelected ? 5 : 1.5,
        ),
        color: AppColors.of(context).surfaceContainerLowest,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.of(context).white,
                ),
              ),
            )
          : null,
    );
  }
}
