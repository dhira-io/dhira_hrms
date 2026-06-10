import 'package:flutter/material.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../bloc/country_code_cubit.dart';
import '../bloc/country_code_state.dart';
import '../../domain/entities/country_code_entity.dart';

class PhoneFieldCubit extends Cubit<String> {
  PhoneFieldCubit(super.initialState);

  void updateCode(String code) => emit(code);
}

class PhoneField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;

  const PhoneField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.validator,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late PhoneFieldCubit _phoneFieldCubit;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _phoneFieldCubit = PhoneFieldCubit('+91');
    _initControllers([]);
    context.read<CountryCodeCubit>().fetchCountryCodes();
  }

  void _initControllers(List<CountryCodeEntity> codes) {
    String text = widget.controller.text.trim();
    final codesToCheck = codes.isNotEmpty ? codes.map((e) => e.code).toList() : ['+91'];

    if (text.isNotEmpty) {
      for (var code in codesToCheck) {
        if (text.startsWith(code)) {
          _phoneFieldCubit.updateCode(code);
          text = text.substring(code.length).trim();
          break;
        }
      }
    }
    _numberController = TextEditingController(text: text);
    _numberController.addListener(_updateMainController);
  }

  @override
  void didUpdateWidget(PhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _numberController.removeListener(_updateMainController);
      final state = context.read<CountryCodeCubit>().state;
      final codes = state.maybeWhen(
        loaded: (c) => c,
        orElse: () => <CountryCodeEntity>[],
      );
      _initControllers(codes);
    } else if (widget.controller.text != _getCombinedText()) {
      _numberController.removeListener(_updateMainController);
      final state = context.read<CountryCodeCubit>().state;
      final codes = state.maybeWhen(
        loaded: (c) => c,
        orElse: () => <CountryCodeEntity>[],
      );
      _initControllers(codes);
    }
  }

  void _updateMainController() {
    widget.controller.text = _getCombinedText();
  }

  String _getCombinedText() {
    if (_numberController.text.trim().isEmpty) return '';
    return '${_phoneFieldCubit.state} ${_numberController.text.trim()}';
  }

  @override
  void dispose() {
    _numberController.removeListener(_updateMainController);
    _numberController.dispose();
    super.dispose();
  }

  void _showCountryCodeSelector(List<CountryCodeEntity> codes) {
    if (codes.isEmpty) return;
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _CountryCodeSelectorSheet(countryCodes: codes);
      },
    ).then((selectedCode) {
      if (selectedCode != null) {
        _phoneFieldCubit.updateCode(selectedCode);
        _updateMainController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderSide = BorderSide(
      color: isDark
          ? AppColors.of(context).border
          : AppColors.of(context).bordergrey,
    );

    return BlocProvider.value(
      value: _phoneFieldCubit,
      child: BlocConsumer<CountryCodeCubit, CountryCodeState>(
        listener: (context, state) {
        state.whenOrNull(
          loaded: (codes) {
            _numberController.removeListener(_updateMainController);
            _initControllers(codes);
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          initial: () => true,
          orElse: () => false,
        );
        final countryCodes = state.maybeWhen(
          loaded: (codes) => codes,
          orElse: () => <CountryCodeEntity>[],
        );

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                child: InkWell(
                  onTap: () => _showCountryCodeSelector(countryCodes),
                  borderRadius: BorderRadius.circular(12.r),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.of(context).profileInfoCardBg,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: borderSide,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: borderSide,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: isLoading
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: ShimmerLoading(
                                    height: 16.h,
                                    width: 50.w,
                                    borderRadius: 4.r,
                                  ),
                                )
                              : BlocSelector<PhoneFieldCubit, String, String>(
                                  selector: (state) => state,
                                  builder: (context, selectedCountryCode) {
                                    String currentLabel = selectedCountryCode;
                                    if (countryCodes.isNotEmpty) {
                                      final match = countryCodes.firstWhere(
                                        (c) => c.code == selectedCountryCode,
                                        orElse: () => CountryCodeEntity(
                                            code: selectedCountryCode,
                                            label: selectedCountryCode),
                                      );
                                      currentLabel = match.label;
                                    }

                                    return Text(
                                      currentLabel,
                                      style: AppTextStyle.bodyLarge.copyWith(
                                        color: AppColors.of(context).textPrimary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.of(context).textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextFormField(
                  controller: _numberController,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.of(context).textPrimary,
                  ),
                  validator: widget.validator != null
                      ? (val) => widget.validator!(_getCombinedText())
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).error,
                        width: 1.0.w,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).error,
                        width: 1.5.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}

class _CountryCodeSelectorSheet extends StatefulWidget {
  final List<CountryCodeEntity> countryCodes;

  const _CountryCodeSelectorSheet({required this.countryCodes});

  @override
  State<_CountryCodeSelectorSheet> createState() => _CountryCodeSelectorSheetState();
}

class _CountryCodeSelectorSheetState extends State<_CountryCodeSelectorSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredCodes = widget.countryCodes.where((country) {
      return country.label.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchCountryCode,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.of(context).textSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.of(context).profileInfoCardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppColors.of(context).textPrimary,
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCodes.length,
                itemBuilder: (context, index) {
                  final country = filteredCodes[index];
                  return ListTile(
                    title: Text(
                      country.label,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(country.code);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
