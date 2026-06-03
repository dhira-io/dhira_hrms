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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileBloc = context.read<ProfileBloc>();
    
    bool hasImage = false;
    profileBloc.state.maybeMap(
      loaded: (state) => hasImage = state.profile.userImage != null && state.profile.userImage!.isNotEmpty,
      uploading: (state) => hasImage = state.profile.userImage != null && state.profile.userImage!.isNotEmpty,
      orElse: () => hasImage = false,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.of(context).surface
          : AppColors.of(context).white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 4.h,
                ),
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.of(context).primary.withValues(alpha: 0.2)
                        : AppColors.of(context).primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.file_upload_outlined,
                    color: AppColors.of(context).primary,
                  ),
                ),
                title: Text(
                  l10n.uploadPhoto,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  l10n.uploadPhotoSubtitle,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (hasImage) ...[
                Divider(
                  height: 16.h,
                  color: isDark
                      ? AppColors.of(context).border
                      : AppColors.of(context).bordergrey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 4.h,
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.of(context).error,
                    ),
                  ),
                  title: Text(
                    l10n.removePhoto,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.of(context).error,
                    ),
                  ),
                  subtitle: Text(
                    l10n.removePhotoSubtitle,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    profileBloc.add(const ProfileEvent.avatarDeleteRequested());
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(title: l10n.userProfile),
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
              uploading: (profile) => _ProfileBody(
                profile: profile,
                l10n: l10n,
                isUploading: true,
                onPickImage: _showImageSourceSheet,
              ),
              loaded: (profile) => _ProfileBody(
                profile: profile,
                l10n: l10n,
                onPickImage: _showImageSourceSheet,
              ),
              orElse: () => const ProfileSkeleton(),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final dynamic profile;
  final AppLocalizations l10n;
  final bool isUploading;
  final VoidCallback onPickImage;

  const _ProfileBody({
    required this.profile,
    required this.l10n,
    this.isUploading = false,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: ProfileHeader(
                  profile: profile,
                  onPickImage: onPickImage,
                  isUploading: isUploading,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: AppColors.of(context).primary,
                    indicatorWeight: 3.h,
                    dividerColor: AppColors.transparent,
                    labelColor: AppColors.of(context).primary,
                    unselectedLabelColor: AppColors.of(context).textSecondary,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    tabs: [
                      _TabItem(label: l10n.overview),
                      _TabItem(label: l10n.professionalDetails),
                    ],
                  ),
                  AppColors.of(context).profileTabBg,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ProfileOverviewTab(
                profile: profile,
                isUploading: isUploading,
              ),
              const ProfileProfessionalDetailsTab(),
            ],
          ),
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
        margin: EdgeInsets.symmetric(horizontal: 4.w),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverAppBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height + 8.h;

  @override
  double get maxExtent => tabBar.preferredSize.height + 8.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(top: 8.h),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
