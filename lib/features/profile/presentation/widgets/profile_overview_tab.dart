import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'phone_field.dart';
import 'location_autocomplete_field.dart';
import 'nationality_autocomplete_field.dart';

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
  bool _isSavingContact = false;
  bool _isSavingAddress = false;

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
  void didUpdateWidget(ProfileOverviewTab oldWidget) {
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
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                AppLocalizations.of(context)!.gallery,
                style: AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(
                AppLocalizations.of(context)!.camera,
                style: AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp),
              ),
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
      FocusScope.of(context).unfocus();
      setState(() {
        _isSavingContact = true;
      });
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
    }
  }

  void _saveAddressInfo() {
    if (_formKeyAddress.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      setState(() {
        _isSavingAddress = true;
      });
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
    }
  }

  void _cancelContactEdit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isEditingContact = false;
      _emailController.text =
          widget.profile.companyEmail ?? widget.profile.email;
      _phoneController.text = widget.profile.phone ?? '';
      _emergencyContactController.text =
          widget.profile.emergencyContact ?? '';
      _emergencyContactNameController.text =
          widget.profile.emergencyContactName ?? '';
      _nationalityController.text = widget.profile.nationality ?? '';
      _dobController.text = widget.profile.birthDate ?? '';
    });
  }

  void _cancelAddressEdit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isEditingAddress = false;
      _currentAddressController.text = widget.profile.currentAddress ?? '';
      _permanentAddressController.text = widget.profile.permanentAddress ?? '';
      _currentLocationController.text = widget.profile.currentLocation ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseUrl = Get.find<DioClient>().baseUrl;
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (profile, resume) {
            if (_isSavingContact) {
              ToastUtils.showSuccess(l10n.contactInformationUpdated);
              setState(() {
                _isEditingContact = false;
                _isSavingContact = false;
              });
            }
            if (_isSavingAddress) {
              ToastUtils.showSuccess(l10n.addressInformationUpdated);
              setState(() {
                _isEditingAddress = false;
                _isSavingAddress = false;
              });
            }
          },
          error: (message, _, __) {
            if (_isSavingContact || _isSavingAddress) {
              setState(() {
                _isSavingContact = false;
                _isSavingAddress = false;
              });
            }
          },
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
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
                    Icon(
                      Icons.person_outline,
                      color: AppColors.of(context).primary,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.basicInformation,
                      style: AppTextStyle.h3.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.of(context).white
                            : AppColors.of(context).slate800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.of(context).slate800
                        : AppColors.slate100, // slate 100
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.slate700
                          : AppColors.slate300, // slate 300
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16.w,
                        color: isDark
                            ? AppColors.slate300
                            : AppColors.slate700, // slate 700
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.hrManagedFieldsInfo,
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 13.sp,
                            color: isDark
                                ? AppColors.slate300
                                : AppColors.slate700, // slate 700
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
                          Icon(
                            Icons.email_outlined,
                            color: AppColors.of(context).primary,
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.personalInformation,
                              style: AppTextStyle.h3.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _EditButton(
                      isEditing: _isEditingContact,
                      onEditPressed: () =>
                          setState(() => _isEditingContact = true),
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
                                label: AppLocalizations.of(
                                  context,
                                )!.companyEmail,
                                controller: _emailController,
                                icon: Icons.email_outlined,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.emailRequired;
                                  }
                                  final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  );
                                  if (!emailRegex.hasMatch(value.trim())) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.enterValidEmail;
                                  }
                                  return null;
                                },
                              ),
                              PhoneField(
                                label: AppLocalizations.of(context)!.phone,
                                controller: _phoneController,
                                icon: Icons.phone_outlined,
                                validator: (value) =>
                                    context.read<ProfileBloc>().validatePhoneNumber(value, AppLocalizations.of(context)!),
                              ),
                              PhoneField(
                                label: AppLocalizations.of(
                                  context,
                                )!.emergencyContact,
                                controller: _emergencyContactController,
                                icon: Icons.contact_emergency_outlined,
                                validator: (value) =>
                                    context.read<ProfileBloc>().validatePhoneNumber(value, AppLocalizations.of(context)!),
                              ),
                              _EditableField(
                                label: AppLocalizations.of(
                                  context,
                                )!.emergencyContactName,
                                controller: _emergencyContactNameController,
                                icon: Icons.person_outline,
                                validator: (value) {
                                  return null;
                                },
                              ),
                              _EditableField(
                                label: AppLocalizations.of(
                                  context,
                                )!.dateOfBirth,
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
                                    } catch (e) {
                                      // ignore
                                    }
                                  }
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (date != null) {
                                    _dobController.text =
                                        DateTimeUtils.formatDate(
                                          date,
                                          pattern: "yyyy-MM-dd",
                                        );
                                  }
                                },
                              ),
                              NationalityAutocompleteField(
                                label: AppLocalizations.of(
                                  context,
                                )!.nationality,
                                controller: _nationalityController,
                                icon: Icons.flag_outlined,
                              ),
                              _FormActions(
                                isLoading: _isSavingContact,
                                onCancelPressed: _cancelContactEdit,
                                onSavePressed: _saveContactInfo,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          key: const ValueKey('viewing_contact_list'),
                          children: [
                            _InfoRow(
                              icon: Icons.email_outlined,
                              label: AppLocalizations.of(context)!.companyEmail,
                              value:
                                  widget.profile.companyEmail ??
                                  widget.profile.email,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.phone_outlined,
                              label: AppLocalizations.of(context)!.phone,
                              value:
                                  widget.profile.phone ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.contact_emergency_outlined,
                              label: AppLocalizations.of(
                                context,
                              )!.emergencyContact,
                              value:
                                  widget.profile.emergencyContact ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.person_outline,
                              label: AppLocalizations.of(
                                context,
                              )!.emergencyContactName,
                              value:
                                  widget.profile.emergencyContactName ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.calendar_today_outlined,
                              label: AppLocalizations.of(context)!.dateOfBirth,
                              value:
                                  widget.profile.birthDate ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.flag_outlined,
                              label: AppLocalizations.of(context)!.nationality,
                              value:
                                  widget.profile.nationality?.isNotEmpty == true
                                  ? widget.profile.nationality!
                                  : AppLocalizations.of(context)!.notAvailable,
                            ),
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
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.of(context).primary,
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.addressInformation,
                              style: AppTextStyle.h3.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _EditButton(
                      isEditing: _isEditingAddress,
                      onEditPressed: () =>
                          setState(() => _isEditingAddress = true),
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
                                label: AppLocalizations.of(
                                  context,
                                )!.currentAddress,
                                controller: _currentAddressController,
                                icon: Icons.location_on_outlined,
                                isMultiline: true,
                                validator: (value) {
                                  return null;
                                },
                              ),
                              _EditableField(
                                label: AppLocalizations.of(
                                  context,
                                )!.permanentAddress,
                                controller: _permanentAddressController,
                                icon: Icons.location_on_outlined,
                                isMultiline: true,
                                validator: (value) {
                                  return null;
                                },
                              ),
                              LocationAutocompleteField(
                                label: AppLocalizations.of(
                                  context,
                                )!.currentLocation,
                                controller: _currentLocationController,
                                icon: Icons.my_location_outlined,
                                validator: (value) {
                                  return null;
                                },
                              ),
                              _FormActions(
                                isLoading: _isSavingAddress,
                                onCancelPressed: _cancelAddressEdit,
                                onSavePressed: _saveAddressInfo,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          key: const ValueKey('viewing_address_list'),
                          children: [
                            _InfoRow(
                              icon: Icons.location_city_outlined,
                              label: AppLocalizations.of(
                                context,
                              )!.currentAddress,
                              value:
                                  widget.profile.currentAddress ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.home_outlined,
                              label: AppLocalizations.of(
                                context,
                              )!.permanentAddress,
                              value:
                                  widget.profile.permanentAddress ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                            SizedBox(height: 12.h),
                            _InfoRow(
                              icon: Icons.my_location_outlined,
                              label: AppLocalizations.of(
                                context,
                              )!.currentLocation,
                              value:
                                  widget.profile.currentLocation ??
                                  AppLocalizations.of(context)!.notAvailable,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    ),
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
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).border
              : AppColors.of(context).bordergrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(
              context,
            ).black.withValues(alpha: isDark ? 0.2 : 0.02),
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
    final empId =
        (profile.customPayrollId != null && profile.customPayrollId!.isNotEmpty)
        ? "EMP-${profile.customPayrollId}"
        : (profile.employee ?? profile.empId ?? "");
    final employeeName = profile.fullName.isNotEmpty
        ? profile.fullName
        : "${profile.firstName} ${profile.lastName}".trim();
    final department =
        profile.orgDepartment ??
        profile.department ??
        AppLocalizations.of(context)!.notAvailable;
    final designation =
        profile.designation ?? AppLocalizations.of(context)!.notAvailable;

    String formattedDateOfJoining = AppLocalizations.of(context)!.notAvailable;
    if (profile.dateOfJoining != null && profile.dateOfJoining!.isNotEmpty) {
      try {
        final dt = DateTime.parse(profile.dateOfJoining!);
        formattedDateOfJoining = DateTimeUtils.formatDate(
          dt,
          pattern: DateTimeUtils.patternDDMMYYYY,
        );
      } catch (e) {
        formattedDateOfJoining = profile.dateOfJoining!;
      }
    }
    final dateOfJoining = formattedDateOfJoining;

    final reportingManager =
        profile.reportsToName ??
        profile.reportsTo ??
        AppLocalizations.of(context)!.notAvailable;

    final employmentTypeValue =
        profile.employmentType ?? AppLocalizations.of(context)!.notAvailable;

    final fields = [
      //_GridItem(AppLocalizations.of(context)!.employeeId, empId),
      _GridItem(AppLocalizations.of(context)!.employeeName, employeeName),
      _GridItem(AppLocalizations.of(context)!.department, department),
      _GridItem(AppLocalizations.of(context)!.designation, designation),
      _GridItem(AppLocalizations.of(context)!.dateOfJoining, dateOfJoining),
      _GridItem(
        AppLocalizations.of(context)!.reportingManager,
        reportingManager,
      ),
      _GridItem(
        AppLocalizations.of(context)!.employmentType,
        employmentTypeValue,
      ),
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
                    field.value.trim().isEmpty || field.value == "null"
                        ? AppLocalizations.of(context)!.notAvailable
                        : field.value,
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
                value.trim().isEmpty || value == "null"
                    ? AppLocalizations.of(context)!.notAvailable
                    : value,
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

  const _EditButton({
    required this.isEditing,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        size: 18.w,
        color: AppColors.of(context).primary,
      ),
      onPressed: onEditPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}

class _FormActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const _FormActions({
    required this.isLoading,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonButton(
            text: AppLocalizations.of(context)!.cancel,
            onPressed: isLoading ? null : onCancelPressed,
            variant: ButtonVariant.outlined,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            width: 80.w,
            borderRadius: 6.r,
          ),
          SizedBox(width: 8.w),
          CommonButton(
            text: AppLocalizations.of(context)!.save,
            onPressed: onSavePressed,
            isLoading: isLoading,
            variant: ButtonVariant.primary,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            width: 80.w,
            borderRadius: 6.r,
          ),
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
          prefixIcon: Icon(
            icon,
            color: AppColors.of(context).slate400,
            size: 18.w,
          ),
          filled: true,
          fillColor: isDark
              ? AppColors.of(context).surfaceContainerLow
              : AppColors.of(context).slate50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.slate300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.of(context).slate200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
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

class _GridItem {
  final String label;
  final String value;
  _GridItem(this.label, this.value);
}
