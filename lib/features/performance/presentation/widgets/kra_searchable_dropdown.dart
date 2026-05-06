import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class KraSearchableDropdown extends StatefulWidget {
  final List<String> options;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const KraSearchableDropdown({
    super.key,
    required this.options,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  State<KraSearchableDropdown> createState() => _KraSearchableDropdownState();
}

class _KraSearchableDropdownState extends State<KraSearchableDropdown> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: widget.controller,
      focusNode: _focusNode,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return widget.options;
        }
        return widget.options.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        widget.controller.text = selection;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(color: AppColors.outlineVariant.withValues(alpha: AppConstants.opacityMedium)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(color: AppColors.outlineVariant.withValues(alpha: AppConstants.opacityMedium)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p14),
            suffixIcon: const Icon(Icons.arrow_drop_down, color: AppColors.onSurfaceVariant),
          ),
          validator: widget.validator,
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Container(
              width: MediaQuery.of(context).size.width - (AppConstants.p24 * 2),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.r12),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.p16),
                      child: Text(option, style: AppTextStyle.bodyMedium),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
