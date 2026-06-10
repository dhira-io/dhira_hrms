import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../bloc/nationality_cubit.dart';

class NationalityAutocompleteField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;

  const NationalityAutocompleteField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.validator,
  });

  @override
  State<NationalityAutocompleteField> createState() =>
      _NationalityAutocompleteFieldState();
}

class _NationalityAutocompleteFieldState
    extends State<NationalityAutocompleteField> {
  @override
  void initState() {
    super.initState();
    context.read<NationalityCubit>().fetchNationalities();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderSide = BorderSide(
      color: isDark
          ? AppColors.of(context).border
          : AppColors.of(context).bordergrey,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Autocomplete<String>(
        initialValue: TextEditingValue(text: widget.controller.text),
        optionsBuilder: (TextEditingValue textEditingValue) {
          final state = context.read<NationalityCubit>().state;
          final currentList = state.maybeWhen(
            loaded: (nationalities) => nationalities,
            orElse: () => AppConstants.nationalities,
          );

          if (textEditingValue.text.isEmpty) {
            return currentList;
          }
          return currentList.where((String option) {
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
              textEditingController.addListener(() {
                widget.controller.text = textEditingController.text;
              });

              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                scrollPadding: EdgeInsets.only(bottom: 250.h),
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppColors.of(context).textPrimary,
                ),
                validator: widget.validator,
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Icon(
                      widget.icon,
                      color: AppColors.of(context).textSecondary,
                      size: 20,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  filled: true,
                  fillColor: AppColors.of(context).profileInfoCardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: borderSide,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: borderSide,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.of(context).primary,
                      width: 1.5.w,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
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
                  borderRadius: BorderRadius.circular(12.r),
                  color: isDark
                      ? AppColors.of(context).surface
                      : AppColors.of(context).white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 32.w,
                    height: 250.h,
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Text(
                              option,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textPrimary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
      ),
    );
  }
}
