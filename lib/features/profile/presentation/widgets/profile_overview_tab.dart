import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class ProfileOverviewTab extends StatefulWidget {
  final ProfileEntity profile;
  final bool isUploading;

  const ProfileOverviewTab({
    super.key,
    required this.profile,
    this.isUploading = false,
  });

  @override
  State<ProfileOverviewTab> createState() => _ProfileOverviewTabState();
}

class _ProfileOverviewTabState extends State<ProfileOverviewTab> {
  final ImagePicker _picker = ImagePicker();
  
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
  void didUpdateWidget(ProfileOverviewTab oldWidget) {
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

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (mounted) {
        context.read<ProfileBloc>().add(
          ProfileEvent.avatarUpdateRequested(filePath: image.path),
        );
      }
    }
  }

  void _showImageSourceSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.gallery, style: AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.camera, style: AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseUrl = Get.find<DioClient>().baseUrl;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          // 2. Basic Information Card
          _ProfileCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_outline, color: AppColors.of(context).primary, size: 20.w),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.basicInformation,
                      style: AppTextStyle.h3.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.of(context).white : AppColors.of(context).slate800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.of(context).slate800 : const Color(0xFFF1F5F9), // slate 100
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isDark ? AppColors.of(context).slate700 : const Color(0xFFCBD5E1), // slate 300
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16.w,
                        color: isDark ? AppColors.of(context).slate300 : const Color(0xFF334155), // slate 700
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          l10n.hrManagedFieldsInfo,
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 13.sp,
                            color: isDark ? AppColors.of(context).slate300 : const Color(0xFF334155), // slate 700
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _InfoGrid(profile: widget.profile),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // 3. Contact Information Card
          _ProfileCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined, color: AppColors.of(context).primary, size: 20.w),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              l10n.personalInformation,
                              style: AppTextStyle.h3.copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _EditButton(
                      isEditing: _isEditingContact,
                      onEditPressed: () => setState(() => _isEditingContact = true),
                      onCancelPressed: () {
                        setState(() {
                          _isEditingContact = false;
                          _emailController.text = widget.profile.companyEmail ?? widget.profile.email;
                          _phoneController.text = widget.profile.phone ?? '';
                          _emergencyContactController.text = widget.profile.emergencyContact ?? '';
                          _dobController.text = widget.profile.birthDate ?? '';
                        });
                      },
                      onSavePressed: _saveContactInfo,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isEditingContact
                      ? Form(
                          key: _formKeyContact,
                          child: Column(
                            key: const ValueKey('editing_contact_form'),
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
                                icon: Icons.contact_emergency_outlined,
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
                          key: const ValueKey('viewing_contact_list'),
                          children: [
                            _InfoRow(icon: Icons.email_outlined, label: l10n.companyEmail, value: widget.profile.companyEmail ?? widget.profile.email),
                            SizedBox(height: 12.h),
                            _InfoRow(icon: Icons.phone_outlined, label: l10n.phone, value: widget.profile.phone ?? l10n.notAvailable),
                            SizedBox(height: 12.h),
                            _InfoRow(icon: Icons.contact_emergency_outlined, label: l10n.emergencyContact, value: widget.profile.emergencyContact ?? l10n.notAvailable),
                            SizedBox(height: 12.h),
                            _InfoRow(icon: Icons.calendar_today_outlined, label: l10n.dateOfBirth, value: widget.profile.birthDate ?? l10n.notAvailable),
                          ],
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // 4. Address Information Card
          _ProfileCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: AppColors.of(context).primary, size: 20.w),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              l10n.addressInformation,
                              style: AppTextStyle.h3.copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _EditButton(
                      isEditing: _isEditingAddress,
                      onEditPressed: () => setState(() => _isEditingAddress = true),
                      onCancelPressed: () {
                        setState(() {
                          _isEditingAddress = false;
                          _currentAddressController.text = widget.profile.currentAddress ?? '';
                          _permanentAddressController.text = widget.profile.permanentAddress ?? '';
                        });
                      },
                      onSavePressed: _saveAddressInfo,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isEditingAddress
                      ? Form(
                          key: _formKeyAddress,
                          child: Column(
                            key: const ValueKey('editing_address_form'),
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
                          key: const ValueKey('viewing_address_list'),
                          children: [
                            _InfoRow(icon: Icons.location_city_outlined, label: l10n.currentAddress, value: widget.profile.currentAddress ?? l10n.notAvailable),
                            SizedBox(height: 12.h),
                            _InfoRow(icon: Icons.home_outlined, label: l10n.permanentAddress, value: widget.profile.permanentAddress ?? l10n.notAvailable),
                          ],
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final Widget child;

  const _ProfileCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.of(context).border : AppColors.of(context).bordergrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: child,
    );
  }
}



class _InfoGrid extends StatelessWidget {
  final ProfileEntity profile;

  const _InfoGrid({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final empId = profile.customPayrollId ?? profile.employee ?? profile.empId ?? "0871";
    final employeeName = profile.fullName.isNotEmpty 
        ? profile.fullName 
        : "${profile.firstName} ${profile.lastName}".trim();
    final department = profile.orgDepartment ?? profile.department ?? l10n.notAvailable;
    final designation = profile.designation ?? l10n.notAvailable;
    final dateOfJoining = profile.dateOfJoining ?? l10n.notAvailable;
    final reportingManager = profile.reportsToName ?? profile.reportsTo ?? l10n.notAvailable;
    
    final statusValue = profile.employmentType ?? l10n.active;
    final employmentTypeValue = l10n.permanent;

    final fields = [
      //_GridItem(l10n.employeeId, empId),
      _GridItem(l10n.employeeName, employeeName),
      _GridItem(l10n.department, department),
      _GridItem(l10n.designation, designation),
      _GridItem(l10n.dateOfJoining, dateOfJoining),
      _GridItem(l10n.reportingManager, reportingManager),
      _GridItem(l10n.employmentType, employmentTypeValue),
      _GridItem(l10n.status, statusValue),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isWide = width > 500;
        return Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: fields.map((field) {
            return SizedBox(
              width: isWide ? (width - 16.w) / 2 : width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.label,
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.of(context).slate500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    field.value,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.of(context).textPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                  Divider(height: 12.h, thickness: 0.5),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: AppColors.of(context).primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 16.w, color: AppColors.of(context).primary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 11.sp,
                  color: AppColors.of(context).slate500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.of(context).textPrimary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const _EditButton({
    required this.isEditing,
    required this.onEditPressed,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isEditing) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onCancelPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              minimumSize: Size.zero,
            ),
            child: Text(
              l10n.cancel,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).slate600,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: onSavePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.of(context).primary,
              foregroundColor: AppColors.of(context).white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
            ),
            child: Text(
              l10n.save,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.of(context).white,
              ),
            ),
          ),
        ],
      );
    }

    return IconButton(
      icon: Icon(Icons.edit_outlined, size: 18.w, color: AppColors.of(context).primary),
      onPressed: onEditPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
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
      margin: EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        readOnly: readOnly,
        onTap: onTap,
        style: AppTextStyle.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.of(context).textPrimary,
          fontSize: 14.sp,
        ),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).slate500,
            fontSize: 12.sp,
          ),
          prefixIcon: Icon(icon, color: AppColors.of(context).slate400, size: 18.w),
          filled: true,
          fillColor: isDark ? AppColors.of(context).surfaceContainerLow : AppColors.of(context).slate50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.of(context).slate300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.of(context).slate200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.of(context).primary, width: 1.5.w),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}

class _GridItem {
  final String label;
  final String value;
  _GridItem(this.label, this.value);
}
