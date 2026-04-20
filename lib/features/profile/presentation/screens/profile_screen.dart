import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
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
    Get.find<ProfileBloc>().add(const ProfileEvent.started());
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 50);
    if (image != null) {
      if (mounted) {
        Get.find<ProfileBloc>().add(ProfileEvent.avatarUpdateRequested(
          filePath: image.path,
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
                context.pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.camera, style: AppTextStyle.bodyMedium),
              onTap: () {
                context.pop();
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
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<ProfileBloc>.value(
      value: Get.find<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.myProfile)),
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
                orElse: () => SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.p20),
                  child: ProfileInfoSection(onPickImage: _showImageSourceSheet),
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
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.r12),
            topRight: Radius.circular(AppConstants.r12),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

