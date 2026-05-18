import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback onPickImage;
  final bool isUploading;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onPickImage,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final baseUrl = Get.find<DioClient>().baseUrl;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration:  BoxDecoration(
        color: AppColors.of(context).profileHeaderBg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.of(context).white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.of(context).black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: profile.userImage != null && profile.userImage!.isNotEmpty
                            ? Image.network(
                                profile.userImage!.isAbsoluteUrl 
                                    ? profile.userImage! 
                                    : '$baseUrl${profile.userImage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover),
                              )
                            : Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover),
                      ),
                      if (isUploading)
                        Positioned.fill(
                          child: Container(
                            color: AppColors.of(context).black.withValues(alpha: 0.4),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onPickImage,
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.p4),
                    decoration:  BoxDecoration(
                      color: AppColors.of(context).white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.file_upload_outlined, size: 20, color: AppColors.of(context).textSecondary),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: AppConstants.p20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        profile.fullName,
                        style: AppTextStyle.h2.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    // Image.asset(
                    //   AppAssets.logo,
                    //   height: 40,
                    // ),
                  ],
                ),
                SizedBox(height: AppConstants.p8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p4),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(AppConstants.r8),
                    border: Border.all(color: AppColors.of(context).profileBadgeBorder),
                  ),
                  child: Text(
                    profile.designation ?? l10n.notAvailable,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: AppConstants.p12),
                Row(
                  children: [
                    _Badge(
                      icon: Icons.business,
                      label: profile.company ?? l10n.notAvailable,
                      color: AppColors.of(context).profileBadgeBg,
                      textColor: AppColors.of(context).primary,
                    ),
                    SizedBox(width: AppConstants.p8),
                    _Badge(
                      icon: Icons.badge_outlined,
                      label: '${profile.namingSeries ?? ""}${profile.customPayrollId ?? l10n.notAvailable}',
                      color: AppColors.of(context).profileBadgeBg,
                      textColor: AppColors.of(context).primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
