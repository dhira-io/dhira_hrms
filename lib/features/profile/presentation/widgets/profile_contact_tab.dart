import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import 'update_profile_card.dart';
import 'contact_info_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import 'phone_field.dart';
import 'location_autocomplete_field.dart';
import 'nationality_autocomplete_field.dart';

class ProfileContactTab extends StatefulWidget {
  final ProfileEntity profile;

  const ProfileContactTab({super.key, required this.profile});

  @override
  State<ProfileContactTab> createState() => _ProfileContactTabState();
}

class _ProfileContactTabState extends State<ProfileContactTab> {
  bool _isEditingContact = false;
  bool _isEditingAddress = false;

  final _formKeyContact = GlobalKey<FormState>();
  final _formKeyAddress = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _emergencyContactController;
  late TextEditingController _emergencyContactNameController;
  late TextEditingController _nationalityController;
  late TextEditingController _dobController;
  late TextEditingController _currentAddressController;
  late TextEditingController _permanentAddressController;
  late TextEditingController _currentLocationController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _emailController = TextEditingController(
      text: widget.profile.companyEmail ?? widget.profile.email,
    );
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
    _emergencyContactController = TextEditingController(
      text: widget.profile.emergencyContact ?? '',
    );
    _emergencyContactNameController = TextEditingController(
      text: widget.profile.emergencyContactName ?? '',
    );
    _nationalityController = TextEditingController(
      text: widget.profile.nationality ?? '',
    );
    _dobController = TextEditingController(
      text: widget.profile.birthDate ?? '',
    );
    _currentAddressController = TextEditingController(
      text: widget.profile.currentAddress ?? '',
    );
    _permanentAddressController = TextEditingController(
      text: widget.profile.permanentAddress ?? '',
    );
    _currentLocationController = TextEditingController(
      text: widget.profile.currentLocation ?? '',
    );
  }

  @override
  void didUpdateWidget(ProfileContactTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.profile != oldWidget.profile) {
      if (!_isEditingContact) {
        _emailController.text =
            widget.profile.companyEmail ?? widget.profile.email;
        _phoneController.text = widget.profile.phone ?? '';
        _emergencyContactController.text =
            widget.profile.emergencyContact ?? '';
        _emergencyContactNameController.text =
            widget.profile.emergencyContactName ?? '';
        _nationalityController.text = widget.profile.nationality ?? '';
        _dobController.text = widget.profile.birthDate ?? '';
      }
      if (!_isEditingAddress) {
        _currentAddressController.text = widget.profile.currentAddress ?? '';
        _permanentAddressController.text =
            widget.profile.permanentAddress ?? '';
        _currentLocationController.text = widget.profile.currentLocation ?? '';
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _emergencyContactNameController.dispose();
    _nationalityController.dispose();
    _dobController.dispose();
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    _currentLocationController.dispose();
    super.dispose();
  }

  void _saveContactInfo() {
    if (_formKeyContact.currentState?.validate() ?? false) {
      context.read<ProfileBloc>().add(
        ProfileEvent.profileDetailsUpdateRequested(
          personalEmail: _emailController.text,
          phone: _phoneController.text,
          emergencyContact: _emergencyContactController.text,
          emergencyContactName: _emergencyContactNameController.text,
          nationality: _nationalityController.text,
          dateOfBirth: _dobController.text.isNotEmpty
              ? _dobController.text
              : null,
          currentAddress: _currentAddressController.text.isNotEmpty
              ? _currentAddressController.text
              : (widget.profile.currentAddress ?? ''),
          permanentAddress: _permanentAddressController.text.isNotEmpty
              ? _permanentAddressController.text
              : (widget.profile.permanentAddress ?? ''),
        ),
      );
      setState(() {
        _isEditingContact = false;
      });
    }
  }

  void _saveAddressInfo() {
    if (_formKeyAddress.currentState?.validate() ?? false) {
      context.read<ProfileBloc>().add(
        ProfileEvent.profileDetailsUpdateRequested(
          personalEmail: _emailController.text.isNotEmpty
              ? _emailController.text
              : (widget.profile.companyEmail ?? widget.profile.email),
          phone: _phoneController.text.isNotEmpty
              ? _phoneController.text
              : (widget.profile.phone ?? ''),
          emergencyContact: _emergencyContactController.text.isNotEmpty
              ? _emergencyContactController.text
              : (widget.profile.emergencyContact ?? ''),
          emergencyContactName: _emergencyContactNameController.text.isNotEmpty
              ? _emergencyContactNameController.text
              : (widget.profile.emergencyContactName ?? ''),
          nationality: _nationalityController.text.isNotEmpty
              ? _nationalityController.text
              : (widget.profile.nationality ?? ''),
          currentAddress: _currentAddressController.text,
          permanentAddress: _permanentAddressController.text,
          currentLocation: _currentLocationController.text.isNotEmpty
              ? _currentLocationController.text
              : (widget.profile.currentLocation ?? ''),
          dateOfBirth: _dobController.text.isNotEmpty
              ? _dobController.text
              : (widget.profile.birthDate ?? ''),
        ),
      );
      setState(() {
        _isEditingAddress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding:       EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UpdateProfileCard(),
                SizedBox(height: 24.h),

          // Contact Information Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.personalInformation,
                style: AppTextStyle.h3.copyWith(fontSize: 16.sp),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isEditingContact
                    ? Row(
                        key: const ValueKey('editing_contact'),
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _isEditingContact = false;
                                _emailController.text =
                                    widget.profile.companyEmail ??
                                    widget.profile.email;
                                _phoneController.text =
                                    widget.profile.phone ?? '';
                                _emergencyContactController.text =
                                    widget.profile.emergencyContact ?? '';
                                _emergencyContactNameController.text =
                                    widget.profile.emergencyContactName ?? '';
                                _nationalityController.text =
                                    widget.profile.nationality ?? '';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.of(context).border,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding:       EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                                SizedBox(width: 8.w),
                          ElevatedButton(
                            onPressed: _saveContactInfo,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.of(context).primary,
                              foregroundColor: AppColors.of(context).white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding:       EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.save,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextButton.icon(
                        key: const ValueKey('viewing_contact'),
                        onPressed: () {
                          setState(() {
                            _isEditingContact = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: AppColors.of(context).primary,
                        ),
                        label: Text(
                          l10n.edit,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(context).primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            ],
          ),
                SizedBox(height: 12.h),

          // Contact Information Cards
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _isEditingContact
                ? Form(
                    key: _formKeyContact,
                    child: Column(
                      key: const ValueKey('contact_form'),
                      children: [
                        _EditableField(
                          label: l10n.companyEmail,
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return l10n.emailRequired;
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return l10n.enterValidEmail;
                            }
                            return null;
                          },
                        ),
                        PhoneField(
                          label: l10n.phone,
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              final phoneRegex = RegExp(r'^\+?[0-9\s]{10,20}$');
                              if (!phoneRegex.hasMatch(value.trim())) {
                                return l10n.enterValidPhone;
                              }
                            }
                            return null;
                          },
                        ),
                        PhoneField(
                          label: l10n.emergencyContact,
                          controller: _emergencyContactController,
                          icon: Icons.phone_outlined,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              final phoneRegex = RegExp(r'^\+?[0-9\s]{10,20}$');
                              if (!phoneRegex.hasMatch(value.trim())) {
                                return l10n.enterValidPhone;
                              }
                            }
                            return null;
                          },
                        ),
                        _EditableField(
                          label: "Emergency Contact Name",
                          controller: _emergencyContactNameController,
                          icon: Icons.person_outline,
                          validator: (value) {
                            return null;
                          },
                        ),
                        _EditableField(
                          label: l10n.dateOfBirth,
                          controller: _dobController,
                          icon: Icons.calendar_today_outlined,
                          readOnly: true,
                          onTap: () async {
                            DateTime initialDate = DateTime.now();
                            if (_dobController.text.isNotEmpty) {
                              try {
                                initialDate = DateTime.parse(
                                  _dobController.text,
                                );
                              } catch (e) {}
                            }
                            final date = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              _dobController.text =
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                            }
                          },
                        ),
                        NationalityAutocompleteField(
                          label: "Nationality",
                          controller: _nationalityController,
                          icon: Icons.flag_outlined,
                        ),
                      ],
                    ),
                  )
                : Column(
                    key: const ValueKey('contact_info_list'),
                    children: [
                      ContactInfoCard(
                        label: l10n.companyEmail,
                        value:
                            widget.profile.companyEmail ?? widget.profile.email,
                        icon: Icons.email_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: l10n.phone,
                        value: widget.profile.phone ?? l10n.notAvailable,
                        icon: Icons.phone_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: l10n.emergencyContact,
                        value:
                            widget.profile.emergencyContact ??
                            l10n.notAvailable,
                        icon: Icons.phone_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: "Emergency Contact Name",
                        value:
                            widget.profile.emergencyContactName ??
                            l10n.notAvailable,
                        icon: Icons.person_outline,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: l10n.dateOfBirth,
                        value: widget.profile.birthDate ?? l10n.notAvailable,
                        icon: Icons.calendar_today_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: "Nationality",
                        value: widget.profile.nationality?.isNotEmpty == true
                            ? widget.profile.nationality!
                            : l10n.notAvailable,
                        icon: Icons.flag_outlined,
                      ),
                    ],
                  ),
          ),
                SizedBox(height: 40.h),

          // Address Information Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.addressInformation,
                style: AppTextStyle.h3.copyWith(fontSize: 16.sp),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isEditingAddress
                    ? Row(
                        key: const ValueKey('editing_address'),
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _isEditingAddress = false;
                                _currentAddressController.text =
                                    widget.profile.currentAddress ?? '';
                                _permanentAddressController.text =
                                    widget.profile.permanentAddress ?? '';
                                _currentLocationController.text =
                                    widget.profile.currentLocation ?? '';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.of(context).border,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding:       EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                                SizedBox(width: 8.w),
                          ElevatedButton(
                            onPressed: _saveAddressInfo,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.of(context).primary,
                              foregroundColor: AppColors.of(context).white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding:       EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.save,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextButton.icon(
                        key: const ValueKey('viewing_address'),
                        onPressed: () {
                          setState(() {
                            _isEditingAddress = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: AppColors.of(context).primary,
                        ),
                        label: Text(
                          l10n.edit,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(context).primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            ],
          ),
                SizedBox(height: 12.h),

          // Address Information Cards
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _isEditingAddress
                ? Form(
                    key: _formKeyAddress,
                    child: Column(
                      key: const ValueKey('address_form'),
                      children: [
                        _EditableField(
                          label: l10n.currentAddress,
                          controller: _currentAddressController,
                          icon: Icons.location_on_outlined,
                          isMultiline: true,
                          validator: (value) {
                            return null;
                          },
                        ),
                        _EditableField(
                          label: l10n.permanentAddress,
                          controller: _permanentAddressController,
                          icon: Icons.location_on_outlined,
                          isMultiline: true,
                          validator: (value) {
                            return null;
                          },
                        ),
                        LocationAutocompleteField(
                          label: "Current Location",
                          controller: _currentLocationController,
                          icon: Icons.my_location_outlined,
                          validator: (value) {
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    key: const ValueKey('address_info_list'),
                    children: [
                      ContactInfoCard(
                        label: l10n.currentAddress,
                        value:
                            widget.profile.currentAddress ?? l10n.notAvailable,
                        icon: Icons.location_on_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: l10n.permanentAddress,
                        value:
                            widget.profile.permanentAddress ??
                            l10n.notAvailable,
                        icon: Icons.location_on_outlined,
                      ),
                            SizedBox(height: 8.h),
                      ContactInfoCard(
                        label: "Current Location",
                        value:
                            widget.profile.currentLocation ??
                            l10n.notAvailable,
                        icon: Icons.my_location_outlined,
                      ),
                    ],
                  ),
          ),
                SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isMultiline;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  const _EditableField({
    required this.label,
    required this.controller,
    required this.icon,
    this.isMultiline = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin:       EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        readOnly: readOnly,
        onTap: onTap,
        style: AppTextStyle.bodyLarge.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.of(context).textPrimary,
        ),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).textSecondary,
          ),
          prefixIcon: Padding(
            padding:       EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(
              icon,
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
            borderSide: BorderSide(
              color: isDark
                  ? AppColors.of(context).border
                  : AppColors.of(context).bordergrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: isDark
                  ? AppColors.of(context).border
                  : AppColors.of(context).bordergrey,
            ),
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
          contentPadding:       EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
