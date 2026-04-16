import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_overview_tab.dart';
import '../widgets/profile_contact_tab.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString(StorageConstants.userEmail);
    if (_email != null) {
      if (mounted) {
        Get.find<ProfileBloc>().add(ProfileEvent.started(_email!));
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 50);
    if (image != null && _email != null) {
      if (mounted) {
        Get.find<ProfileBloc>().add(ProfileEvent.avatarUpdateRequested(
          filePath: image.path,
          email: _email!,
        ));
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
              title: Text(l10n.gallery, style: AppTextStyle.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.camera, style: AppTextStyle.bodyMedium),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>.value(
      value: Get.find<ProfileBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBFDFF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'User Profile',
            style: AppTextStyle.h3.copyWith(color: AppColors.textPrimary),
          ),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) => ToastUtils.showSuccess(message),
              error: (message) => ToastUtils.showError(message),
            );
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) => Center(child: Text(message, style: AppTextStyle.error)),
                loaded: (profile) => SafeArea(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        ProfileHeader(
                          profile: profile,
                          onPickImage: _showImageSourceSheet,
                        ),
                        Container(
                          color: const Color(0xFFF1F5F9), // Light grey for tab bar background
                          child: TabBar(
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            padding: const EdgeInsets.only(top: 8),
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              _buildTab('Overview'),
                              _buildTab('Address & Contact'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ProfileOverviewTab(profile: profile),
                              ProfileContactTab(profile: profile),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

