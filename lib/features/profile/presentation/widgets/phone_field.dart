import 'package:flutter/material.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import 'package:dio/dio.dart';

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

  static String? validatePhoneNumber(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) return null;

    final trimmed = value.trim();

    // Find the first space to separate country code from the number
    final firstSpaceIndex = trimmed.indexOf(' ');
    String countryCode = '';
    String number = '';

    if (firstSpaceIndex != -1) {
      countryCode = trimmed.substring(0, firstSpaceIndex).trim();
      number = trimmed.substring(firstSpaceIndex + 1).trim();
    } else {
      number = trimmed;
    }

    // Remove all spaces/formatting from the number part to validate digits
    final digitsOnly = number.replaceAll(RegExp(r'\s+'), '');

    // Check if the number contains only digits.
    if (!RegExp(r'^\d+$').hasMatch(digitsOnly)) {
      return AppLocalizations.of(context)!.enterValidPhone;
    }

    int? requiredLength;
    if (countryCode == '+91') {
      requiredLength = 10;
    } else if (countryCode == '+1') {
      requiredLength = 10;
    } else if (countryCode == '+44') {
      requiredLength = 10;
    } else if (countryCode == '+65') {
      requiredLength = 8;
    } else if (countryCode == '+92') {
      requiredLength = 10;
    } else if (countryCode == '+61') {
      requiredLength = 9;
    } else if (countryCode == '+81') {
      requiredLength = 10;
    } else if (countryCode == '+86') {
      requiredLength = 11;
    }

    if (requiredLength != null) {
      if (digitsOnly.length != requiredLength) {
        return AppLocalizations.of(context)!.enterValidPhone;
      }
    } else {
      if (digitsOnly.length > 15) {
        return AppLocalizations.of(context)!.enterValidPhone;
      }
    }

    return null;
  }

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  static List<String>? _cachedCountryCodes;
  static Map<String, String>? _cachedCountryCodeLabels;

  bool _isLoadingCodes = false;
  String _selectedCountryCode = '+91';
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadCountryCodes();
  }

  Future<void> _loadCountryCodes() async {
    if (_cachedCountryCodes != null) return;

    setState(() => _isLoadingCodes = true);
    try {
      final response = await Dio().get(
        'https://restcountries.com/v2/all?fields=name,alpha2Code,callingCodes',
      );
      final data = response.data as List<dynamic>;

      final Set<String> codes = {};
      final Map<String, String> labels = {};

      for (var country in data) {
        final callingCodes = country['callingCodes'] as List<dynamic>?;
        if (callingCodes != null &&
            callingCodes.isNotEmpty &&
            callingCodes.first.toString().isNotEmpty) {
          final code = '+${callingCodes.first}';
          final alpha2 = country['alpha2Code'];
          codes.add(code);
          labels[code] = '$code ($alpha2)';
        }
      }

      final sortedCodes = codes.toList()
        ..sort((a, b) => b.length.compareTo(a.length));

      _cachedCountryCodes = sortedCodes;
      _cachedCountryCodeLabels = labels;
    } catch (e) {
      // Fallback
      _cachedCountryCodes = ['+1', '+91', '+44', '+61'];
      _cachedCountryCodeLabels = {
        '+1': '+1 (US)',
        '+91': '+91 (IN)',
        '+44': '+44 (GB)',
        '+61': '+61 (AU)',
      };
    }

    if (mounted) {
      setState(() {
        _isLoadingCodes = false;
        // Re-init to match any prefix once the data is loaded
        _numberController.removeListener(_updateMainController);
        _initControllers();
      });
    }
  }

  void _initControllers() {
    String text = widget.controller.text.trim();
    final codesToCheck = _cachedCountryCodes ?? ['+91'];

    if (text.isNotEmpty) {
      for (var code in codesToCheck) {
        if (text.startsWith(code)) {
          _selectedCountryCode = code;
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
      _initControllers();
    } else if (widget.controller.text != _getCombinedText()) {
      _numberController.removeListener(_updateMainController);
      _initControllers();
    }
  }

  void _updateMainController() {
    widget.controller.text = _getCombinedText();
  }

  String _getCombinedText() {
    if (_numberController.text.trim().isEmpty) return '';
    return '$_selectedCountryCode ${_numberController.text.trim()}';
  }

  @override
  void dispose() {
    _numberController.removeListener(_updateMainController);
    _numberController.dispose();
    super.dispose();
  }

  void _showCountryCodeSelector() {
    if (_cachedCountryCodes == null) return;
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _CountryCodeSelectorSheet(
          countryCodes: _cachedCountryCodes!,
          countryCodeLabels: _cachedCountryCodeLabels!,
        );
      },
    ).then((selectedCode) {
      if (selectedCode != null) {
        setState(() {
          _selectedCountryCode = selectedCode;
          _updateMainController();
        });
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

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: InkWell(
              onTap: _showCountryCodeSelector,
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
                      child: _isLoadingCodes
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: ShimmerLoading(
                                height: 16.h,
                                width: 50.w,
                                borderRadius: 4.r,
                              ),
                            )
                          : Text(
                              _cachedCountryCodeLabels?[_selectedCountryCode] ??
                                  _selectedCountryCode,
                              style: AppTextStyle.bodyLarge.copyWith(
                                color: AppColors.of(context).textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
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
  }
}

class _CountryCodeSelectorSheet extends StatefulWidget {
  final List<String> countryCodes;
  final Map<String, String> countryCodeLabels;

  const _CountryCodeSelectorSheet({
    required this.countryCodes,
    required this.countryCodeLabels,
  });

  @override
  State<_CountryCodeSelectorSheet> createState() =>
      _CountryCodeSelectorSheetState();
}

class _CountryCodeSelectorSheetState extends State<_CountryCodeSelectorSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredCodes = widget.countryCodes.where((code) {
      final label = widget.countryCodeLabels[code] ?? code;
      return label.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
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
                final code = filteredCodes[index];
                final label = widget.countryCodeLabels[code] ?? code;
                return ListTile(
                  title: Text(
                    label,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(code);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
