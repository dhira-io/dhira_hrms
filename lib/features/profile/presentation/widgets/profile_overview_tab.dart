import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/profile_entities.dart';
import 'project_assignments_table.dart';

class ProfileOverviewTab extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileOverviewTab({
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
          Text('Personal Details', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          _buildInfoCard('First Name', profile.firstName),
          const SizedBox(height: 8),
          _buildInfoCard('Surname', profile.lastName),
          const SizedBox(height: 8),
          _buildInfoCard('Gender', profile.gender ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Date of Birth', profile.birthDate ?? ""),
          const SizedBox(height: 8),
          _buildInfoCard('Blood Group', "N/A"),
          const SizedBox(height: 8),
          _buildInfoCard('Date of Joining', ""),
          const SizedBox(height: 8),
          _buildInfoCard('Employee ID', profile.empId ?? ""),

          const SizedBox(height: 24),
          Text('Company Details', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          _buildInfoCard('Company Name', profile.company ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Designation', profile.designation ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Department', profile.department ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Employment Type', profile.employmentType ?? 'Active'),
          const SizedBox(height: 24),

          Text('Primary Department', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          _buildInfoCard('Department', profile.department ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Company', profile.company ?? 'N/A'),
          const SizedBox(height: 8),
          _buildInfoCard('Reports To', profile.reportsTo ?? 'N/A'),
          const SizedBox(height: 24),

          Text('Project Assignments', style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ProjectAssignmentsTable(assignments: profile.projectAssignments ?? []),
          const SizedBox(height: 40),
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

  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F9FF), // Very light blue from screenshot
        borderRadius: BorderRadius.circular(12),
      ),
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
    );
  }
}
