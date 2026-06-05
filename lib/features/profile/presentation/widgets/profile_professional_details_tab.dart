import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'dart:convert';
import '../../../../../l10n/app_localizations.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../bloc/profile_event.dart';
import 'professional/collapsible_card.dart';
import 'professional/skills_content.dart';
import 'professional/experience_content.dart';
import 'professional/projects_content.dart';
import 'professional/languages_content.dart';
import 'professional/certifications_content.dart';
import 'professional/education_content.dart';
import 'professional/professional_summary_content.dart';
import 'professional/common_form_dialog.dart';
import '../../domain/usecases/search_skills_usecase.dart';
import '../../domain/usecases/search_designations_usecase.dart';
import '../../domain/usecases/get_sub_skills_usecase.dart';
import '../../domain/entities/resume_entity.dart';

class ProfileProfessionalDetailsTab extends StatefulWidget {
  const ProfileProfessionalDetailsTab({super.key});

  @override
  State<ProfileProfessionalDetailsTab> createState() =>
      _ProfileProfessionalDetailsTabState();
}

class _ProfileProfessionalDetailsTabState extends State<ProfileProfessionalDetailsTab> {
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
      _summaryController = TextEditingController(text: resume.professionalSummary);
      _awardsController = TextEditingController(text: resume.awardsAndAchievements);
      _isControllersInitialized = true;
    }
  }

  int _calculateResumeCompletion(resume) {
    int score = 0;
    int total = 7;
    if (resume.professionalSummary.isNotEmpty) score++;
    if (resume.skills.isNotEmpty) score++;
    if (resume.workExperience.isNotEmpty) score++;
    if (resume.consultingExperience.isNotEmpty) score++;
    if (resume.languages.isNotEmpty) score++;
    if (resume.certifications.isNotEmpty) score++;
    if (resume.education.isNotEmpty) score++;
    return ((score / total) * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (profile, resume) {
            if (resume == null) {
              return const Center(child: CircularProgressIndicator());
            }
            
            _initControllers(resume);
            final completionPercent = _calculateResumeCompletion(resume);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Resume",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : const Color(0xFF1E293B),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 60.w * (completionPercent / 100),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6366F1), // Indigo/Purple
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "$completionPercent%",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[300]
                                  : const Color(0xFF475569),
                            ),
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
                              _isAnyExpanded ? Icons.unfold_less : Icons.unfold_more,
                              size: 16.sp,
                            ),
                            label: Text(_isAnyExpanded ? "Retract All" : "Expand All"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[300]
                                  : const Color(0xFF334155),
                              side: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[700]!
                                    : Colors.grey[300]!,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // 2. Professional Summary
                  CollapsibleCard(
                    title: "Professional Summary",
                    icon: Icons.person_outline,
                    isExpanded: _isSummaryExpanded,
                    onToggle: () => setState(() => _isSummaryExpanded = !_isSummaryExpanded),
                    child: ProfessionalSummaryContent(
                      summaryController: _summaryController,
                      awardsController: _awardsController,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // 3. Skills Card
                  CollapsibleCard(
                    title: l10n.skillsSubskills,
                    icon: Icons.star_outline,
                    isExpanded: _isSkillsExpanded,
                    onToggle: () => setState(() => _isSkillsExpanded = !_isSkillsExpanded),
                    action: HeaderActionButton(
                      label: l10n.addSkill,
                      onPressed: () => _showAddSkillDialog(context),
                    ),
                    child: SkillsContent(skills: resume.skills),
                  ),
                  SizedBox(height: 12.h),

                  // 3. Work Experience Card
                  CollapsibleCard(
                    title: l10n.workExperience,
                    icon: Icons.work_outline,
                    isExpanded: _isExperienceExpanded,
                    onToggle: () => setState(() => _isExperienceExpanded = !_isExperienceExpanded),
                    action: HeaderActionButton(
                      label: l10n.addExperience,
                      onPressed: () => _showAddExperienceDialog(context),
                    ),
                    child: ExperienceContent(experiences: resume.workExperience),
                  ),
                  SizedBox(height: 12.h),

                  // 4. Project Assignments Card
                  CollapsibleCard(
                    title: l10n.projectAssignments,
                    icon: Icons.assignment_outlined,
                    isExpanded: _isProjectsExpanded,
                    onToggle: () => setState(() => _isProjectsExpanded = !_isProjectsExpanded),
                    action: HeaderActionButton(
                      label: l10n.add,
                      onPressed: () => _showAddProjectDialog(context),
                    ),
                    child: ProjectsContent(projects: resume.consultingExperience),
                  ),
                  SizedBox(height: 12.h),

                  // 5. Languages Card
                  CollapsibleCard(
                    title: l10n.languages,
                    icon: Icons.language_outlined,
                    isExpanded: _isLanguagesExpanded,
                    onToggle: () => setState(() => _isLanguagesExpanded = !_isLanguagesExpanded),
                    action: HeaderActionButton(
                      label: l10n.add,
                      onPressed: () => _showAddLanguageDialog(context),
                    ),
                    child: LanguagesContent(languages: resume.languages),
                  ),
                  SizedBox(height: 12.h),

                  // 6. Certifications Card
                  CollapsibleCard(
                    title: l10n.certifications,
                    icon: Icons.verified_outlined,
                    isExpanded: _isCertificationsExpanded,
                    onToggle: () => setState(() => _isCertificationsExpanded = !_isCertificationsExpanded),
                    action: HeaderActionButton(
                      label: l10n.add,
                      onPressed: () => _showAddCertificationDialog(context),
                    ),
                    child: CertificationsContent(certifications: resume.certifications),
                  ),
                  SizedBox(height: 12.h),

                  // 7. Education Card
                  CollapsibleCard(
                    title: l10n.education,
                    icon: Icons.school_outlined,
                    isExpanded: _isEducationExpanded,
                    onToggle: () => setState(() => _isEducationExpanded = !_isEducationExpanded),
                    action: HeaderActionButton(
                      label: l10n.add,
                      onPressed: () => _showAddEducationDialog(context),
                    ),
                    child: EducationContent(education: resume.education),
                  ),
                  SizedBox(height: 32.h),

                  // Save Profile Button at the bottom
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                              ProfileEvent.resumeUpdateRequested(
                                resumeDataJson: jsonEncode({
                                  "professional_summary": _summaryController.text,
                                  "awards_and_achievements": _awardsController.text,
                                }),
                                subSkillsJson: "{}",
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile saved successfully!")),
                        );
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: Text(
                        "Save Profile",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB), // Blue color
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // --- Add Dialogs ---
  void _showAddSummaryDialog(BuildContext context) {
    final summaryC = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return CommonFormDialog(
          title: "Add Professional Summary",
          fields: [
            TextField(
              controller: summaryC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Professional Summary"),
            ),
          ],
          onSave: () {
            if (summaryC.text.isNotEmpty) {
              context.read<ProfileBloc>().add(
                    ProfileEvent.resumeUpdateRequested(
                      resumeDataJson: jsonEncode({"professional_summary": summaryC.text}),
                      subSkillsJson: "{}",
                    ),
                  );
              Navigator.pop(dialogContext);
            }
          },
        );
      },
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    final skillController = TextEditingController();
    String level = "Expert";
    String exp = "1.0";
    bool isValidSkill = false;
    List<SubSkillEntity> availableSubSkills = [];
    List<String> selectedSubSkills = [];
    bool isLoadingSubSkills = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add New Skill",
              fields: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        if (textEditingValue.text.isEmpty) {
                          return const [
                            "Accessibility & UX",
                            "Agentic AI",
                            "Analytics",
                            "Animation & Game Loops",
                            "Backend Development",
                            "Cloud Computing",
                            "Data Transformation & Modeling",
                            "Frontend Development",
                            "Machine Learning",
                            "Mobile Development"
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
                        skillController.text = selection;
                        isValidSkill = true;

                        setDialogState(() {
                          isLoadingSubSkills = true;
                          availableSubSkills = [];
                          selectedSubSkills = [];
                        });

                        final getSubSkills = Get.find<GetSubSkillsUseCase>();
                        final result = await getSubSkills(selection);

                        if (context.mounted) {
                          setDialogState(() {
                            isLoadingSubSkills = false;
                            result.fold(
                              (failure) => availableSubSkills = [],
                              (subSkills) => availableSubSkills = subSkills,
                            );
                          });
                        }
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
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth,
                                maxHeight: 200.h,
                              ),
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
                                      child: Text(
                                        option,
                                        style: AppTextStyle.bodyMedium.copyWith(
                                          color: AppColors.of(context).textPrimary,
                                        ),
                                      ),
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
                          skillController.text = controller.text;
                          isValidSkill = false; 
                        });
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: "Skill Name",
                            hintText: "Start typing to search skills...",
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) return "Skill cannot be empty";
                            if (!isValidSkill) return "Please select a valid skill from the list";
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 14.h),
                Text("Proficiency", style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary)),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: ["Beginner", "Intermediate", "Advanced", "Expert"].map((val) {
                    final isSelected = level == val;
                    return ChoiceChip(
                      label: Text(val),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) setDialogState(() => level = val);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 14.h),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: exp,
                  decoration: const InputDecoration(labelText: "Experience (Years)"),
                  items: ["1.0", "2.0", "3.0", "4.0", "5.0"]
                      .map((val) => DropdownMenuItem(value: val, child: Text("$val exp")))
                      .toList(),
                  onChanged: (val) => setDialogState(() => exp = val!),
                ),
                if (isLoadingSubSkills) ...[
                  SizedBox(height: 14.h),
                  const Center(child: CircularProgressIndicator()),
                ] else if (isValidSkill) ...[
                  SizedBox(height: 14.h),
                  Text("SUB SKILLS", style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary)),
                  SizedBox(height: 8.h),
                  if (availableSubSkills.isNotEmpty)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: availableSubSkills.map((subSkill) {
                        final isSelected = selectedSubSkills.contains(subSkill.name);
                        return FilterChip(
                          label: Text(subSkill.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            setDialogState(() {
                              if (selected) {
                                selectedSubSkills.add(subSkill.name);
                              } else {
                                selectedSubSkills.remove(subSkill.name);
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.of(context).surface
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.of(context).border
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        "No subskills configured.",
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.of(context).textSecondary.withOpacity(0.7),
                        ),
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
                    if (selectedSubSkills.isNotEmpty) "custom_sub_skill": selectedSubSkills.map((e) => {"sub_skill": e}).toList(),
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "skills",
                          rowDataJson: jsonEncode(data),
                        ),
                      );
                  Navigator.pop(dialogContext);
                } else if (!isValidSkill) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a skill from the dropdown list")),
                  );
                }
              },
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
    final respC = TextEditingController();
    final achC = TextEditingController();
    String type = "Full Time";
    bool currentlyWorking = false;

    bool isValidDesignation = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add Work Experience",
              fields: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: companyC,
                        decoration: const InputDecoration(labelText: "COMPANY NAME"),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Autocomplete<String>(
                            optionsBuilder: (TextEditingValue textEditingValue) async {
                              if (textEditingValue.text.isEmpty) {
                                return const [
                                  "Founder & CEO",
                                  "Software Developer",
                                  "Head of Solutions",
                                  "Data Engineer",
                                  "General Manager",
                                ];
                              }
                              final useCase = Get.find<SearchDesignationsUseCase>();
                              final result = await useCase(textEditingValue.text);
                              return result.fold(
                                (failure) => const Iterable<String>.empty(),
                                (designations) => designations,
                              );
                            },
                            onSelected: (String selection) {
                              titleC.text = selection;
                              isValidDesignation = true;
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
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth,
                                      maxHeight: 200.h,
                                    ),
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
                                            child: Text(
                                              option,
                                              style: AppTextStyle.bodyMedium.copyWith(
                                                color: AppColors.of(context).textPrimary,
                                              ),
                                            ),
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
                                titleC.text = controller.text;
                                isValidDesignation = false;
                              });
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: "Designation",
                                  suffixIcon: Icon(Icons.search, size: 20),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) return "Designation cannot be empty";
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fromC,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "FROM DATE",
                          suffixIcon: Icon(Icons.calendar_today, size: 20),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            fromC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: TextFormField(
                        controller: toC,
                        readOnly: true,
                        enabled: !currentlyWorking,
                        decoration: InputDecoration(
                          labelText: "To Date",
                          hintText: currentlyWorking ? "dd-mm-yyyy" : null,
                        ),
                        onTap: () async {
                          if (currentlyWorking) return;
                          DateTime initial = DateTime.now();
                          if (fromC.text.isNotEmpty) {
                            try {
                              final parts = fromC.text.split('-');
                              final fromDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
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
                            toC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                CheckboxListTile(
                  title: const Text("Currently Working Here"),
                  value: currentlyWorking,
                  onChanged: (val) {
                    setDialogState(() {
                      currentlyWorking = val ?? false;
                      if (currentlyWorking) toC.clear();
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(labelText: "Employment Type"),
                  items: ["Full Time", "Part Time", "Contract", "Internship"]
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => type = val!),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: summaryC,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: "Assignment Summary"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: respC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Responsibilities"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: achC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Achievements"),
                ),
              ],
              onSave: () {
                if (titleC.text.isNotEmpty && companyC.text.isNotEmpty) {
                  String formatDate(String dateStr) {
                    if (dateStr.isEmpty) return "";
                    final parts = dateStr.split('-');
                    if (parts.length == 3) {
                      return "${parts[2]}-${parts[1]}-${parts[0]}";
                    }
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
                    "custom_key_responsibilities": respC.text,
                    "custom_key_achievements": achC.text,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "work_experience",
                          rowDataJson: jsonEncode(data),
                        ),
                      );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    final parentC = TextEditingController();
    final clientC = TextEditingController();
    final projectC = TextEditingController();
    final fromC = TextEditingController();
    final toC = TextEditingController();
    final overviewC = TextEditingController();
    final impactC = TextEditingController();
    final toolsC = TextEditingController();
    final formKey = GlobalKey<FormState>();

    String? requiredValidator(String? value) {
      if (value == null || value.trim().isEmpty) return "Required field";
      return null;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add Consulting Project",
              formKey: formKey,
              fields: [
                TextFormField(
                  controller: projectC,
                  decoration: const InputDecoration(labelText: "Project Name"),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: clientC,
                  decoration: const InputDecoration(labelText: "Client Name"),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: parentC,
                  decoration: const InputDecoration(labelText: "Parent Company"),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: fromC,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "From Date",
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
                      fromC.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: toC,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "To Date",
                    suffixIcon: Icon(Icons.calendar_today, size: 20),
                  ),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () async {
                    DateTime initial = DateTime.now();
                    if (fromC.text.isNotEmpty) {
                      try {
                        final fromDate = DateTime.parse(fromC.text);
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
                      toC.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: overviewC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Project Overview"),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: impactC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Business Impact (Optional)"),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: toolsC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Tools & Technologies"),
                  validator: requiredValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    "duration": "", // Clear old duration field if necessary, or compute diff
                    "project_overview": overviewC.text,
                    "business_impact": impactC.text,
                    "tools_and_technologies": toolsC.text,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "consulting_experience",
                          rowDataJson: jsonEncode(data),
                        ),
                      );
                  Navigator.pop(dialogContext);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all mandatory fields")),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  void _showAddLanguageDialog(BuildContext context) {
    final langC = TextEditingController();
    String speaking = "Full Professional";
    String reading = "Full Professional";
    String writing = "Full Professional";
    
    final proficiencies = [
      "Native or Bilingual",
      "Full Professional",
      "Professional Working",
      "Conversational",
      "Elementary",
      "Basic"
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add Language",
              fields: [
                TextField(
                  controller: langC,
                  decoration: const InputDecoration(labelText: "Language"),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: speaking,
                  decoration: const InputDecoration(labelText: "Speaking Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => speaking = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: reading,
                  decoration: const InputDecoration(labelText: "Reading Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => reading = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: writing,
                  decoration: const InputDecoration(labelText: "Writing Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => writing = val!),
                ),
              ],
              onSave: () {
                if (langC.text.isNotEmpty) {
                  final data = {
                    "language": langC.text,
                    "speaking": speaking,
                    "reading": reading,
                    "writing": writing,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "languages",
                          rowDataJson: jsonEncode(data),
                        ),
                      );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }

  void _showAddCertificationDialog(BuildContext context) {
    final nameC = TextEditingController();
    final issuerC = TextEditingController();
    int currentYear = DateTime.now().year;
    String yearSelected = currentYear.toString();
    final years = List.generate(currentYear - 1949, (index) => (currentYear - index).toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add Certification",
              fields: [
                TextField(
                  controller: nameC,
                  decoration: const InputDecoration(labelText: "Certification Name"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: const InputDecoration(labelText: "Issuer / Organization"),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: yearSelected,
                  decoration: const InputDecoration(labelText: "Year of Acquisition"),
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (val) => setDialogState(() => yearSelected = val!),
                ),
              ],
              onSave: () {
                if (nameC.text.isNotEmpty) {
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
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    final degC = TextEditingController();
    final schoolC = TextEditingController();
    int currentYear = DateTime.now().year;
    String periodSelected = currentYear.toString();
    final years = List.generate(currentYear - 1949, (index) => (currentYear - index).toString());

    String level = "Graduate";
    final levels = [
      "High School / Secondary",
      "Diploma",
      "Under Graduate",
      "Graduate",
      "Post Graduate",
      "Doctorate / PhD",
      "Professional Certification",
      "Other"
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Add Education",
              fields: [
                TextField(
                  controller: degC,
                  decoration: const InputDecoration(labelText: "Degree / Course"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: const InputDecoration(labelText: "School / University"),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: const InputDecoration(labelText: "Year of Passing"),
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (val) => setDialogState(() => periodSelected = val!),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: const InputDecoration(labelText: "Level"),
                  items: levels.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                  onChanged: (val) => setDialogState(() => level = val!),
                ),
              ],
              onSave: () {
                if (degC.text.isNotEmpty && schoolC.text.isNotEmpty) {
                  final data = {
                    "qualification": degC.text,
                    "school_univ": schoolC.text,
                    "year_of_passing": periodSelected,
                    "level": level,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "education",
                          rowDataJson: jsonEncode(data),
                        ),
                      );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }
}
