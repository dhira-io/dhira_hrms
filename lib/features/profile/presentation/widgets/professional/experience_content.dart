import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'dialogs/common_form_bottom_sheet.dart';
import '../../../../../core/widgets/common_alert_dialog.dart';
import '../../../../../core/widgets/common_empty_view.dart';
import '../../../data/constants/profile_api_constants.dart';

class ExperienceContent extends StatelessWidget {
  final List<ResumeWorkExperienceEntity> experiences;
  final List<ResumeConsultingExperienceEntity> consultingExperiences;
  final void Function(String)? onAddKeyProject;
  final void Function(ResumeConsultingExperienceEntity)? onEditKeyProject;
  final void Function(ResumeConsultingExperienceEntity)? onDeleteKeyProject;

  const ExperienceContent({
    super.key,
    required this.experiences,
    required this.consultingExperiences,
    this.onAddKeyProject,
    this.onEditKeyProject,
    this.onDeleteKeyProject,
  });

  @override
  Widget build(BuildContext context) {
    if (experiences.isEmpty) {
      return CommonEmptyView(
        message: AppLocalizations.of(context)!.noExperienceAddedYet,
        icon: Icons.work_outline,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final exp = experiences[index];
        final keyProjects = consultingExperiences
            .where((p) => p.parentCompany == exp.companyName)
            .toList();

        return _ExperienceItemWidget(
          exp: exp,
          keyProjects: keyProjects,
          onEdit: () => _showEditExperienceDialog(context, exp),
          onAddKeyProject: () => onAddKeyProject?.call(exp.companyName),
          onEditKeyProject: onEditKeyProject,
          onDeleteKeyProject: onDeleteKeyProject,
        );
      },
    );
  }

  void _showEditExperienceDialog(
    BuildContext context,
    ResumeWorkExperienceEntity exp,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final titleC = TextEditingController(text: exp.designation);
    final companyC = TextEditingController(text: exp.companyName);
    final fromC = TextEditingController(text: exp.customFromDate);
    final toC = TextEditingController(text: exp.customToDate);
    final summaryC = TextEditingController(text: exp.customAssignmentSummary);
    String type = exp.customEmploymentType.isNotEmpty
        ? exp.customEmploymentType
        : l10n.fullTime;
    bool currentlyWorking = exp.customCurrentlyWorking;

    CommonFormBottomSheet.show(
      context: context,
      bloc: context.read<ProfileBloc>(),
      title: l10n.editWorkExperience,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: companyC,
                  decoration: InputDecoration(
                    labelText: l10n.company,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: titleC,
                  decoration: InputDecoration(
                    labelText: l10n.jobTitle,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: fromC,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: l10n.fromDateYyyymmdd,
                    suffixIcon: const Icon(Icons.calendar_today, size: 20),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setDialogState(() {
                        fromC.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
                if (!currentlyWorking) ...[
                  SizedBox(height: 12.h),
                  TextField(
                    controller: toC,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: l10n.toDateYyyymmdd,
                      suffixIcon: const Icon(Icons.calendar_today, size: 20),
                    ),
                    onTap: () async {
                      DateTime initial = DateTime.now();
                      if (fromC.text.isNotEmpty) {
                        try {
                          final parts = fromC.text.split('-');
                          final fromDate = DateTime(
                            int.parse(parts[0]),
                            int.parse(parts[1]),
                            int.parse(parts[2]),
                          );
                          if (initial.isBefore(fromDate)) initial = fromDate;
                        } catch (_) {}
                      }
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: initial,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          toC.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                  ),
                ],
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Checkbox(
                      value: currentlyWorking,
                      activeColor: AppColors.of(context).primary,
                      onChanged: (val) {
                        setDialogState(() {
                          currentlyWorking = val ?? false;
                          if (currentlyWorking) toC.clear();
                        });
                      },
                    ),
                    Text(l10n.currentlyWorkingHere),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  l10n.employmentType,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    l10n.fullTime,
                    l10n.partTime,
                    l10n.contract,
                  ].map((val) {
                    final isSelected = type == val;
                    return ChoiceChip(
                      label: Text(val),
                      selected: isSelected,
                      showCheckmark: isSelected,
                      selectedColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.of(context).surface
                          : AppColors.of(context).white,
                      labelStyle: AppTextStyle.bodyMedium.copyWith(
                        color: isSelected
                            ? AppColors.of(context).primary
                            : AppColors.of(context).textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.of(context).primary.withValues(alpha: 0.3)
                              : AppColors.of(context).border,
                        ),
                      ),
                      checkmarkColor: AppColors.of(context).primary,
                      onSelected: (selected) {
                        if (selected) setDialogState(() => type = val);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 14.h),
                TextField(
                  controller: summaryC,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.description,
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (companyC.text.isNotEmpty && titleC.text.isNotEmpty) {
          final data = {
            ProfileApiConstants.keyDesignation: titleC.text,
            ProfileApiConstants.keyCompanyName: companyC.text,
            ProfileApiConstants.keyCustomFromDate: fromC.text,
            ProfileApiConstants.keyCustomToDate: currentlyWorking ? "" : toC.text,
            ProfileApiConstants.keyCustomCurrentlyWorking: currentlyWorking,
            ProfileApiConstants.keyCustomEmploymentType: type,
            ProfileApiConstants.keyCustomAssignmentSummary: summaryC.text,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: ProfileApiConstants.sectionWorkExperience,
              rowDataJson: jsonEncode(data),
              rowName: exp.name,
            ),
          );
        }
      },
    );
  }
}

class _ExperienceItemWidget extends StatefulWidget {
  final ResumeWorkExperienceEntity exp;
  final List<ResumeConsultingExperienceEntity> keyProjects;
  final VoidCallback onEdit;
  final VoidCallback onAddKeyProject;
  final void Function(ResumeConsultingExperienceEntity)? onEditKeyProject;
  final void Function(ResumeConsultingExperienceEntity)? onDeleteKeyProject;

  const _ExperienceItemWidget({
    required this.exp,
    required this.keyProjects,
    required this.onEdit,
    required this.onAddKeyProject,
    this.onEditKeyProject,
    this.onDeleteKeyProject,
  });

  @override
  State<_ExperienceItemWidget> createState() => _ExperienceItemWidgetState();
}

class _ExperienceItemWidgetState extends State<_ExperienceItemWidget> {
  bool _isKeyProjectsExpanded = false;
  bool _isDeleting = false;

  String _formatDate(String dateStr, AppLocalizations l10n) {
    if (dateStr.isEmpty) return l10n.presentLabel;
    try {
      final parts = dateStr.split('-');
      if (parts.length >= 2) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        const months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];
        if (month >= 1 && month <= 12) {
          return "${months[month - 1]} $year";
        }
      }
    } catch (_) {}
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final exp = widget.exp;
    final formattedFrom = _formatDate(exp.customFromDate, l10n);
    final formattedTo = exp.customCurrentlyWorking
        ? l10n.presentLabel
        : _formatDate(exp.customToDate, l10n);
    final period = "$formattedFrom -> $formattedTo";

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (_isDeleting) {
          state.maybeWhen(
            uploading: (_, __) {},
            orElse: () {
              if (mounted) setState(() => _isDeleting = false);
            },
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.companyName,
                      style: AppTextStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      exp.designation,
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.of(context).slate400
                            : AppColors.of(context).slate500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined, size: 20.sp),
                    onPressed: _isDeleting ? null : widget.onEdit,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: isDark
                        ? AppColors.of(context).slate400
                        : AppColors.of(context).slate500,
                  ),
                  SizedBox(width: 12.w),
                  if (_isDeleting)
                    SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.of(context).error,
                      ),
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.delete_outline, size: 20.sp),
                      onPressed: () {
                        CommonAlertDialog.show(
                          context: context,
                          title: l10n.delete,
                          content: l10n.deleteExperienceConfirmation,
                          confirmText: l10n.delete,
                          cancelText: l10n.cancel,
                          confirmButtonColor: AppColors.of(context).error,
                          onConfirm: () {
                            setState(() => _isDeleting = true);
                            context.read<ProfileBloc>().add(
                              ProfileEvent.resumeRowDeleteRequested(
                                section: ProfileApiConstants.sectionWorkExperience,
                                rowName: exp.name,
                              ),
                            );
                          },
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: Colors.red,
                    ),
                ],
              ),
            ],
          ),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              period,
              style: AppTextStyle.bodySmall.copyWith(
                color: isDark
                    ? AppColors.of(context).slate400
                    : AppColors.of(context).slate500,
              ),
            ),
            if (exp.customEmploymentType.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.of(context).slate800
                      : AppColors.of(context).slate100,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  exp.customEmploymentType,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.of(context).slate300
                        : AppColors.of(context).slate700,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (exp.customAssignmentSummary.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            exp.customAssignmentSummary,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.of(context).slate300
                  : AppColors.of(context).slate600,
              height: 1.5,
            ),
          ),
        ],
        SizedBox(height: 16.h),
        InkWell(
          onTap: () {
            setState(() {
              _isKeyProjectsExpanded = !_isKeyProjectsExpanded;
            });
          },
          child: Row(
            children: [
              Icon(
                _isKeyProjectsExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.of(context).primary,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                l10n.keyProjects,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.of(context).slate300
                      : AppColors.of(context).slate700,
                ),
              ),
              if (widget.keyProjects.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    widget.keyProjects.length.toString(),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (_isKeyProjectsExpanded) ...[
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.of(context).surface
                  : AppColors.of(context).white,
              border: Border.all(
                color: isDark
                    ? AppColors.of(context).border
                    : AppColors.of(context).slate100,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.keyProjects.isNotEmpty) ...[
                  for (final project in widget.keyProjects) ...[
                    _KeyProjectItem(
                      key: ValueKey(project.name),
                      project: project,
                      onEdit: () => widget.onEditKeyProject?.call(project),
                      onDelete: () => widget.onDeleteKeyProject?.call(project),
                    ),
                    if (project != widget.keyProjects.last)
                      Divider(height: 24.h),
                  ],
                ],
                SizedBox(height: widget.keyProjects.isNotEmpty ? 16.h : 0),
                OutlinedButton.icon(
                  onPressed: widget.onAddKeyProject,
                  icon: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: AppColors.of(context).primary,
                  ),
                  label: Text(AppLocalizations.of(context)!.addKeyProject),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.of(context).primary,
                    side: BorderSide(
                      color: AppColors.of(
                        context,
                      ).primary.withValues(alpha: 0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ));
  }
}

class _KeyProjectItem extends StatefulWidget {
  final ResumeConsultingExperienceEntity project;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _KeyProjectItem({
    super.key,
    required this.project,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<_KeyProjectItem> createState() => _KeyProjectItemState();
}

class _KeyProjectItemState extends State<_KeyProjectItem> {
  bool _isExpanded = true;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final project = widget.project;
    final calculated = DateTimeUtils.calculateDuration(project.fromDate, project.toDate);
    final displayDuration = calculated.isNotEmpty
        ? calculated
        : (project.duration.isNotEmpty &&
                project.duration.toLowerCase() != ProfileApiConstants.durationNoDataFilled &&
                project.duration.toLowerCase() != ProfileApiConstants.durationNoData
            ? project.duration
            : "");

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (_isDeleting) {
          state.maybeWhen(
            uploading: (_, __) {},
            orElse: () {
              if (mounted) setState(() => _isDeleting = false);
            },
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.of(context).primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.work_outline,
                          color: AppColors.of(context).primary,
                          size: 16.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.project,
                              style: AppTextStyle.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              project.clientName,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined, size: 18.sp),
                    onPressed: _isDeleting ? null : widget.onEdit,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: isDark
                        ? AppColors.of(context).slate400
                        : AppColors.of(context).slate500,
                  ),
                  SizedBox(width: 12.w),
                  if (_isDeleting)
                    SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.of(context).error,
                      ),
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.delete_outline, size: 18.sp),
                      onPressed: () {
                        CommonAlertDialog.show(
                          context: context,
                          title: locale.delete,
                          content: locale.deleteKeyProjectConfirmation,
                          confirmText: locale.delete,
                          cancelText: locale.cancel,
                          confirmButtonColor: AppColors.of(context).error,
                          onConfirm: () {
                            setState(() => _isDeleting = true);
                            widget.onDelete?.call();
                          },
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: Colors.red,
                    ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.of(context).slate400,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_isExpanded) ...[
            SizedBox(height: 12.h),
            if (project.projectOverview.isNotEmpty) ...[
              Text(
                project.projectOverview,
                style: AppTextStyle.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.of(context).slate300
                      : AppColors.of(context).slate500,
                ),
              ),
              SizedBox(height: 4.h),
            ],
            if (project.businessImpact.isNotEmpty) ...[
              Text(
                project.businessImpact,
                style: AppTextStyle.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.of(context).slate300
                      : AppColors.of(context).slate500,
                ),
              ),
              SizedBox(height: 8.h),
            ],
            Row(
              children: [
                if (displayDuration.isNotEmpty) ...[
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: AppColors.of(context).slate400,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    displayDuration,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: isDark
                          ? AppColors.of(context).slate400
                          : AppColors.of(context).slate500,
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
                if (project.toolsAndTechnologies.isNotEmpty) ...[
                  Icon(
                    Icons.build_outlined,
                    size: 14.sp,
                    color: AppColors.of(context).slate400,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      project.toolsAndTechnologies,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: isDark
                            ? AppColors.of(context).slate400
                            : AppColors.of(context).slate500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
