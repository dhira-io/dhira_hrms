import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile_project_assignment_entity.dart';

class ProjectAssignmentsTable extends StatelessWidget {
  final List<ProfileProjectAssignmentEntity> assignments;

  const ProjectAssignmentsTable({
    super.key,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.r12),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1),
          },
          children: [
            // Header
            TableRow(
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              children: [
                _buildHeaderCell(l10n.projectName),
                _buildHeaderCell(l10n.projectLead),
                _buildHeaderCell(l10n.fromDate),
                _buildHeaderCell(l10n.toDate),
              ],
            ),
            // Data Rows
            ...assignments.map((assignment) => TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  children: [
                    _buildDataCell(assignment.projectName),
                    _buildDataCell(assignment.projectLead ?? l10n.notAvailable),
                    _buildDataCell(assignment.startDate ?? '-'),
                    _buildDataCell(assignment.endDate ?? '-'),
                  ],
                )),
            if (assignments.isEmpty)
              TableRow(
                children: [
                  _buildDataCell(l10n.noAssignmentsFound, col: 4),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p12),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {int col = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p16),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.textPrimary,
          fontSize: 12,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
