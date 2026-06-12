import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/notifications/presentation/widgets/notification_bell.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';

class AppHeader extends StatefulWidget {
  final bool showName;
  final bool showNotification;

  const AppHeader({
    super.key,
    this.showName = true,
    this.showNotification = true,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  void initState() {
    super.initState();
    // Refresh profile to ensure we have the latest uploaded image
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileBloc>().add(const ProfileEvent.started());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p20,
            vertical: AppConstants.p16,
          ),
          color: AppColors.of(context).background,
          child: Row(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final user = authState.maybeWhen(
                    authenticated: (user) => user,
                    orElse: () => null,
                  );

                  return GestureDetector(
                    onTap: () => context.push(AppRouter.profilePath),
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, profileState) {
                        final profileImage = profileState.maybeWhen(
                          loaded: (profile, resume) => profile.userImage,
                          orElse: () => user?.userImage,
                        );

                        final fullName = profileState.maybeWhen(
                          loaded: (profile, resume) => profile.fullName,
                          orElse: () => user?.fullName,
                        );

                        final baseUrl = Get.find<DioClient>().baseUrl;

                        return Row(
                          children: [
                            Container(
                              width: AppConstants.p40,
                              height: AppConstants.p40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.of(context).primaryFixed,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child:
                                  (profileImage != null &&
                                      profileImage.isNotEmpty)
                                  ? Image.network(
                                      profileImage.startsWith(
                                            AppConstants.httpPrefix,
                                          )
                                          ? profileImage
                                          : "$baseUrl$profileImage",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Image(
                                        image: AssetImage(AppAssets.defaultProfile),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Image(
                                      image: AssetImage(
                                        AppAssets.defaultProfile,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            if (widget.showName) ...[
                              const SizedBox(width: AppConstants.p12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Text(
                                  //   AppLocalizations.of(context)!.welcomeName,
                                  //   style: AppTextStyle.bodySmall.copyWith(
                                  //     color: AppColors.of(context).onSurfaceVariant,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  Text(
                                    fullName ??
                                        AppLocalizations.of(
                                          context,
                                        )!.employeeName,
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      color: AppColors.of(context).onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              if (widget.showNotification) const NotificationBell(),
            ],
          ),
        ),
        Container(
          height: AppConstants.dividerHeight,
          width: double.infinity,
          color: AppColors.of(
            context,
          ).outlineVariant.withValues(alpha: AppConstants.opacityMedium),
        ),
      ],
    );
  }
}
