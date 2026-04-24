import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import 'package:get/get.dart';

import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  void initState() {
    super.initState();
    // Refresh profile to ensure we have the latest uploaded image
    context.read<ProfileBloc>().add(const ProfileEvent.started());
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
          color: AppColors.background,
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
                          loaded: (profile) => profile.userImage,
                          orElse: () => user?.userImage,
                        );

                        final baseUrl = Get.find<DioClient>().baseUrl;

                        return Container(
                          width: AppConstants.p40,
                          height: AppConstants.p40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryFixed,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: (profileImage != null && profileImage.isNotEmpty)
                              ? Image.network(
                                  profileImage.startsWith('http')
                                      ? profileImage
                                      : "$baseUrl$profileImage",
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  image: AssetImage(AppAssets.defaultProfile),
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.onSurfaceVariant,
                  size: AppConstants.iconMedium,
                ),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(AppConstants.p40, AppConstants.p40),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
