import 'package:flutter/material.dart';
import '../../domain/entities/profile_entities.dart';
import 'project_assignments_table.dart';
import 'update_profile_card.dart';
import 'profile_info_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileOverviewTab extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileOverviewTab({
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
          Text(l10n.personalDetails, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ProfileInfoCard(label: l10n.firstName, value: profile.firstName),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.lastName, value: profile.lastName),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.gender, value: profile.gender ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.birthDate, value: profile.birthDate ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.maritalStatus, value: profile.maritalStatus ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.bloodGroup, value: profile.bloodGroup ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.dateOfJoining, value: profile.dateOfJoining ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.employee, value: profile.customPayrollId ?? l10n.notAvailable),

          const SizedBox(height: 24),
          Text(l10n.companyDetails, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ProfileInfoCard(label: l10n.companyName, value: profile.company ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.designation, value: profile.designation ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.department, value: profile.department ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.orgDepartment, value: profile.orgDepartment ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.division, value: profile.division ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.employmentType, value: profile.employmentType ?? 'Active'),
          const SizedBox(height: 24),

          Text(l10n.reportingDetails, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ProfileInfoCard(label: l10n.reportsTo, value: profile.reportsTo ?? l10n.notAvailable),
          const SizedBox(height: 8),
          ProfileInfoCard(label: l10n.reportsToName, value: profile.reportsToName ?? l10n.notAvailable),
          const SizedBox(height: 24),

          Text(l10n.projectAssignments, style: AppTextStyle.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          ProjectAssignmentsTable(assignments: profile.projectAssignments ?? []),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
