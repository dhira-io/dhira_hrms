import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';

class EditTimesheetTaskBottomSheet extends StatefulWidget {
  final String date;
  final String initialProject;
  final String initialTask;
  final String initialExpected;
  final String initialActual;
  final String initialDescription;
  final List<ProjectEntity> projects;
  final Future<void> Function(String project, String task, String expected, String actual, String description) onSave;

  const EditTimesheetTaskBottomSheet({
    super.key,
    required this.date,
    required this.initialProject,
    required this.initialTask,
    required this.initialExpected,
    required this.initialActual,
    required this.initialDescription,
    required this.projects,
    required this.onSave,
  });

  @override
  State<EditTimesheetTaskBottomSheet> createState() => _EditTimesheetTaskBottomSheetState();
}

class _EditTimesheetTaskBottomSheetState extends State<EditTimesheetTaskBottomSheet> {
  late String _selectedProject;
  late TextEditingController _taskController;
  late TextEditingController _expectedController;
  late TextEditingController _actualController;
  late TextEditingController _descriptionController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedProject = widget.initialProject;
    _taskController = TextEditingController(text: widget.initialTask);
    _expectedController = TextEditingController(text: widget.initialExpected);
    _actualController = TextEditingController(text: widget.initialActual);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    // Attempting to format date to something like "09 Monday, June"
    final dateObj = DateTime.tryParse(widget.date);
    final formattedDate = dateObj != null 
        ? DateTimeUtils.formatDateString(widget.date, pattern: "dd EEEE, MMMM")
        : widget.date;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.editingTask,
                      style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDate,
                      style: AppTextStyle.bodySmall.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.close, color: colors.textPrimary),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            SizedBox(height: 24.h),
            
            Text(l10n.project, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            _DropdownField(
              colors: colors,
              selectedProject: _selectedProject,
              projects: widget.projects,
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedProject = val;
                  });
                }
              },
            ),
            SizedBox(height: 16.h),
            
            Text(l10n.task, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            _TextField(colors: colors, controller: _taskController),
            SizedBox(height: 16.h),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.expectedHrs, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.h),
                      _TextField(colors: colors, controller: _expectedController),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.actualHrs, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.h),
                      _TextField(colors: colors, controller: _actualController),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            
            Text(l10n.description, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            _TextField(colors: colors, controller: _descriptionController, maxLines: 4),
            SizedBox(height: 32.h),
            
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onPressed: () => Navigator.pop(context),
                    text: l10n.cancel,
                    variant: ButtonVariant.outlined,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    borderRadius: 8.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    onPressed: _isSaving ? null : () async {
                      final navigator = Navigator.of(context);
                      setState(() => _isSaving = true);
                      try {
                        await widget.onSave(
                          _selectedProject,
                          _taskController.text,
                          _expectedController.text,
                          _actualController.text,
                          _descriptionController.text,
                        );
                        if (mounted) navigator.pop();
                      } finally {
                        if (mounted) setState(() => _isSaving = false);
                      }
                    },
                    text: l10n.save,
                    isLoading: _isSaving,
                    variant: ButtonVariant.primary,
                    backgroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    borderRadius: 8.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final AppColorsResolved colors;
  final String selectedProject;
  final List<ProjectEntity> projects;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.colors,
    required this.selectedProject,
    required this.projects,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedProject.isEmpty && projects.isNotEmpty 
              ? projects.first.name 
              : (selectedProject.isEmpty ? null : selectedProject),
          isExpanded: true,
          dropdownColor: colors.surfaceContainerLowest,
          icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
          style: AppTextStyle.bodyMedium.copyWith(color: colors.textPrimary),
          items: projects.map((p) => DropdownMenuItem(
            value: p.name,
            child: Text(p.projectName, overflow: TextOverflow.ellipsis),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final AppColorsResolved colors;
  final TextEditingController controller;
  final int maxLines;

  const _TextField({
    required this.colors,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyle.bodyMedium.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.primary),
        ),
      ),
    );
  }
}
