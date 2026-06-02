import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import 'update_profile_card.dart';
import 'contact_info_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileContactTab extends StatefulWidget {
  final ProfileEntity profile;

  const ProfileContactTab({
    super.key,
    required this.profile,
  });

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
  late TextEditingController _dobController;
  late TextEditingController _currentAddressController;
  late TextEditingController _permanentAddressController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _emailController = TextEditingController(text: widget.profile.companyEmail ?? widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
    _emergencyContactController = TextEditingController(text: widget.profile.emergencyContact ?? '');
    _dobController = TextEditingController(text: widget.profile.birthDate ?? '');
    _currentAddressController = TextEditingController(text: widget.profile.currentAddress ?? '');
    _permanentAddressController = TextEditingController(text: widget.profile.permanentAddress ?? '');
  }

  @override
  void didUpdateWidget(ProfileContactTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.profile != oldWidget.profile) {
      if (!_isEditingContact) {
        _emailController.text = widget.profile.companyEmail ?? widget.profile.email;
        _phoneController.text = widget.profile.phone ?? '';
        _emergencyContactController.text = widget.profile.emergencyContact ?? '';
        _dobController.text = widget.profile.birthDate ?? '';
      }
      if (!_isEditingAddress) {
        _currentAddressController.text = widget.profile.currentAddress ?? '';
        _permanentAddressController.text = widget.profile.permanentAddress ?? '';
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _dobController.dispose();
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
  }

  void _saveContactInfo() {
    if (_formKeyContact.currentState?.validate() ?? false) {
      context.read<ProfileBloc>().add(
        ProfileEvent.profileDetailsUpdateRequested(
          personalEmail: _emailController.text,
          phone: _phoneController.text,
          emergencyContact: _emergencyContactController.text,
          dateOfBirth: _dobController.text.isNotEmpty ? _dobController.text : null,
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
          currentAddress: _currentAddressController.text,
          permanentAddress: _permanentAddressController.text,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UpdateProfileCard(),
          const SizedBox(height: 24),

          // Contact Information Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.personalInformation, style: AppTextStyle.h3.copyWith(fontSize: 16)),
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
                                _emailController.text = widget.profile.companyEmail ?? widget.profile.email;
                                _phoneController.text = widget.profile.phone ?? '';
                                _emergencyContactController.text = widget.profile.emergencyContact ?? '';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.of(context).border),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _saveContactInfo,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.of(context).primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.save,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: Colors.white,
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
                        icon: Icon(Icons.edit_outlined, size: 16, color: AppColors.of(context).primary),
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
          const SizedBox(height: 12),

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
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value.trim())) {
                              return l10n.enterValidEmail;
                            }
                            return null;
                          },
                        ),
                        _EditableField(
                          label: l10n.phone,
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                              if (!phoneRegex.hasMatch(value.trim())) {
                                return l10n.enterValidPhone;
                              }
                            }
                            return null;
                          },
                        ),
                        _EditableField(
                          label: l10n.emergencyContact,
                          controller: _emergencyContactController,
                          icon: Icons.phone_outlined,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                              if (!phoneRegex.hasMatch(value.trim())) {
                                return l10n.enterValidPhone;
                              }
                            }
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
                                initialDate = DateTime.parse(_dobController.text);
                              } catch (e) {}
                            }
                            final date = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              _dobController.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    key: const ValueKey('contact_info_list'),
                    children: [
                      ContactInfoCard(
                        label: l10n.companyEmail,
                        value: widget.profile.companyEmail ?? widget.profile.email,
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 8),
                      ContactInfoCard(
                        label: l10n.phone,
                        value: widget.profile.phone ?? l10n.notAvailable,
                        icon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 8),
                      ContactInfoCard(
                        label: l10n.emergencyContact,
                        value: widget.profile.emergencyContact ?? l10n.notAvailable,
                        icon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 8),
                      ContactInfoCard(
                        label: l10n.dateOfBirth,
                        value: widget.profile.birthDate ?? l10n.notAvailable,
                        icon: Icons.calendar_today_outlined,
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 40),

          // Address Information Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.addressInformation, style: AppTextStyle.h3.copyWith(fontSize: 16)),
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
                                _currentAddressController.text = widget.profile.currentAddress ?? '';
                                _permanentAddressController.text = widget.profile.permanentAddress ?? '';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.of(context).border),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _saveAddressInfo,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.of(context).primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.save,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: Colors.white,
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
                        icon: Icon(Icons.edit_outlined, size: 16, color: AppColors.of(context).primary),
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
          const SizedBox(height: 12),

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
                      ],
                    ),
                  )
                : Column(
                    key: const ValueKey('address_info_list'),
                    children: [
                      ContactInfoCard(
                        label: l10n.currentAddress,
                        value: widget.profile.currentAddress ?? l10n.notAvailable,
                        icon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 8),
                      ContactInfoCard(
                        label: l10n.permanentAddress,
                        value: widget.profile.permanentAddress ?? l10n.notAvailable,
                        icon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
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
      margin: const EdgeInsets.only(bottom: 12),
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
          labelStyle: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon, color: AppColors.of(context).textSecondary, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          filled: true,
          fillColor: AppColors.of(context).profileInfoCardBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? AppColors.of(context).border : AppColors.of(context).bordergrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? AppColors.of(context).border : AppColors.of(context).bordergrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.of(context).primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.of(context).error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.of(context).error,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
