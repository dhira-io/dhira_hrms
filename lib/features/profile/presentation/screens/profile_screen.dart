import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_overview_tab.dart';
import '../widgets/profile_contact_tab.dart';
import '../widgets/profile_skeleton.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.started());
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        title: l10n.userProfile,
        // backgroundColor: AppColors.profileHeaderBg,
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
              loading: () => const ProfileSkeleton(),
              error: (message) =>
                  Center(child: Text(message, style: AppTextStyle.error)),
              uploading: (profile) => _buildProfile(context, profile, l10n, isUploading: true),
              loaded: (profile) => _buildProfile(context, profile, l10n),
              orElse: () => const ProfileSkeleton(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfile(
    BuildContext context,
    dynamic profile,
    AppLocalizations l10n, {
    bool isUploading = false,
  }) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileHeader(
              profile: profile,
              onPickImage: _showImageSourceSheet,
              isUploading: isUploading,
            ),
            Container(
              color: AppColors.profileTabBg,
              child: TabBar(
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                dividerColor: Colors.transparent,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                padding: const EdgeInsets.only(top: 8),
                labelPadding: EdgeInsets.zero,
                tabs: [
                  _buildTab(l10n.overview),
                  _buildTab(l10n.addressAndContact),
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
          style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
