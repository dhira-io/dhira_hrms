import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/profile_project_assignment_entity.dart';

class ProjectAssignmentsTable extends StatelessWidget {
  final List<ProfileProjectAssignmentEntity> assignments;

  const ProjectAssignmentsTable({
    super.key,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
                color: Color(0xFFF8F9FA),
              ),
              children: [
                _buildHeaderCell('Project Name'),
                _buildHeaderCell('Project Lead'),
                _buildHeaderCell('Start Date'),
                _buildHeaderCell('End Date'),
              ],
            ),
            // Data Rows
            ...assignments.map((assignment) => TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  children: [
                    _buildDataCell(assignment.projectName),
                    _buildDataCell(assignment.projectLead ?? 'N/A'),
                    _buildDataCell(assignment.startDate ?? '-'),
                    _buildDataCell(assignment.endDate ?? '-'),
                  ],
                )),
            if (assignments.isEmpty)
              TableRow(
                children: [
                  _buildDataCell('No assignments found', col: 4),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(
          color: Colors.blueGrey[400],
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {int col = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
