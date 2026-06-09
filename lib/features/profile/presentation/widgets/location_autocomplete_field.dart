import 'dart:async';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/constants/profile_api_constants.dart';

class LocationAutocompleteField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;

  const LocationAutocompleteField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.validator,
  });

  @override
  State<LocationAutocompleteField> createState() =>
      _LocationAutocompleteFieldState();
}

class _LocationAutocompleteFieldState extends State<LocationAutocompleteField> {
  void _showSelector() {
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const _LocationSelectorSheet();
      },
    ).then((selectedLocation) {
      if (selectedLocation != null) {
        setState(() {
          widget.controller.text = selectedLocation;
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
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: _showSelector,
        validator: widget.validator,
        style: AppTextStyle.bodyLarge.copyWith(
          color: AppColors.of(context).textPrimary,
        ),
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
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.of(context).textSecondary,
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
      ),
    );
  }
}

class _LocationSelectorSheet extends StatefulWidget {
  const _LocationSelectorSheet();

  @override
  State<_LocationSelectorSheet> createState() => _LocationSelectorSheetState();
}

class _LocationSelectorSheetState extends State<_LocationSelectorSheet> {
  final Dio _dio = Dio();
  bool _isLoading = false;



  List<String> _results = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _results = List.from(ProfileApiConstants.defaultLocations);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchLocations(query);
    });
  }

  Future<void> _fetchLocations(String query) async {
    if (query.trim().isEmpty || query.length < 2) {
      if (mounted) {
        setState(() {
          _results = List.from(ProfileApiConstants.defaultLocations);
        });
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await _dio.get(
        'https://geocoding-api.open-meteo.com/v1/search',
        queryParameters: {
          'name': query,
          'count': 10,
          'language': 'en',
          'format': 'json',
        },
      );

      if (response.data != null && response.data['results'] != null) {
        final List<dynamic> results = response.data['results'];
        final parsedResults = results.map((e) {
          final name = e['name'] ?? '';
          final admin1 = e['admin1'] ?? '';
          final country = e['country'] ?? '';

          final parts = [name, admin1, country]
              .where((part) => part.toString().isNotEmpty)
              .toSet() // avoid duplicates
              .toList();

          return parts.join(', ');
        }).toList();

        if (mounted) {
          setState(() {
            _results = parsedResults;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _results = [];
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching locations: $e');
      if (mounted) {
        setState(() {
          _results = [];
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchLocation,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.of(context).textSecondary,
                ),
                suffixIcon: _isLoading
                    ? Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.of(context).primary,
                          ),
                        ),
                      )
                    : null,
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
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final location = _results[index];
                return ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.of(context).textSecondary,
                  ),
                  title: Text(
                    location,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(location);
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
