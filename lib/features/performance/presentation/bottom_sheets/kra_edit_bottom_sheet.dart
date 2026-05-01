import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kra_entity.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KraEditBottomSheet extends StatefulWidget {
  final KraEntity kra;

  const KraEditBottomSheet({super.key, required this.kra});

  @override
  State<KraEditBottomSheet> createState() => _KraEditBottomSheetState();
}

class _KraEditBottomSheetState extends State<KraEditBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _weightageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.kra.name);
    _weightageController = TextEditingController(
      text: widget.kra.weightage.toInt().toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: AppConstants.p24,
        right: AppConstants.p24,
        top: AppConstants.p24,
        bottom: AppConstants.p24 + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.r24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(AppConstants.r2),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.p24),
            Row(
              children: [
                Text(
                  l10n.editKra,
                  style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  splashRadius: 24,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p24),

            // KRA Name Field
            Text(
              l10n.kraNameLabel,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppConstants.p8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: BorderSide(
                    color: AppColors.outlineVariant.withValues(
                      alpha: AppConstants.opacityMedium,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: BorderSide(
                    color: AppColors.outlineVariant.withValues(
                      alpha: AppConstants.opacityMedium,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p16,
                  vertical: AppConstants.p14,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.required;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.p16),

            // Weightage Field
            Text(
              l10n.weightageLabel,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppConstants.p8),
            TextFormField(
              controller: _weightageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainerLowest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: BorderSide(
                    color: AppColors.outlineVariant.withValues(
                      alpha: AppConstants.opacityMedium,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: BorderSide(
                    color: AppColors.outlineVariant.withValues(
                      alpha: AppConstants.opacityMedium,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p16,
                  vertical: AppConstants.p14,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.required;
                }
                final weightage = double.tryParse(value);
                if (weightage == null || weightage < 0 || weightage > 100) {
                  return l10n.weightageRangeError;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.p32),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PerformanceBloc>().add(
                      PerformanceEvent.kraUpdated(
                        oldKra: widget.kra,
                        newName: _nameController.text,
                        newWeightage: double.parse(_weightageController.text),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  elevation: 0,
                  overlayColor: AppColors.white.withValues(alpha: 0.12),
                ),
                child: Text(
                  l10n.saveChanges,
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
