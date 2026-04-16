import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileContactTab extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileContactTab({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUpdateProfileCard(),
          const SizedBox(height: 24),
          Text('Contact Information', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          _buildContactCard('Company Email', profile.companyEmail ?? profile.email, Icons.email_outlined),
          const SizedBox(height: 8),
          _buildContactCard('Phone', profile.phone ?? 'N/A', Icons.phone_outlined),
          const SizedBox(height: 8),
          _buildContactCard('Emergency Contact', profile.emergencyContact ?? 'N/A', Icons.phone_outlined),
          const SizedBox(height: 40),

          const SizedBox(height: 24),
          Text('Address Information', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          _buildContactCard('Current Address', "N/A", Icons.location_on_outlined),
          const SizedBox(height: 8),
          _buildContactCard('Permanent Address', 'N/A', Icons.location_on_outlined),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildUpdateProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBBDEFB).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF90CAF9).withOpacity(0.5)),
            ),
            child: const Icon(Icons.email_outlined, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need to update your profile details?',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: AppTextStyle.bodySmall.copyWith(color: Colors.blue[400]),
                    children: [
                      const TextSpan(text: 'Please reach out to '),
                      TextSpan(
                        text: 'HR Department',
                        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' or your '),
                      TextSpan(
                        text: 'Admin',
                        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' for any changes to your personal or professional information.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(String label, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F9FF), // Very light blue
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
