import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/profile/data/models/search_employee_model.dart';
import 'package:dhira_hrms/features/profile/domain/entities/profile_project_assignment_entity.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_employees_usecase.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_projects_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../data/constants/profile_api_constants.dart';
import 'dart:convert';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../core/utils/language_helper.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../bloc/profile_event.dart';
import 'professional/collapsible_card.dart';
import 'professional/skills_content.dart';
import 'professional/experience_content.dart';
import 'professional/employee_project_assignments_content.dart';
import 'professional/languages_content.dart';
import 'professional/certifications_content.dart';
import 'professional/education_content.dart';
import 'professional/professional_summary_content.dart';
import 'professional/common_form_bottom_sheet.dart';
import '../../domain/usecases/search_skills_usecase.dart';
import '../../domain/usecases/search_designations_usecase.dart';
import '../../domain/usecases/get_sub_skills_usecase.dart';
import '../../domain/entities/resume_entity.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileProfessionalDetailsTab extends StatefulWidget {
  const ProfileProfessionalDetailsTab({super.key});

  @override
  State<ProfileProfessionalDetailsTab> createState() =>
      _ProfileProfessionalDetailsTabState();
}

class _ProfileProfessionalDetailsTabState
    extends State<ProfileProfessionalDetailsTab> {
  // Collapsed/Expanded states
  bool _isSummaryExpanded = true;
  bool _isResumeExpanded = true;
  bool _isSkillsExpanded = true;
  bool _isExperienceExpanded = true;
  bool _isProjectsExpanded = true;
  bool _isLanguagesExpanded = false;
  bool _isCertificationsExpanded = false;
  bool _isEducationExpanded = false;

  bool get _isAnyExpanded =>
      _isSummaryExpanded ||
      _isResumeExpanded ||
      _isSkillsExpanded ||
      _isExperienceExpanded ||
      _isProjectsExpanded ||
      _isLanguagesExpanded ||
      _isCertificationsExpanded ||
      _isEducationExpanded;

  late TextEditingController _summaryController;
  late TextEditingController _awardsController;
  bool _isControllersInitialized = false;

  @override
  void dispose() {
    if (_isControllersInitialized) {
      _summaryController.dispose();
      _awardsController.dispose();
    }
    super.dispose();
  }

  void _initControllers(resume) {
    if (!_isControllersInitialized) {
      _summaryController = TextEditingController(
        text: resume.professionalSummary,
      );
      _awardsController = TextEditingController(
        text: resume.awardsAndAchievements,
      );
      _isControllersInitialized = true;
    }
  }

  // Removed _calculateResumeCompletion as it's now in ResumeEntity

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        final prevResume = previous.resume;
        final currResume = current.resume;
        final prevProfile = previous.profile;
        final currProfile = current.profile;

        // First load: data just arrived
        if (prevResume == null && currResume != null) return true;
        if (prevProfile == null && currProfile != null) return true;

        // Both have data — rebuild only when content actually changed
        if (prevResume != null && currResume != null) {
          if (prevResume.skills.length != currResume.skills.length) return true;
          if (prevResume.workExperience.length != currResume.workExperience.length) return true;
          if (prevResume.consultingExperience.length != currResume.consultingExperience.length) return true;
          if (prevResume.languages.length != currResume.languages.length) return true;
          if (prevResume.certifications.length != currResume.certifications.length) return true;
          if (prevResume.education.length != currResume.education.length) return true;
          if (prevResume.professionalSummary != currResume.professionalSummary) return true;
          if (prevResume.awardsAndAchievements != currResume.awardsAndAchievements) return true;
          // Detect edits within items (compare json-encoded data by checking first item if same count)
          if (prevResume.skills != currResume.skills) return true;
          if (prevResume.workExperience != currResume.workExperience) return true;
          if (prevResume.languages != currResume.languages) return true;
          if (prevResume.certifications != currResume.certifications) return true;
          if (prevResume.education != currResume.education) return true;
        }
        if (prevProfile != currProfile) return true;

        // Skip rebuilding on uploading ↔ success state type flips
        return false;
      },
      builder: (context, state) {
        final resume = state.resume;
        final profile = state.profile;

        if (resume == null || profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        _initControllers(resume);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12.w,
                runSpacing: 8.h,
                children: [
                  Text(
                    AppLocalizations.of(context)!.resumeLabel,
                    style: AppTextStyle.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                           ? AppColors.of(context).white
                           : AppColors.of(context).textPrimary,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocSelector<ProfileBloc, ProfileState, int>(
                        selector: (state) =>
                            state.resume?.completionPercentage ?? 0,
                        builder: (context, completionPercent) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: AppColors.of(context).border,
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 60.w * (completionPercent / 100),
                                      decoration: BoxDecoration(
                                        color: AppColors.of(context).primary,
                                        borderRadius: BorderRadius.circular(3.r),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "$completionPercent%",
                                style: AppTextStyle.labelLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.of(context).textSecondary
                                      : AppColors.of(context).textSecondary,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(width: 8.w),
                      OutlinedButton.icon(
                        onPressed: () {
                          if (_isAnyExpanded) {
                            setState(() {
                              _isSummaryExpanded = false;
                              _isResumeExpanded = false;
                              _isSkillsExpanded = false;
                              _isExperienceExpanded = false;
                              _isProjectsExpanded = false;
                              _isLanguagesExpanded = false;
                              _isCertificationsExpanded = false;
                              _isEducationExpanded = false;
                            });
                          } else {
                            setState(() {
                              _isSummaryExpanded = true;
                              _isResumeExpanded = true;
                              _isSkillsExpanded = true;
                              _isExperienceExpanded = true;
                              _isProjectsExpanded = true;
                              _isLanguagesExpanded = true;
                              _isCertificationsExpanded = true;
                              _isEducationExpanded = true;
                            });
                          }
                        },
                        icon: Icon(
                          _isAnyExpanded
                              ? Icons.unfold_less
                              : Icons.unfold_more,
                          size: 16.sp,
                        ),
                        label: Text(
                          _isAnyExpanded
                              ? AppLocalizations.of(context)!.retractAll
                              : AppLocalizations.of(context)!.expandAll,
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.of(context).textSecondary
                                  : AppColors.of(context).textPrimary,
                          side: BorderSide(color: AppColors.of(context).border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // 2. Professional Summary
              CollapsibleCard(
                title: AppLocalizations.of(context)!.professionalSummary,
                icon: Icons.person_outline,
                isExpanded: _isSummaryExpanded,
                onToggle: () =>
                    setState(() => _isSummaryExpanded = !_isSummaryExpanded),
                child: ProfessionalSummaryContent(
                  summaryController: _summaryController,
                  awardsController: _awardsController,
                ),
              ),
              SizedBox(height: 12.h),

              // 3. Skills Card
              BlocSelector<ProfileBloc, ProfileState, List<ResumeSkillEntity>>(
                selector: (state) => state.resume?.skills ?? const [],
                builder: (context, skills) {
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.skillsSubskills,
                    icon: Icons.star_outline,
                    count: skills.length,
                    isExpanded: _isSkillsExpanded,
                    onToggle: () =>
                        setState(() => _isSkillsExpanded = !_isSkillsExpanded),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.addSkill,
                      onPressed: () => _showAddSkillDialog(context),
                    ),
                    child: SkillsContent(skills: skills),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 3. Work Experience Card
              BlocSelector<
                  ProfileBloc,
                  ProfileState,
                  (
                    List<ResumeWorkExperienceEntity>,
                    List<ResumeConsultingExperienceEntity>
                  )>(
                selector: (state) => (
                  state.resume?.workExperience ?? const [],
                  state.resume?.consultingExperience ?? const [],
                ),
                builder: (context, data) {
                  final experiences = data.$1;
                  final consultingExperiences = data.$2;
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.workExperience,
                    icon: Icons.work_outline,
                    count: experiences.length,
                    isExpanded: _isExperienceExpanded,
                    onToggle: () => setState(
                      () => _isExperienceExpanded = !_isExperienceExpanded,
                    ),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => _showAddExperienceDialog(context),
                    ),
                    child: ExperienceContent(
                      experiences: experiences,
                      consultingExperiences: consultingExperiences,
                      onAddKeyProject: (parentCompany) {
                        _showAddProjectDialog(
                          context,
                          initialParentCompany: parentCompany,
                        );
                      },
                      onEditKeyProject: (project) {
                        _showAddProjectDialog(
                          context,
                          project: project,
                        );
                      },
                      onDeleteKeyProject: (project) {
                        context.read<ProfileBloc>().add(
                              ProfileEvent.resumeRowDeleteRequested(
                                section: "consulting_experience",
                                rowName: project.name,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 4. Project Assignments Card
              BlocSelector<ProfileBloc, ProfileState, ProfileEntity?>(
                selector: (state) => state.profile,
                builder: (context, profile) {
                  if (profile == null) return const SizedBox.shrink();
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.projectAssignments,
                    icon: Icons.assignment_outlined,
                    count: profile.projectAssignments?.length ?? 0,
                    isExpanded: _isProjectsExpanded,
                    onToggle: () => setState(
                        () => _isProjectsExpanded = !_isProjectsExpanded),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => _showAddProjectAssignmentDialog(context),
                    ),
                    child: EmployeeProjectAssignmentsContent(profile: profile),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 5. Languages Card
              BlocSelector<ProfileBloc, ProfileState,
                  List<ResumeLanguageEntity>>(
                selector: (state) => state.resume?.languages ?? const [],
                builder: (context, languages) {
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.languages,
                    icon: Icons.language_outlined,
                    count: languages.length,
                    isExpanded: _isLanguagesExpanded,
                    onToggle: () => setState(
                      () => _isLanguagesExpanded = !_isLanguagesExpanded,
                    ),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => _showAddLanguageDialog(context),
                    ),
                    child: LanguagesContent(languages: languages),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 6. Certifications Card
              BlocSelector<ProfileBloc, ProfileState,
                  List<ResumeCertificationEntity>>(
                selector: (state) => state.resume?.certifications ?? const [],
                builder: (context, certifications) {
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.certifications,
                    icon: Icons.verified_outlined,
                    count: certifications.length,
                    isExpanded: _isCertificationsExpanded,
                    onToggle: () => setState(
                      () => _isCertificationsExpanded =
                          !_isCertificationsExpanded,
                    ),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => _showAddCertificationDialog(context),
                    ),
                    child: CertificationsContent(
                      certifications: certifications,
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 7. Education Card
              BlocSelector<ProfileBloc, ProfileState,
                  List<ResumeEducationEntity>>(
                selector: (state) => state.resume?.education ?? const [],
                builder: (context, education) {
                  return CollapsibleCard(
                    title: AppLocalizations.of(context)!.education,
                    icon: Icons.school_outlined,
                    count: education.length,
                    isExpanded: _isEducationExpanded,
                    onToggle: () => setState(
                      () => _isEducationExpanded = !_isEducationExpanded,
                    ),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => _showAddEducationDialog(context),
                    ),
                    child: EducationContent(education: education),
                  );
                },
              ),
              SizedBox(height: 32.h),

              // Save Profile Button at the bottom
              BlocSelector<ProfileBloc, ProfileState, (bool, ResumeEntity?)>(
                selector: (state) {
                  final isUploading = state.maybeWhen(
                    uploading: (_, __) => true,
                    orElse: () => false,
                  );
                  return (isUploading, state.resume);
                },
                builder: (context, data) {
                  final isUploading = data.$1;
                  final resume = data.$2;
                  if (resume == null) return const SizedBox.shrink();

                  return CommonButton(
                    text: isUploading
                        ? AppLocalizations.of(context)!.saving
                        : AppLocalizations.of(context)!.saveProfile,
                    isLoading: isUploading,
                    icon: Icons.save_outlined,
                    width: double.infinity,
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                            ProfileEvent.resumeUpdateRequested(
                              resumeDataJson: jsonEncode({
                                "professional_summary":
                                    _summaryController.text,
                                "awards_and_achievements":
                                    _awardsController.text,
                                "skills": resume.skills
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "skill": e.skill,
                                        "proficiency": e.proficiency,
                                        "years_of_experience":
                                            e.yearsOfExperience,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "work_experience": resume.workExperience
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "company_name": e.companyName,
                                        "designation": e.designation,
                                        "custom_from_date":
                                            e.customFromDate,
                                        "custom_to_date":
                                            e.customToDate,
                                        "currently_working":
                                            e.currentlyWorking ? 1 : 0,
                                        "custom_assignment_summary":
                                            e.customAssignmentSummary,
                                        "custom_key_responsibilities":
                                            e.customKeyResponsibilities,
                                        "custom_key_achievements":
                                            e.customKeyAchievements,
                                        "custom_currently_working":
                                            e.customCurrentlyWorking ? 1 : 0,
                                        "custom_employment_type":
                                            e.customEmploymentType,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "projects": resume.projects
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "project_name": e.projectName,
                                        "role": e.role,
                                        "start_date": e.startDate,
                                        "end_date": e.endDate,
                                        "allocation": e.allocation,
                                        "status": e.status,
                                        "report_to": e.reportTo,
                                        "report_to_name":
                                            e.reportToName,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "languages": resume.languages
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "language": e.language,
                                        "speaking": e.speaking,
                                        "reading": e.reading,
                                        "writing": e.writing,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "education": resume.education
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "school_univ": e.schoolUniv,
                                        "qualification":
                                            e.qualification,
                                        "year_of_passing":
                                            e.yearOfPassing,
                                        "level": e.level,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "certifications": resume.certifications
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
                                          "name": e.name,
                                        "certification_name":
                                            e.certificationName,
                                        "issuing_institute":
                                            e.issuingInstitute,
                                        "year_obtained": e.yearObtained,
                                        "certification_url":
                                            e.certificationUrl,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                                "consulting_experience": resume
                                    .consultingExperience
                                    .map(
                                      (e) => {
                                        if (e.name.isNotEmpty)
"name": e.name,
                                        "parent_company":
                                            e.parentCompany,
                                        "client_name": e.clientName,
                                        "project": e.project,
                                        "from_date": e.fromDate,
                                        "to_date": e.toDate,
                                        "duration": (e.duration.isNotEmpty &&
                                                e.duration.toLowerCase() != "no data filled" &&
                                                e.duration.toLowerCase() != "no data")
                                            ? e.duration
                                            : DateTimeUtils.calculateDuration(e.fromDate, e.toDate),
                                        "project_overview":
                                            e.projectOverview,
                                        "business_impact":
                                            e.businessImpact,
                                        "tools_and_technologies":
                                            e.toolsAndTechnologies,
                                        "custom_role": e.customRole,
                                        "custom_project_lead":
                                            e.customProjectLead,
                                        "custom_allocation":
                                            e.customAllocation,
                                        "custom_status": e.customStatus,
                                        "display_order": e.displayOrder,
                                      },
                                    )
                                    .toList(),
                              }),
                              subSkillsJson: "{}",
                            ),
                          );
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  // --- Add Dialogs ---

  void _showAddSkillDialog(BuildContext context) {
    final skillController = TextEditingController();
    String level = AppLocalizations.of(context)!.expert;
    String exp = "1.0";
    bool isValidSkill = false;
    List<SubSkillEntity> availableSubSkills = [];
    List<String> selectedSubSkills = [];
    bool isLoadingSubSkills = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.of(context).surface
          : AppColors.of(context).white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) {
            return CommonFormBottomSheet(
              title: AppLocalizations.of(context)!.addNewSkill,
              fields: [
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        if (textEditingValue.text.isEmpty) {
                          return [
                            AppLocalizations.of(context)!.accessibilityUx,
                            AppLocalizations.of(context)!.agenticAi,
                            AppLocalizations.of(context)!.analytics,
                            AppLocalizations.of(context)!.animationGameLoops,
                            AppLocalizations.of(context)!.backendDevelopment,
                            AppLocalizations.of(context)!.cloudComputing,
                            AppLocalizations.of(context)!.dataTransformationModeling,
                            AppLocalizations.of(context)!.frontendDevelopment,
                            AppLocalizations.of(context)!.machineLearning,
                            AppLocalizations.of(context)!.mobileDevelopment,
                          ];
                        }
                        final useCase = Get.find<SearchSkillsUseCase>();
                        final result = await useCase(textEditingValue.text);
                        return result.fold(
                              (failure) => const Iterable<String>.empty(),
                              (skills) => skills,
                        );
                      },
                      onSelected: (String selection) async {
                        setState(() {
                          skillController.text = selection;
                          isValidSkill = true;
                          isLoadingSubSkills = true;
                          availableSubSkills = [];
                          selectedSubSkills = [];
                        });

                        final subSkillsUseCase = Get.find<GetSubSkillsUseCase>();
                        final result = await subSkillsUseCase(selection);

                        result.fold(
                              (failure) {
                            setState(() {
                              isLoadingSubSkills = false;
                            });
                          },
                              (subSkills) {
                            setState(() {
                              availableSubSkills = subSkills;
                              isLoadingSubSkills = false;
                            });
                          },
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 300, maxHeight: 200.h),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                      child: Text(option, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textPrimary)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        controller.addListener(() {
                          if (controller.text != skillController.text) {
                            setState(() {
                              skillController.text = controller.text;
                              isValidSkill = false;
                              availableSubSkills = [];
                              selectedSubSkills = [];
                            });
                          }
                        });
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.skillName,
                            hintText: AppLocalizations.of(context)!.startTypingToSearchSkills,
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) return AppLocalizations.of(context)!.skillCannotBeEmpty;
                            if (!isValidSkill) return AppLocalizations.of(context)!.pleaseSelectAValidSkillFromTheList;
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 14.h),
                Text(
                  AppLocalizations.of(context)!.proficiency,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    AppLocalizations.of(context)!.beginner,
                    AppLocalizations.of(context)!.intermediate,
                    AppLocalizations.of(context)!.advanced,
                    AppLocalizations.of(context)!.expert,
                  ].map((val) {
                    final isSelected = level == val;
                    return ChoiceChip(
                      label: Text(val),
                      selected: isSelected,
                      showCheckmark: isSelected,
                      selectedColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.of(context).surface
                          : AppColors.of(context).white,
                      labelStyle: AppTextStyle.bodyMedium.copyWith(
                        color: isSelected ? AppColors.of(context).primary : AppColors.of(context).textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(color: isSelected ? AppColors.of(context).primary.withValues(alpha: 0.3) : AppColors.of(context).border),
                      ),
                      checkmarkColor: AppColors.of(context).primary,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => level = val);
                        }
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 14.h),
                TextFormField(
                  initialValue: exp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.experienceYears),
                  onChanged: (val) => setState(() => exp = val),
                ),
                if (isLoadingSubSkills) ...[
                  SizedBox(height: 14.h),
                  const Center(child: CircularProgressIndicator()),
                ] else if (isValidSkill) ...[
                  SizedBox(height: 14.h),
                  Text(
                    AppLocalizations.of(context)!.subSkills,
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
                  ),
                  SizedBox(height: 8.h),
                  if (availableSubSkills.isNotEmpty)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: availableSubSkills.map((subSkill) {
                        final isSelected = selectedSubSkills.contains(subSkill.name.trim());
                        return FilterChip(
                          label: Text(subSkill.name),
                          selected: isSelected,
                          showCheckmark: isSelected,
                          selectedColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                          labelStyle: AppTextStyle.bodyMedium.copyWith(
                            color: isSelected ? AppColors.of(context).primary : AppColors.of(context).textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: BorderSide(color: isSelected ? AppColors.of(context).primary.withValues(alpha: 0.3) : AppColors.of(context).border),
                          ),
                          checkmarkColor: AppColors.of(context).primary,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedSubSkills.add(subSkill.name.trim());
                              } else {
                                selectedSubSkills.remove(subSkill.name.trim());
                              }
                            });
                          },
                        );
                      }).toList(),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).surface : AppColors.of(context).slate50,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).border : AppColors.of(context).slate200),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.noSubskillsConfigured,
                        style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary.withValues(alpha: 0.7)),
                      ),
                    ),
                ],
              ],
              onSave: () {
                if (skillController.text.isNotEmpty && isValidSkill) {
                  final data = {
                    "skill": skillController.text,
                    "proficiency": level,
                    "years_of_experience": exp,
                    if (selectedSubSkills.isNotEmpty)
                      "custom_sub_skill": selectedSubSkills.map((e) => {"sub_skill": e}).toList(),
                  };
                  context.read<ProfileBloc>().add(ProfileEvent.resumeRowUpsertRequested(section: "skills", rowDataJson: jsonEncode(data)));
                } else if (!isValidSkill) {
                  ToastUtils.showError(AppLocalizations.of(context)!.pleaseSelectASkillFromTheDropdownList);
                }
              },
              bloc: context.read<ProfileBloc>(),
            );
          },
        );
      },
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    final titleC = TextEditingController();
    final companyC = TextEditingController();
    final fromC = TextEditingController();
    final toC = TextEditingController();
    final summaryC = TextEditingController();
    String type = AppLocalizations.of(context)!.fullTime;
    bool currentlyWorking = false;

    bool isValidDesignation = false;

    // Replaced experience dialog with bottom sheet
    CommonFormBottomSheet.show(
      context: context,
      title: AppLocalizations.of(context)!.addWorkExperience,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(controller: companyC, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.company)),
                SizedBox(height: 12.h),
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        if (textEditingValue.text.isEmpty) return ProfileApiConstants.defaultDesignations;
                        final useCase = Get.find<SearchDesignationsUseCase>();
                        final result = await useCase(textEditingValue.text);
                        return result.fold((failure) => const Iterable<String>.empty(), (designations) => designations);
                      },
                      onSelected: (String selection) {
                        titleC.text = selection;
                        isValidDesignation = true;
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        controller.addListener(() {
                          titleC.text = controller.text;
                          isValidDesignation = false;
                        });
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.designation, suffixIcon: Icon(Icons.search, size: 20)),
                          validator: (val) => val == null || val.isEmpty ? AppLocalizations.of(context)!.designationCannotBeEmpty : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fromC,
                        readOnly: true,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.fromDate, suffixIcon: Icon(Icons.calendar_today, size: 20)),
                        onTap: () async {
                          final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now());
                          if (picked != null) {
                            setDialogState(() {
                              fromC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                            });
                          }
                        },
                      ),
                    ),
                    if (!currentlyWorking) ...[
                      SizedBox(width: 16.w),
                      Expanded(
                        child: TextFormField(
                          controller: toC,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.toDate,
                            suffixIcon: const Icon(Icons.calendar_today, size: 20),
                          ),
                          onTap: () async {
                            DateTime initial = DateTime.now();
                            if (fromC.text.isNotEmpty) {
                              try {
                                final parts = fromC.text.split('-');
                                final fromDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
                                if (initial.isBefore(fromDate)) initial = fromDate;
                              } catch (_) {}
                            }
                            final picked = await showDatePicker(context: context, initialDate: initial, firstDate: DateTime(1950), lastDate: DateTime.now());
                            if (picked != null) {
                              setDialogState(() {
                                toC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 8.h),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.currentlyWorkingHere),
                  value: currentlyWorking,
                  onChanged: (val) => setDialogState(() {
                    currentlyWorking = val ?? false;
                    if (currentlyWorking) toC.clear();
                  }),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: type,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.employmentType),
                  items: [AppLocalizations.of(context)!.fullTime, AppLocalizations.of(context)!.partTime, AppLocalizations.of(context)!.contract].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                  onChanged: (val) => setDialogState(() => type = val!),
                ),
                SizedBox(height: 12.h),
                TextField(controller: summaryC, maxLines: 4, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.assignmentSummary)),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (titleC.text.isNotEmpty && companyC.text.isNotEmpty) {
          String formatDate(String dateStr) {
            if (dateStr.isEmpty) return "";
            final parts = dateStr.split('-');
            if (parts.length == 3) return "${parts[2]}-${parts[1]}-${parts[0]}";
            return dateStr;
          }
          final data = {
            "designation": titleC.text,
            "company_name": companyC.text,
            "custom_from_date": formatDate(fromC.text),
            "custom_to_date": currentlyWorking ? "" : formatDate(toC.text),
            "custom_currently_working": currentlyWorking,
            "custom_assignment_summary": summaryC.text,
            "custom_employment_type": type,
          };
          context.read<ProfileBloc>().add(ProfileEvent.resumeRowUpsertRequested(section: "work_experience", rowDataJson: jsonEncode(data)));
        }
      },
      bloc: context.read<ProfileBloc>(),
    );
  }

  void _showAddProjectAssignmentDialog(BuildContext context) {
    final projectC = TextEditingController();
    final roleC = TextEditingController();
    final leadC = TextEditingController();
    final fromC = TextEditingController();
    final toC = TextEditingController();
    final allocationC = TextEditingController();
    String? reportTo;
    String status = ProfileApiConstants.statusActive;
    final formKey = GlobalKey<FormState>();

    String? requiredValidator(String? value) {
      if (value == null || value.trim().isEmpty) return AppLocalizations.of(context)!.requiredField;
      return null;
    }

    CommonFormBottomSheet.show(
      context: context,
      bloc: context.read<ProfileBloc>(),
      title: AppLocalizations.of(context)!.addProject,
      formKey: formKey,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            final useCase = Get.find<SearchProjectsUseCase>();
                            final result = await useCase(textEditingValue.text);
                            return result.fold(
                              (failure) => const Iterable<String>.empty(),
                              (projects) => projects,
                            );
                          },
                      onSelected: (String selection) {
                        projectC.text = selection;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            controller.addListener(() {
                              projectC.text = controller.text;
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.projectName,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.searchProject,
                                suffixIcon: Icon(Icons.search, size: 20),
                              ),
                              validator: requiredValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark
                                ? AppColors.of(context).surface
                                : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                                maxHeight: 200.h,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(
                                    index,
                                  );
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Text(
                                        option,
                                        style: AppTextStyle.bodyMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            final useCase =
                                Get.find<SearchDesignationsUseCase>();
                            final result = await useCase(textEditingValue.text);
                            return result.fold(
                              (failure) => const Iterable<String>.empty(),
                              (designations) => designations,
                            );
                          },
                      onSelected: (String selection) {
                        roleC.text = selection;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            controller.addListener(() {
                              roleC.text = controller.text;
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.roleLabel,
                                hintText: AppLocalizations.of(context)!.searchRole,
                                suffixIcon: const Icon(Icons.search, size: 20),
                              ),
                              validator: requiredValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark
                                ? AppColors.of(context).surface
                                : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                                maxHeight: 200.h,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(
                                    index,
                                  );
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Text(
                                        option,
                                        style: AppTextStyle.bodyMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Builder(
                  builder: (context) {
                    return Autocomplete<SearchEmployeeModel>(
                      displayStringForOption: (option) => option.label,
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            final useCase = Get.find<SearchEmployeesUseCase>();
                            final result = await useCase(textEditingValue.text);
                            return result.fold(
                              (failure) =>
                                  const Iterable<SearchEmployeeModel>.empty(),
                              (employees) => employees,
                            );
                          },
                      onSelected: (SearchEmployeeModel selection) {
                        leadC.text = selection.label;
                        reportTo = selection.value;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            controller.addListener(() {
                              leadC.text = controller.text;
                              if (controller.text.isEmpty) {
                                reportTo = null;
                              }
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.reportsTo,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.searchEmployee,
                                suffixIcon: const Icon(Icons.search, size: 20),
                              ),
                              validator: requiredValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark
                                ? AppColors.of(context).surface
                                : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                                maxHeight: 200.h,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final SearchEmployeeModel option = options
                                      .elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            child: const Icon(
                                              Icons.person,
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Text(
                                            option.label,
                                            style: AppTextStyle.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fromC,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.fromDate,
                          suffixIcon: Icon(Icons.calendar_today, size: 20),
                        ),
                        validator: requiredValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            fromC.text = picked.format(DateTimeUtils.patternDDMMYYYY);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextFormField(
                        controller: toC,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.toDate,
                          suffixIcon: Icon(Icons.calendar_today, size: 20),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            toC.text = picked.format(DateTimeUtils.patternDDMMYYYY);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: allocationC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.allocationPercentLabel,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.statusLabel,
                  ),
                  items: [
                    ProfileApiConstants.statusActive,
                    ProfileApiConstants.statusInactive,
                  ]
                      .map<DropdownMenuItem<String>>(
                        (val) => DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => status = val);
                  },
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          String formatDate(String dateStr) {
            if (dateStr.isEmpty) return "";
            final parts = dateStr.split('-');
            if (parts.length == 3) {
              return "${parts[2]}-${parts[1]}-${parts[0]}";
            }
            return dateStr;
          }

          final currentProfile = context.read<ProfileBloc>().state.profile;
          final assignments = currentProfile?.projectAssignments ?? <ProfileProjectAssignmentEntity>[];
          final currentList = List<ProfileProjectAssignmentEntity>.from(assignments);
          
          currentList.add(
            ProfileProjectAssignmentEntity(
              projectName: projectC.text,
              role: roleC.text,
              projectLead: leadC.text,
              reportTo: reportTo,
              startDate: formatDate(fromC.text),
              endDate: formatDate(toC.text),
              allocation: double.tryParse(allocationC.text) ?? 0.0,
              status: status,
            )
          );

          final jsonList = currentList.map((ProfileProjectAssignmentEntity e) => {
            "project_name": e.projectName,
            if (e.reportTo != null && e.reportTo!.isNotEmpty) "report_to": e.reportTo,
            if (e.projectLead != null && e.projectLead!.isNotEmpty) "report_to_name": e.projectLead,
            if (e.role != null && e.role!.isNotEmpty) "role": e.role,
            if (e.startDate != null && e.startDate!.isNotEmpty) "start_date": e.startDate,
            if (e.endDate != null && e.endDate!.isNotEmpty) "end_date": e.endDate,
            if (e.allocation != null) "allocation": e.allocation,
            if (e.status != null && e.status!.isNotEmpty) "status": e.status,
          }).toList();

          context.read<ProfileBloc>().add(
            ProfileEvent.projectAssignmentsUpdateRequested(
              assignmentsJson: jsonEncode(jsonList),
            ),
          );
        }
      },
    );
  }

  void _showAddProjectDialog(
    BuildContext context, {
    String? initialParentCompany,
    ResumeConsultingExperienceEntity? project,
  }) {
    final parentC = TextEditingController(text: project?.parentCompany ?? initialParentCompany);
    final clientC = TextEditingController(text: project?.clientName);
    final projectC = TextEditingController(text: project?.project);
    final fromC = TextEditingController(text: project?.fromDate);
    final toC = TextEditingController(text: project?.toDate);
    final overviewC = TextEditingController(text: project?.projectOverview);
    final impactC = TextEditingController(text: project?.businessImpact);
    final toolsC = TextEditingController(text: project?.toolsAndTechnologies);
    final formKey = GlobalKey<FormState>();

    String? requiredValidator(String? value) {
      if (value == null || value.trim().isEmpty) return AppLocalizations.of(context)!.requiredField;
      return null;
    }

    CommonFormBottomSheet.show(
      context: context,
      bloc: context.read<ProfileBloc>(),
      title: project != null 
          ? AppLocalizations.of(context)!.editKeyProject 
          : AppLocalizations.of(context)!.addConsultingProject,
      formKey: formKey,
      fields: [
        TextFormField(
          controller: clientC,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.clientName,
          ),
          validator: requiredValidator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: projectC,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.projectName,
          ),
          validator: requiredValidator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: fromC,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.fromDate,
                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                ),
                validator: requiredValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    fromC.text = DateTimeUtils.formatDate(picked, pattern: DateTimeUtils.patternDDMMYYYY);
                  }
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextFormField(
                controller: toC,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.toDate,
                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                ),
                validator: requiredValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    toC.text = DateTimeUtils.formatDate(picked, pattern: DateTimeUtils.patternDDMMYYYY);
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: toolsC,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.toolsAndTechnologiesOptional,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: overviewC,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.projectOverviewOptional,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: impactC,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.businessImpactOptional,
          ),
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            "parent_company": parentC.text,
            "client_name": clientC.text,
            "project": projectC.text,
            "from_date": fromC.text,
            "to_date": toC.text,
            "duration": DateTimeUtils.calculateDuration(fromC.text, toC.text),
            "project_overview": overviewC.text,
            "business_impact": impactC.text,
            "tools_and_technologies": toolsC.text,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: "consulting_experience",
              rowDataJson: jsonEncode(data),
              rowName: project?.name,
            ),
          );
        } else {
          ToastUtils.showError(
            AppLocalizations.of(context)!.pleaseFillAllMandatoryFields,
          );
        }
      },
    );
  }

  void _showAddLanguageDialog(BuildContext context) {
    final langC = TextEditingController();
    String speaking = AppLocalizations.of(context)!.basic;
    String reading = AppLocalizations.of(context)!.basic;
    String writing = AppLocalizations.of(context)!.basic;
    final formKey = GlobalKey<FormState>();

    final proficiencies = [
      AppLocalizations.of(context)!.basic,
      AppLocalizations.of(context)!.conversational,
      AppLocalizations.of(context)!.fluent,
      AppLocalizations.of(context)!.native,
    ];

    CommonFormBottomSheet.show(
      context: context,
      formKey: formKey,
      bloc: context.read<ProfileBloc>(),
      title: AppLocalizations.of(context)!.addLanguage,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder<List<String>>(
                  future: LanguageHelper.getLanguages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = List<String>.from(snapshot.data!);

                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return items;
                        }
                        return items.where((String option) {
                          return option.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                        });
                      },
                      onSelected: (String selection) {
                        langC.text = selection;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            if (langC.text.isNotEmpty && controller.text.isEmpty) {
                              controller.text = langC.text;
                            }
                            controller.addListener(() {
                              langC.text = controller.text;
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.language,
                                hintText: AppLocalizations.of(context)!.searchLanguage,
                                suffixIcon: const Icon(Icons.search, size: 20),
                              ),
                              validator: (val) => val == null || val.trim().isEmpty
                                  ? AppLocalizations.of(context)!.requiredField
                                  : null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark
                                ? AppColors.of(context).surface
                                : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                                maxHeight: 200.h,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(
                                    index,
                                  );
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Text(
                                        option,
                                        style: AppTextStyle.bodyMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  value: speaking,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.speakingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => speaking = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  value: reading,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.readingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => reading = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  value: writing,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.writingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => writing = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            ProfileApiConstants.keyLanguage: langC.text,
            ProfileApiConstants.keySpeaking: speaking,
            ProfileApiConstants.keyReading: reading,
            ProfileApiConstants.keyWriting: writing,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: "languages",
              rowDataJson: jsonEncode(data),
            ),
          );
        }
      },
    );
  }

  void _showAddCertificationDialog(BuildContext context) {
    final nameC = TextEditingController();
    final issuerC = TextEditingController();
    int currentYear = DateTime.now().year;
    String yearSelected = currentYear.toString();
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );
    final formKey = GlobalKey<FormState>();

    CommonFormBottomSheet.show(
      context: context,
      formKey: formKey,
      bloc: context.read<ProfileBloc>(),
      title: AppLocalizations.of(context)!.addCertification,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.certificationName,
                  ),
                  validator: (val) => val == null || val.trim().isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.issuerOrganization,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: yearSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfAcquisition,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => yearSelected = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            "certification_name": nameC.text,
            "issuing_institute": issuerC.text,
            "year_obtained": yearSelected,
            "certification_url": "",
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: "certifications",
              rowDataJson: jsonEncode(data),
            ),
          );
        }
      },
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    final degC = TextEditingController();
    final schoolC = TextEditingController();
    int currentYear = DateTime.now().year;
    String periodSelected = currentYear.toString();
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );

    String level = "Graduate";
    final levels = ProfileApiConstants.educationLevels;
    final formKey = GlobalKey<FormState>();

    CommonFormBottomSheet.show(
      context: context,
      formKey: formKey,
      bloc: context.read<ProfileBloc>(),
      title: AppLocalizations.of(context)!.addEducation,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.qualificationLevel,
                  ),
                  items: levels.map((val) {
                    String label = val;
                    if (val == "High School / Secondary") {
                      label = AppLocalizations.of(context)!.eduHighSchool;
                    } else if (val == "Diploma") {
                      label = AppLocalizations.of(context)!.eduDiploma;
                    } else if (val == "Under Graduate") {
                      label = AppLocalizations.of(context)!.eduUnderGraduate;
                    } else if (val == "Graduate") {
                      label = AppLocalizations.of(context)!.eduGraduate;
                    } else if (val == "Post Graduate") {
                      label = AppLocalizations.of(context)!.eduPostGraduate;
                    } else if (val == "Doctorate / PhD") {
                      label = AppLocalizations.of(context)!.eduDoctorate;
                    } else if (val == "Professional Certification") {
                      label = AppLocalizations.of(context)!.eduProfessionalCert;
                    } else if (val == "Other") {
                      label = AppLocalizations.of(context)!.eduOther;
                    }

                    return DropdownMenuItem(value: val, child: Text(label));
                  }).toList(),
                  onChanged: (val) => setDialogState(() => level = val!),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: degC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.degreeCourse,
                  ),
                  validator: (val) => val == null || val.trim().isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: schoolC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.schoolUniversity,
                  ),
                  validator: (val) => val == null || val.trim().isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfPassing,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) =>
                      setDialogState(() => periodSelected = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            ProfileApiConstants.keyQualification: degC.text,
            ProfileApiConstants.keySchoolUniv: schoolC.text,
            ProfileApiConstants.keyYearOfPassing: periodSelected,
            ProfileApiConstants.keyLevel: level,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: "education",
              rowDataJson: jsonEncode(data),
            ),
          );
        }
      },
    );
  }
}
