import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationDetailsSection extends StatelessWidget {
  final TextEditingController inTimeController;
  final TextEditingController outTimeController;
  final TextEditingController reasonController;
  final bool routeToHR;
  final Function(bool?) onRouteToHRChanged;
  final Function(TimeOfDay) onInTimeChanged;
  final Function(TimeOfDay) onOutTimeChanged;

  const RegularizationDetailsSection({
    super.key,
    required this.inTimeController,
    required this.outTimeController,
    required this.reasonController,
    required this.routeToHR,
    required this.onRouteToHRChanged,
    required this.onInTimeChanged,
    required this.onOutTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //    padding: const EdgeInsets.only(left: AppConstants.p12),
          decoration: const BoxDecoration(),
          child: Text(
            l10n.requestedDetails,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        Row(
          children: [
            Expanded(
              child: _TimeInput(
                label: l10n.reqInTime,
                controller: inTimeController,
                onTimeSelected: onInTimeChanged,
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: _TimeInput(
                label: l10n.reqOutTime,
                controller: outTimeController,
                onTimeSelected: onOutTimeChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        Container(
          padding: const EdgeInsets.all(AppConstants.p12),
          decoration: BoxDecoration(
            color: AppColors.primaryFixed.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: routeToHR,
                  onChanged: onRouteToHRChanged,
                  activeColor: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.routeToHR,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onPrimaryFixed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      l10n.routeToHRSub,
                      style: AppTextStyle.labelSmall.copyWith(
                        fontSize: AppConstants.fs10,
                        color: AppColors.onSecondaryFixedVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        Text.rich(
          TextSpan(
            text: l10n.reasonForCorrection,
            style: AppTextStyle.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.absentText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.p8),
        TextField(
          controller: reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: l10n.explainDiscrepancy,
            fillColor: AppColors.surfaceContainerHighest,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(AppConstants.p16),
          ),
          style: AppTextStyle.bodySmall,
        ),
      ],
    );
  }
}

class _TimeInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(TimeOfDay) onTimeSelected;

  const _TimeInput({
    required this.label,
    required this.controller,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelSmall.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: AppConstants.fs10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p8),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.dialOnly,
            );
            if (time != null) {
              if (!context.mounted) return;
              controller.text = time.format(context);
              onTimeSelected(time);
            }
          },
          decoration: InputDecoration(
            fillColor: AppColors.surfaceContainerHighest,
            filled: true,
            suffixIcon: const Icon(
              Icons.schedule,
              size: AppConstants.iconSmall,
              color: AppColors.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p12,
              vertical: AppConstants.p10,
            ),
          ),
          style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
