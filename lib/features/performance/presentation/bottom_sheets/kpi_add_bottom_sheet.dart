import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KpiAddBottomSheet extends StatefulWidget {
  final String kraName;

  const KpiAddBottomSheet({super.key, required this.kraName});

  @override
  State<KpiAddBottomSheet> createState() => _KpiAddBottomSheetState();
}

class _KpiAddBottomSheetState extends State<KpiAddBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _weightageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _weightageController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _weightageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: AppConstants.p24,
          right: AppConstants.p24,
          top: AppConstants.p24,
          bottom: AppConstants.p24 + bottomInset,
        ),
        decoration: BoxDecoration(
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
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).outlineVariant,
                    borderRadius: BorderRadius.circular(AppConstants.r2),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p24),
              Row(
                children: [
                  Text(l10n.addNewKpi, style: AppTextStyle.h3Bold),
                  const Spacer(),
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
              const SizedBox(height: AppConstants.p8),
              Text(
                '${l10n.kra}: ${widget.kraName}',
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).primary,
                ),
              ),
              const SizedBox(height: AppConstants.p24),
      
              // Title Field
              Text(
                l10n.kpiNameLabel,
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppConstants.p8),
              TextFormField(
                controller: _titleController,
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
                validator: (value) =>
                    value == null || value.isEmpty ? l10n.required : null,
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
                  if (value == null || value.isEmpty) return l10n.required;
                  final weightage = double.tryParse(value);
                  if (weightage == null || weightage < 0 || weightage > 100)
                    return l10n.weightageRangeError;
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.p32),
      
              // Action Button
              CommonButton(
                text: l10n.addKpi,
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PerformanceBloc>().add(
                      PerformanceEvent.kpiCreated(
                        title: _titleController.text,
                        weightage: double.parse(_weightageController.text),
                        kra: widget.kraName,
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
