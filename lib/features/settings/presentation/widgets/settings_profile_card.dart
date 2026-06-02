import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../profile/domain/entities/profile_entities.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/network/dio_client.dart';
import 'package:get/get.dart';
import '../../../../core/utils/string_utils.dart';

class SettingsProfileCard extends StatelessWidget {
  final ProfileEntity? profile;
  final VoidCallback onEditTap;

  const SettingsProfileCard({super.key, this.profile, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:       EdgeInsets.all(24.0.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    profile?.userImage != null && profile!.userImage!.isNotEmpty
                    ? Image.network(
                        profile!.userImage!.toAbsoluteUrl(profile!.userImage!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Image(
                              image: AssetImage(AppAssets.defaultProfile),
                              fit: BoxFit.cover,
                            ),
                      )
                    : const Image(
                        image: AssetImage(AppAssets.defaultProfile),
                        fit: BoxFit.cover,
                      ),
              ),
                    SizedBox(width: 24.w),
              Expanded(
                child: Padding(
                  padding:       EdgeInsets.only(right: 16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile?.fullName ?? '...',
                        style: AppTextStyle.h1.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                            SizedBox(height: 4.h),
                      Text(
                        profile?.email ?? '...',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.of(context).onSurfaceVariant,
                        ),
                      ),
                            SizedBox(height: 8.h),
                      Row(
                        children: [
                          if (profile?.empId != null) ...[
                            Flexible(
                              child: _buildBadge(
                                profile!.empId!,
                                AppColors.of(context).tertiaryContainer,
                                Colors.white,
                              ),
                            ),
                                  SizedBox(width: 8.w),
                          ],
                          if (profile?.department != null)
                            Flexible(
                              child: _buildBadge(
                                profile!.department!,
                                AppColors.of(context).primaryFixed,
                                AppColors.of(context).onPrimaryFixed,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: -12,
          //   right: -12,
          //   child: IconButton(
          //     onPressed: onEditTap,
          //     icon: Icon(
          //       Icons.edit,
          //       color: AppColors.of(context).primary,
          //       size: 20,
          //     ),
          //     constraints: const BoxConstraints(),
          //     padding: const EdgeInsets.all(12.w),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding:       EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
