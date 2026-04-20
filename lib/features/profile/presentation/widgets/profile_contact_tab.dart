import 'package:flutter/material.dart';
import '../../domain/entities/profile_entities.dart';
import 'update_profile_card.dart';
import 'contact_info_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileContactTab extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileContactTab({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UpdateProfileCard(),
          const SizedBox(height: 24),
          Text(l10n.contactInformation, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ContactInfoCard(
            label: l10n.companyEmail, 
            value: profile.companyEmail ?? profile.email, 
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 8),
          ContactInfoCard(
            label: l10n.phone, 
            value: profile.phone ?? l10n.notAvailable, 
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 8),
          ContactInfoCard(
            label: l10n.emergencyContact, 
            value: profile.emergencyContact ?? l10n.notAvailable, 
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 40),

          Text(l10n.addressInformation, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ContactInfoCard(
            label: l10n.currentAddress, 
            value: l10n.notAvailable, 
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 8),
          ContactInfoCard(
            label: l10n.permanentAddress, 
            value: l10n.notAvailable, 
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
