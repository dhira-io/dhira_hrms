import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/bloc/locale_cubit.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';

class ProfileInfoSection extends StatelessWidget {
  final VoidCallback onPickImage;

  const ProfileInfoSection({
    super.key,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final baseUrl = Get.find<DioClient>().baseUrl;
    final l10n = AppLocalizations.of(context)!;

    return BlocSelector<ProfileBloc, ProfileState, dynamic>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (profile) => profile,
          orElse: () => null,
        );
      },
      builder: (context, profile) {
        if (profile == null) return const SizedBox.shrink();

        return Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profile.userImage != null
                        ? NetworkImage('$baseUrl${profile.userImage}')
                        : const AssetImage(AppAssets.defaultProfile) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton.small(
                      onPressed: onPickImage,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p20),
            Text(
              profile.fullName,
              style: AppTextStyle.h2,
            ),
            const Divider(height: 40, color: AppColors.border),
            _InfoTile(label: l10n.email, value: profile.email, icon: Icons.email),
            _InfoTile(label: l10n.firstName, value: profile.firstName, icon: Icons.person),
            _InfoTile(label: l10n.lastName, value: profile.lastName, icon: Icons.person_outline),
            _InfoTile(label: l10n.birthDate, value: profile.birthDate ?? l10n.notAvailable, icon: Icons.cake),
            _InfoTile(label: l10n.gender, value: profile.gender ?? l10n.notAvailable, icon: Icons.wc),
            _InfoTile(label: l10n.deskTheme, value: profile.deskTheme ?? l10n.defaultVal, icon: Icons.palette),
            const Divider(height: 40, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectLanguage,
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  BlocBuilder<LocaleCubit, Locale>(
                    builder: (context, locale) {
                      return Row(
                        children: [
                          ChoiceChip(
                            label: const Text('English'),
                            selected: locale.languageCode == 'en',
                            onSelected: (_) => context.read<LocaleCubit>().changeLanguage('en'),
                          ),
                          const SizedBox(width: AppConstants.p12),
                          ChoiceChip(
                            label: const Text('हिन्दी'),
                            selected: locale.languageCode == 'hi',
                            onSelected: (_) => context.read<LocaleCubit>().changeLanguage('hi'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
      subtitle: Text(
        value,
        style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}


