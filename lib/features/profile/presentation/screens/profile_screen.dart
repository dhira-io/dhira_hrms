import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_overview_tab.dart';
import '../widgets/profile_professional_details_tab.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileBloc>().add(const ProfileEvent.started());
      }
    });
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
              leading: Icon(Icons.photo_library),
              title: Text(l10n.gallery, style: AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.userProfile,
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
              color: AppColors.of(context).profileTabBg,
              child: TabBar(
                indicatorColor: AppColors.of(context).primary,
                indicatorWeight: 3.h,
                dividerColor: Colors.transparent,
                labelColor: AppColors.of(context).primary,
                unselectedLabelColor: AppColors.of(context).textSecondary,
                padding: EdgeInsets.only(top: 8.h),
                labelPadding: EdgeInsets.zero,
                tabs: [
                  _TabItem(label: l10n.overview),
                  const _TabItem(label: "Professional Details"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileOverviewTab(profile: profile),
                  const ProfileProfessionalDetailsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;

  const _TabItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
