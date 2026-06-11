import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../data/constants/profile_api_constants.dart';
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
import 'bottom_sheets/add_skill_bottom_sheet.dart';
import 'bottom_sheets/add_experience_bottom_sheet.dart';
import 'bottom_sheets/add_project_assignment_bottom_sheet.dart';
import 'bottom_sheets/add_project_bottom_sheet.dart';
import 'bottom_sheets/add_language_bottom_sheet.dart';
import 'bottom_sheets/add_certification_bottom_sheet.dart';
import 'bottom_sheets/add_education_bottom_sheet.dart';
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

  void _initControllers(ResumeEntity resume) {
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
          if (prevResume.workExperience.length !=
              currResume.workExperience.length)
            return true;
          if (prevResume.consultingExperience.length !=
              currResume.consultingExperience.length)
            return true;
          if (prevResume.languages.length != currResume.languages.length)
            return true;
          if (prevResume.certifications.length !=
              currResume.certifications.length)
            return true;
          if (prevResume.education.length != currResume.education.length)
            return true;
          if (prevResume.professionalSummary != currResume.professionalSummary)
            return true;
          if (prevResume.awardsAndAchievements !=
              currResume.awardsAndAchievements)
            return true;
          // Detect edits within items (compare json-encoded data by checking first item if same count)
          if (prevResume.skills != currResume.skills) return true;
          if (prevResume.workExperience != currResume.workExperience)
            return true;
          if (prevResume.languages != currResume.languages) return true;
          if (prevResume.certifications != currResume.certifications)
            return true;
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
          physics: const AlwaysScrollableScrollPhysics(),
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
                                        borderRadius: BorderRadius.circular(
                                          3.r,
                                        ),
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
                                  color:
                                      Theme.of(context).brightness ==
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
                      onPressed: () => showAddSkillDialog(context),
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
                  List<ResumeConsultingExperienceEntity>,
                )
              >(
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
                      onPressed: () => showAddExperienceDialog(context),
                    ),
                    child: ExperienceContent(
                      experiences: experiences,
                      consultingExperiences: consultingExperiences,
                      onAddKeyProject: (parentCompany) {
                        showAddProjectDialog(
                          context,
                          initialParentCompany: parentCompany,
                        );
                      },
                      onEditKeyProject: (project) {
                        showAddProjectDialog(context, project: project);
                      },
                      onDeleteKeyProject: (project) {
                        context.read<ProfileBloc>().add(
                          ProfileEvent.resumeRowDeleteRequested(
                            section:
                                ProfileApiConstants.sectionConsultingExperience,
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
                      () => _isProjectsExpanded = !_isProjectsExpanded,
                    ),
                    action: HeaderActionButton(
                      label: AppLocalizations.of(context)!.add,
                      onPressed: () => showAddProjectAssignmentDialog(context),
                    ),
                    child: EmployeeProjectAssignmentsContent(profile: profile),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 5. Languages Card
              BlocSelector<
                ProfileBloc,
                ProfileState,
                List<ResumeLanguageEntity>
              >(
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
                      onPressed: () => showAddLanguageDialog(context),
                    ),
                    child: LanguagesContent(languages: languages),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 6. Certifications Card
              BlocSelector<
                ProfileBloc,
                ProfileState,
                List<ResumeCertificationEntity>
              >(
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
                      onPressed: () => showAddCertificationDialog(context),
                    ),
                    child: CertificationsContent(
                      certifications: certifications,
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // 7. Education Card
              BlocSelector<
                ProfileBloc,
                ProfileState,
                List<ResumeEducationEntity>
              >(
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
                      onPressed: () => showAddEducationDialog(context),
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
                          resume: resume,
                          professionalSummary: _summaryController.text,
                          awardsAndAchievements: _awardsController.text,
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
}
