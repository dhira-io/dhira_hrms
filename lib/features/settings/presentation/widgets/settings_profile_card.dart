import 'package:flutter/material.dart';
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

  const SettingsProfileCard({
    super.key,
    this.profile,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: profile?.userImage != null && profile!.userImage!.isNotEmpty
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
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile?.fullName ?? '...',
                      style: AppTextStyle.h1.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile?.email ?? '...',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (profile?.empId != null) ...[
                          Flexible(
                            child: _buildBadge(
                              profile!.empId!,
                              AppColors.tertiaryContainer,
                              Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (profile?.department != null)
                          Flexible(
                            child: _buildBadge(
                              profile!.department!,
                              AppColors.primaryFixed,
                              AppColors.onPrimaryFixed,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              onPressed: onEditTap,
              icon: const Icon(
                Icons.edit,
                color: AppColors.primary,
                size: 20,
              ),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
