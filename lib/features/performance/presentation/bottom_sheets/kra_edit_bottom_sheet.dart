import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        padding: EdgeInsets.only(
          left: AppConstants.p24,
          right: AppConstants.p24,
          top: AppConstants.p24,
          bottom: AppConstants.p24 + bottomInset,
        ),
        decoration:  BoxDecoration(
          color: AppColors.of(context).surface,
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
                    color: AppColors.of(context).outlineVariant,
                    borderRadius: BorderRadius.circular(AppConstants.r2),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p24),
              Row(
                children: [
                  Text(l10n.editKra, style: AppTextStyle.h3Bold),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    splashRadius: 24,
                    icon: Icon(
                      Icons.close,
                      color: AppColors.of(context).onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p24),

              // KRA Name Field
              Text(
                l10n.kraNameLabel,
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppConstants.p8),
              TextFormField(
                controller: _nameController,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.of(context).surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    borderSide: BorderSide(
                      color: AppColors.of(context).outlineVariant.withValues(
                        alpha: AppConstants.opacityMedium,
                      ),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    borderSide: BorderSide(
                      color: AppColors.of(context).outlineVariant.withValues(
                        alpha: AppConstants.opacityLow,
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
                  color: AppColors.of(context).onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppConstants.p8),
              TextFormField(
                controller: _weightageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.of(context).surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    borderSide: BorderSide(
                      color: AppColors.of(context).outlineVariant.withValues(
                        alpha: AppConstants.opacityMedium,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    borderSide: BorderSide(
                      color: AppColors.of(context).outlineVariant.withValues(
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
              CommonButton(
                text: l10n.saveChanges,
                width: double.infinity,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
