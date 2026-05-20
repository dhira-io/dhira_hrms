import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class KraSearchableDropdown extends StatefulWidget {
  final List<String> options;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const KraSearchableDropdown({
    super.key,
    required this.options,
    required this.controller,
    required this.hintText,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<KraSearchableDropdown> createState() => _KraSearchableDropdownState();
}

class _KraSearchableDropdownState extends State<KraSearchableDropdown> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && widget.controller.text.isEmpty) {
      // Nudge the controller to trigger the autocomplete overlay
      widget.controller.notifyListeners();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
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
          return option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      onSelected: (String selection) {
        widget.controller.text = selection;
      },
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
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
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: textEditingController,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // if (value.text.isNotEmpty)
                        //   IconButton(
                        //     icon: Icon(Icons.close, size: AppConstants.iconSmall),
                        //     onPressed: () {
                        //       textEditingController.clear();
                        //       WidgetsBinding.instance.addPostFrameCallback((_) {
                        //         _focusNode.requestFocus();
                        //       });
                        //     },
                        //     padding: EdgeInsets.zero,
                        //     constraints: const BoxConstraints(),
                        //     splashRadius: 20,
                        //     color: AppColors.of(context).onSurfaceVariant,
                        //   ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.of(context).onSurfaceVariant,
                        ),
                        const SizedBox(width: AppConstants.p8),
                      ],
                    );
                  },
                ),
              ),
              validator: widget.validator,
              autovalidateMode: widget.autovalidateMode,
            );
          },
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(AppConstants.r12),
                child: Container(
                  width:
                      MediaQuery.of(context).size.width -
                      (AppConstants.p24 * 2),
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surface,
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
