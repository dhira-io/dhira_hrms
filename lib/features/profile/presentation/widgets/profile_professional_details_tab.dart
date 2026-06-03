import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

// Model Classes for Stateful CRUD operations
class SkillItem {
  String name;
  String level;
  String experience;
  List<String> subskills;

  SkillItem({
    required this.name,
    required this.level,
    required this.experience,
    required this.subskills,
  });
}

class ExperienceItem {
  String id;
  String title;
  String company;
  String period;
  String type;
  String responsibilities;
  String achievements;

  ExperienceItem({
    required this.id,
    required this.title,
    required this.company,
    required this.period,
    required this.type,
    required this.responsibilities,
    required this.achievements,
  });
}

class ProjectAssignmentItem {
  String id;
  String name;
  String code;
  String role;
  String lead;
  String startDate;
  String endDate;
  int allocation;
  String status;

  ProjectAssignmentItem({
    required this.id,
    required this.name,
    required this.code,
    required this.role,
    required this.lead,
    required this.startDate,
    required this.endDate,
    required this.allocation,
    required this.status,
  });
}

class LanguageItem {
  String name;
  String proficiency;

  LanguageItem({required this.name, required this.proficiency});
}

class CertificationItem {
  String name;
  String issuer;
  String year;

  CertificationItem({
    required this.name,
    required this.issuer,
    required this.year,
  });
}

class EducationItem {
  String degree;
  String school;
  String period;

  EducationItem({
    required this.degree,
    required this.school,
    required this.period,
  });
}

class ProfileProfessionalDetailsTab extends StatefulWidget {
  const ProfileProfessionalDetailsTab({super.key});

  @override
  State<ProfileProfessionalDetailsTab> createState() =>
      _ProfileProfessionalDetailsTabState();
}

class _ProfileProfessionalDetailsTabState
    extends State<ProfileProfessionalDetailsTab> {
  // Collapsed/Expanded states
  bool _isResumeExpanded = true;
  bool _isSkillsExpanded = true;
  bool _isExperienceExpanded = true;
  bool _isProjectsExpanded = true;
  bool _isLanguagesExpanded = false;
  bool _isCertificationsExpanded = false;
  bool _isEducationExpanded = false;

  // Local State collections pre-populated with beautiful mock data matching the image
  final String _resumeFileName = "Sameeruddin..Shaik_Resume.pdf";
  final String _resumeLastUpdated = "Last updated: 18 May 2026";

  final List<SkillItem> _skills = [
    SkillItem(
      name: "UI/UX Design",
      level: "Expert",
      experience: "1y exp",
      subskills: [
        "UX Research",
        "Prototyping",
        "User Centered Design",
        "Product Design",
      ],
    ),
    SkillItem(
      name: "Figma",
      level: "Expert",
      experience: "4y exp",
      subskills: ["Components", "Auto Layout", "Variants"],
    ),
    SkillItem(
      name: "React",
      level: "Advanced",
      experience: "3y exp",
      subskills: ["Hooks", "Context API", "Redux"],
    ),
    SkillItem(
      name: "Tailwind CSS",
      level: "Advanced",
      experience: "2y exp",
      subskills: ["Responsive Design", "Custom Themes"],
    ),
    SkillItem(
      name: "Design Systems",
      level: "Intermediate",
      experience: "4y exp",
      subskills: ["Token Architecture", "Component Libraries", "Variants"],
    ),
  ];

  final List<ExperienceItem> _experiences = [
    ExperienceItem(
      id: "exp_1",
      title: "UI/UX Designer",
      company: "Microsoft",
      period: "Jan 2020 - Jan 2022",
      type: "Full Time",
      responsibilities:
          "Leading design for HRMS SaaS product. Created component libraries, design systems, and user research frameworks.",
      achievements:
          "Reduced onboarding time by 40% through redesigned UX flows. Launched 3 major product releases.",
    ),
    ExperienceItem(
      id: "exp_2",
      title: "Product Designer",
      company: "Wissen Technology",
      period: "Feb 2022 - Jan 2025",
      type: "Full Time",
      responsibilities:
          "Leading design for HRMS SaaS product. Created component libraries, design systems, and user research frameworks.",
      achievements:
          "Reduced onboarding time by 40% through redesigned UX flows. Launched 3 major product releases.",
    ),
  ];

  final List<ProjectAssignmentItem> _projects = [
    ProjectAssignmentItem(
      id: "proj_1",
      name: "HRMS",
      code: "PRJ-2025-001",
      role: "Lead Designer",
      lead: "Priyanshi jain",
      startDate: "15/01/2026",
      endDate: "Ongoing",
      allocation: 60,
      status: "Active",
    ),
    ProjectAssignmentItem(
      id: "proj_2",
      name: "MHM",
      code: "PRJ-2025-008",
      role: "Lead Designer",
      lead: "Priyanshi jain",
      startDate: "15/01/2026",
      endDate: "Dec 2025",
      allocation: 25,
      status: "Inactive",
    ),
    ProjectAssignmentItem(
      id: "proj_3",
      name: "Akashic",
      code: "PRJ-2025-003",
      role: "UX Consultant",
      lead: "Ravi Kumar",
      startDate: "15/01/2026",
      endDate: "Ongoing",
      allocation: 15,
      status: "Active",
    ),
  ];

  final List<LanguageItem> _languages = [
    LanguageItem(name: "English", proficiency: "Native or Bilingual"),
    LanguageItem(name: "Hindi", proficiency: "Professional Working"),
    LanguageItem(name: "Telugu", proficiency: "Full Professional"),
  ];

  final List<CertificationItem> _certifications = [
    CertificationItem(
      name: "AWS Certified Solutions Architect",
      issuer: "Amazon Web Services",
      year: "2025",
    ),
    CertificationItem(
      name: "Google UX Design Professional Certificate",
      issuer: "Google",
      year: "2024",
    ),
  ];

  final List<EducationItem> _education = [
    EducationItem(
      degree: "Master of Design in Interaction Design",
      school: "IDC School of Design, IIT Bombay",
      period: "2018 - 2020",
    ),
    EducationItem(
      degree: "Bachelor of Technology in Computer Science",
      school: "JNTU Hyderabad",
      period: "2014 - 2018",
    ),
  ];

  // Pagination parameters for projects table
  int _rowsPerPage = 10;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          // 1. Resume Card
          _CollapsibleCard(
            title: l10n.resumeLabel,
            icon: Icons.description_outlined,
            isExpanded: _isResumeExpanded,
            onToggle: () =>
                setState(() => _isResumeExpanded = !_isResumeExpanded),
            child: _ResumeContent(
              resumeFileName: _resumeFileName,
              resumeLastUpdated: _resumeLastUpdated,
              onDownload: () {},
              onReplace: () {},
            ),
          ),
          SizedBox(height: 12.h),

          // 2. Skills & Subskills Card
          _CollapsibleCard(
            title: l10n.skillsSubskills,
            icon: Icons.star_outline,
            isExpanded: _isSkillsExpanded,
            onToggle: () =>
                setState(() => _isSkillsExpanded = !_isSkillsExpanded),
            action: _HeaderActionButton(
              label: l10n.addSkill,
              onPressed: _showAddSkillDialog,
            ),
            child: _SkillsContent(
              skills: _skills,
              onEditSkill: _showEditSkillDialog,
              onDeleteSkill: (skill) => setState(() => _skills.remove(skill)),
            ),
          ),
          SizedBox(height: 12.h),

          // 3. Work Experience Card
          _CollapsibleCard(
            title: l10n.workExperience,
            icon: Icons.work_outline,
            isExpanded: _isExperienceExpanded,
            onToggle: () =>
                setState(() => _isExperienceExpanded = !_isExperienceExpanded),
            action: _HeaderActionButton(
              label: l10n.addExperience,
              onPressed: _showAddExperienceDialog,
            ),
            child: _ExperienceContent(
              experiences: _experiences,
              onEditExperience: _showEditExperienceDialog,
              onDeleteExperience: (exp) =>
                  setState(() => _experiences.remove(exp)),
            ),
          ),
          SizedBox(height: 12.h),

          // 4. Project Assignments Card
          _CollapsibleCard(
            title: l10n.projectAssignments,
            icon: Icons.assignment_outlined,
            isExpanded: _isProjectsExpanded,
            onToggle: () =>
                setState(() => _isProjectsExpanded = !_isProjectsExpanded),
            action: _HeaderActionButton(
              label: l10n.add,
              onPressed: _showAddProjectDialog,
            ),
            child: _ProjectsContent(
              projects: _projects,
              onEditProject: _showEditProjectDialog,
              onDeleteProject: (proj) => setState(() => _projects.remove(proj)),
              rowsPerPage: _rowsPerPage,
              currentPage: _currentPage,
              onRowsPerPageChanged: (val) {
                if (val != null) {
                  setState(() => _rowsPerPage = val);
                }
              },
              onPagePrev: _currentPage > 1
                  ? () => setState(() => _currentPage--)
                  : null,
              onPageNext: _currentPage < 10
                  ? () => setState(() => _currentPage++)
                  : null,
            ),
          ),
          SizedBox(height: 12.h),

          // 5. Languages Card
          _CollapsibleCard(
            title: l10n.languages,
            icon: Icons.language_outlined,
            isExpanded: _isLanguagesExpanded,
            onToggle: () =>
                setState(() => _isLanguagesExpanded = !_isLanguagesExpanded),
            action: _HeaderActionButton(
              label: l10n.add,
              onPressed: _showAddLanguageDialog,
            ),
            child: _LanguagesContent(
              languages: _languages,
              onDeleteLanguage: (lang) =>
                  setState(() => _languages.remove(lang)),
            ),
          ),
          SizedBox(height: 12.h),

          // 6. Certifications Card
          _CollapsibleCard(
            title: l10n.certifications,
            icon: Icons.verified_outlined,
            isExpanded: _isCertificationsExpanded,
            onToggle: () => setState(
              () => _isCertificationsExpanded = !_isCertificationsExpanded,
            ),
            action: _HeaderActionButton(
              label: l10n.add,
              onPressed: _showAddCertificationDialog,
            ),
            child: _CertificationsContent(
              certifications: _certifications,
              onDeleteCertification: (cert) =>
                  setState(() => _certifications.remove(cert)),
            ),
          ),
          SizedBox(height: 12.h),

          // 7. Education Card
          _CollapsibleCard(
            title: l10n.education,
            icon: Icons.school_outlined,
            isExpanded: _isEducationExpanded,
            onToggle: () =>
                setState(() => _isEducationExpanded = !_isEducationExpanded),
            action: _HeaderActionButton(
              label: l10n.add,
              onPressed: _showAddEducationDialog,
            ),
            child: _EducationContent(
              education: _education,
              onDeleteEducation: (edu) =>
                  setState(() => _education.remove(edu)),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // --- Stateful Dialog Actions (Add / Edit Skills) ---
  void _showAddSkillDialog() {
    final skillController = TextEditingController();
    final subskillsController = TextEditingController();
    String level = "Expert";
    String exp = "1y exp";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Add New Skill",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: skillController,
                      decoration: const InputDecoration(
                        labelText: "Skill Group Name (e.g. Figma)",
                      ),
                    ),
                    SizedBox(height: 14.h),
                    DropdownButtonFormField<String>(
                      initialValue: level,
                      decoration: const InputDecoration(labelText: "Level"),
                      items: ["Expert", "Advanced", "Intermediate", "Beginner"]
                          .map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          })
                          .toList(),
                      onChanged: (val) => setDialogState(() => level = val!),
                    ),
                    SizedBox(height: 14.h),
                    DropdownButtonFormField<String>(
                      initialValue: exp,
                      decoration: const InputDecoration(
                        labelText: "Experience",
                      ),
                      items: ["1y exp", "2y exp", "3y exp", "4y exp", "5y+ exp"]
                          .map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          })
                          .toList(),
                      onChanged: (val) => setDialogState(() => exp = val!),
                    ),
                    SizedBox(height: 14.h),
                    TextField(
                      controller: subskillsController,
                      decoration: const InputDecoration(
                        labelText: "Subskills (comma separated)",
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (skillController.text.isNotEmpty) {
                            final List<String> subs = subskillsController.text
                                .split(",")
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();
                            setState(() {
                              _skills.add(
                                SkillItem(
                                  name: skillController.text,
                                  level: level,
                                  experience: exp,
                                  subskills: subs,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditSkillDialog(SkillItem skill) {
    final skillController = TextEditingController(text: skill.name);
    final subskillsController = TextEditingController(
      text: skill.subskills.join(", "),
    );
    String level = skill.level;
    String exp = skill.experience;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Edit Skill Group",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: skillController,
                      decoration: const InputDecoration(
                        labelText: "Skill Group Name",
                      ),
                    ),
                    SizedBox(height: 14.h),
                    DropdownButtonFormField<String>(
                      initialValue: level,
                      decoration: const InputDecoration(labelText: "Level"),
                      items: ["Expert", "Advanced", "Intermediate", "Beginner"]
                          .map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          })
                          .toList(),
                      onChanged: (val) => setDialogState(() => level = val!),
                    ),
                    SizedBox(height: 14.h),
                    DropdownButtonFormField<String>(
                      initialValue: exp,
                      decoration: const InputDecoration(
                        labelText: "Experience",
                      ),
                      items: ["1y exp", "2y exp", "3y exp", "4y exp", "5y+ exp"]
                          .map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          })
                          .toList(),
                      onChanged: (val) => setDialogState(() => exp = val!),
                    ),
                    SizedBox(height: 14.h),
                    TextField(
                      controller: subskillsController,
                      decoration: const InputDecoration(
                        labelText: "Subskills (comma separated)",
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (skillController.text.isNotEmpty) {
                            final List<String> subs = subskillsController.text
                                .split(",")
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();
                            setState(() {
                              skill.name = skillController.text;
                              skill.level = level;
                              skill.experience = exp;
                              skill.subskills = subs;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- Stateful Dialog Actions (Add / Edit Experiences) ---
  void _showAddExperienceDialog() {
    final titleC = TextEditingController();
    final companyC = TextEditingController();
    final periodC = TextEditingController();
    final respC = TextEditingController();
    final achC = TextEditingController();
    String type = "Full Time";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Add Work Experience",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleC,
                      decoration: const InputDecoration(labelText: "Job Title"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: companyC,
                      decoration: const InputDecoration(labelText: "Company"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: periodC,
                      decoration: const InputDecoration(
                        labelText: "Period (e.g. Feb 2022 - Jan 2025)",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: const InputDecoration(
                        labelText: "Employment Type",
                      ),
                      items:
                          [
                            "Full Time",
                            "Part Time",
                            "Contract",
                            "Internship",
                          ].map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                      onChanged: (val) => setDialogState(() => type = val!),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: respC,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Responsibilities",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: achC,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Achievements",
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleC.text.isNotEmpty &&
                              companyC.text.isNotEmpty) {
                            setState(() {
                              _experiences.add(
                                ExperienceItem(
                                  id: DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                  title: titleC.text,
                                  company: companyC.text,
                                  period: periodC.text,
                                  type: type,
                                  responsibilities: respC.text,
                                  achievements: achC.text,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditExperienceDialog(ExperienceItem exp) {
    final titleC = TextEditingController(text: exp.title);
    final companyC = TextEditingController(text: exp.company);
    final periodC = TextEditingController(text: exp.period);
    final respC = TextEditingController(text: exp.responsibilities);
    final achC = TextEditingController(text: exp.achievements);
    String type = exp.type;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Edit Work Experience",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleC,
                      decoration: const InputDecoration(labelText: "Job Title"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: companyC,
                      decoration: const InputDecoration(labelText: "Company"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: periodC,
                      decoration: const InputDecoration(labelText: "Period"),
                    ),
                    SizedBox(height: 12.h),
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: const InputDecoration(
                        labelText: "Employment Type",
                      ),
                      items:
                          [
                            "Full Time",
                            "Part Time",
                            "Contract",
                            "Internship",
                          ].map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                      onChanged: (val) => setDialogState(() => type = val!),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: respC,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Responsibilities",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: achC,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Achievements",
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleC.text.isNotEmpty &&
                              companyC.text.isNotEmpty) {
                            setState(() {
                              exp.title = titleC.text;
                              exp.company = companyC.text;
                              exp.period = periodC.text;
                              exp.type = type;
                              exp.responsibilities = respC.text;
                              exp.achievements = achC.text;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- Stateful Dialog Actions (Add / Edit Project Assignments) ---
  void _showAddProjectDialog() {
    final nameC = TextEditingController();
    final codeC = TextEditingController();
    final roleC = TextEditingController();
    final leadC = TextEditingController();
    final startC = TextEditingController();
    final endC = TextEditingController();
    int allocation = 50;
    String status = "Active";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Add Project Assignment",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameC,
                      decoration: const InputDecoration(
                        labelText: "Project Name",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: codeC,
                      decoration: const InputDecoration(
                        labelText: "Project Code",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: roleC,
                      decoration: const InputDecoration(labelText: "Role"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: leadC,
                      decoration: const InputDecoration(
                        labelText: "Project Lead",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: startC,
                      decoration: const InputDecoration(
                        labelText: "Start Date (dd/mm/yyyy)",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: endC,
                      decoration: const InputDecoration(
                        labelText: "End Date / Ongoing",
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Text(
                          "Allocation: $allocation%",
                          style: AppTextStyle.bodySmall.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: allocation.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 20,
                            onChanged: (val) =>
                                setDialogState(() => allocation = val.round()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(labelText: "Status"),
                      items: ["Active", "Inactive"].map((val) {
                        return DropdownMenuItem(value: val, child: Text(val));
                      }).toList(),
                      onChanged: (val) => setDialogState(() => status = val!),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameC.text.isNotEmpty) {
                            setState(() {
                              _projects.add(
                                ProjectAssignmentItem(
                                  id: DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                  name: nameC.text,
                                  code: codeC.text,
                                  role: roleC.text,
                                  lead: leadC.text,
                                  startDate: startC.text,
                                  endDate: endC.text.isEmpty
                                      ? "Ongoing"
                                      : endC.text,
                                  allocation: allocation,
                                  status: status,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditProjectDialog(ProjectAssignmentItem proj) {
    final nameC = TextEditingController(text: proj.name);
    final codeC = TextEditingController(text: proj.code);
    final roleC = TextEditingController(text: proj.role);
    final leadC = TextEditingController(text: proj.lead);
    final startC = TextEditingController(text: proj.startDate);
    final endC = TextEditingController(text: proj.endDate);
    int allocation = proj.allocation;
    String status = proj.status;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Edit Project Assignment",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameC,
                      decoration: const InputDecoration(
                        labelText: "Project Name",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: codeC,
                      decoration: const InputDecoration(
                        labelText: "Project Code",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: roleC,
                      decoration: const InputDecoration(labelText: "Role"),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: leadC,
                      decoration: const InputDecoration(
                        labelText: "Project Lead",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: startC,
                      decoration: const InputDecoration(
                        labelText: "Start Date",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: endC,
                      decoration: const InputDecoration(labelText: "End Date"),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Text(
                          "Allocation: $allocation%",
                          style: AppTextStyle.bodySmall.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: allocation.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 20,
                            onChanged: (val) =>
                                setDialogState(() => allocation = val.round()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(labelText: "Status"),
                      items: ["Active", "Inactive"].map((val) {
                        return DropdownMenuItem(value: val, child: Text(val));
                      }).toList(),
                      onChanged: (val) => setDialogState(() => status = val!),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameC.text.isNotEmpty) {
                            setState(() {
                              proj.name = nameC.text;
                              proj.code = codeC.text;
                              proj.role = roleC.text;
                              proj.lead = leadC.text;
                              proj.startDate = startC.text;
                              proj.endDate = endC.text;
                              proj.allocation = allocation;
                              proj.status = status;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- Stateful Dialog Actions (Add Languages) ---
  void _showAddLanguageDialog() {
    final langC = TextEditingController();
    String prof = "Full Professional";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              title: Text(
                "Add Language",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: langC,
                      decoration: const InputDecoration(labelText: "Language"),
                    ),
                    SizedBox(height: 14.h),
                    DropdownButtonFormField<String>(
                      initialValue: prof,
                      decoration: const InputDecoration(
                        labelText: "Proficiency",
                      ),
                      items:
                          [
                            "Native or Bilingual",
                            "Full Professional",
                            "Professional Working",
                            "Conversational",
                            "Elementary",
                          ].map((val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                      onChanged: (val) => setDialogState(() => prof = val!),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? AppColors.of(context).slate600
                                : AppColors.of(context).slate300,
                          ),
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: isDark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.of(context).white
                                : AppColors.of(context).slate700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (langC.text.isNotEmpty) {
                            setState(() {
                              _languages.add(
                                LanguageItem(
                                  name: langC.text,
                                  proficiency: prof,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.of(context).primary,
                          foregroundColor: AppColors.of(context).white,
                          elevation: 0,
                          minimumSize: Size(0, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- Stateful Dialog Actions (Add Certifications) ---
  void _showAddCertificationDialog() {
    final nameC = TextEditingController();
    final issuerC = TextEditingController();
    final yearC = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
          titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
          title: Text(
            "Add Certification",
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameC,
                  decoration: const InputDecoration(
                    labelText: "Certification Name",
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: const InputDecoration(
                    labelText: "Issuer / Organization",
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: yearC,
                  decoration: const InputDecoration(
                    labelText: "Year of Acquisition",
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? AppColors.of(context).slate600
                            : AppColors.of(context).slate300,
                      ),
                      minimumSize: Size(0, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: isDark
                          ? AppColors.of(context).surface
                          : AppColors.of(context).white,
                    ),
                    child: Text(
                      "Cancel",
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.of(context).white
                            : AppColors.of(context).slate700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameC.text.isNotEmpty && issuerC.text.isNotEmpty) {
                        setState(() {
                          _certifications.add(
                            CertificationItem(
                              name: nameC.text,
                              issuer: issuerC.text,
                              year: yearC.text.isEmpty ? "2026" : yearC.text,
                            ),
                          );
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.of(context).primary,
                      foregroundColor: AppColors.of(context).white,
                      elevation: 0,
                      minimumSize: Size(0, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Add",
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- Stateful Dialog Actions (Add Education) ---
  void _showAddEducationDialog() {
    final degC = TextEditingController();
    final schoolC = TextEditingController();
    final periodC = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
          titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
          title: Text(
            "Add Education",
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: degC,
                  decoration: const InputDecoration(
                    labelText: "Degree / Course",
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: const InputDecoration(
                    labelText: "School / University",
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: periodC,
                  decoration: const InputDecoration(
                    labelText: "Period (e.g. 2018 - 2020)",
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? AppColors.of(context).slate600
                            : AppColors.of(context).slate300,
                      ),
                      minimumSize: Size(0, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: isDark
                          ? AppColors.of(context).surface
                          : AppColors.of(context).white,
                    ),
                    child: Text(
                      "Cancel",
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.of(context).white
                            : AppColors.of(context).slate700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (degC.text.isNotEmpty && schoolC.text.isNotEmpty) {
                        setState(() {
                          _education.add(
                            EducationItem(
                              degree: degC.text,
                              school: schoolC.text,
                              period: periodC.text,
                            ),
                          );
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.of(context).primary,
                      foregroundColor: AppColors.of(context).white,
                      elevation: 0,
                      minimumSize: Size(0, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Add",
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// _CollapsibleCard
// ---------------------------------------------------------------------------
class _CollapsibleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;
  final Widget? action;

  const _CollapsibleCard({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: 0.04),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header row
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(icon, size: 16.sp, color: colors.primary),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle.labelLarge.copyWith(
                        fontSize: 14.sp,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  if (action != null) ...[action!, SizedBox(width: 8.w)],
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20.sp,
                    color: colors.slate500,
                  ),
                ],
              ),
            ),
          ),
          // Divider + content when expanded
          if (isExpanded) ...[
            Divider(height: 1.h, thickness: 1, color: colors.border),
            Padding(padding: EdgeInsets.all(16.w), child: child),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _HeaderActionButton
// ---------------------------------------------------------------------------
class _HeaderActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _HeaderActionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
        ),
        child: Text(
          label,
          style: AppTextStyle.labelSmall.copyWith(
            fontSize: 11.sp,
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ResumeContent
// ---------------------------------------------------------------------------
class _ResumeContent extends StatelessWidget {
  final String resumeFileName;
  final String resumeLastUpdated;
  final VoidCallback onDownload;
  final VoidCallback onReplace;

  const _ResumeContent({
    required this.resumeFileName,
    required this.resumeLastUpdated,
    required this.onDownload,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row: PDF icon + file name/date
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: colors.errorBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.picture_as_pdf_outlined,
                size: 20.sp,
                color: colors.error,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resumeFileName,
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    resumeLastUpdated,
                    style: AppTextStyle.labelSmall.copyWith(
                      fontSize: 10.sp,
                      color: colors.slate500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Bottom row: action buttons
        Row(
          children: [
            _ResumeActionButton(
              label: l10n.downloadResume,
              icon: Icons.download_outlined,
              onPressed: onDownload,
              colors: colors,
            ),
            SizedBox(width: 10.w),
            _ResumeActionButton(
              label: l10n.replace,
              icon: Icons.upload_outlined,
              onPressed: onReplace,
              colors: colors,
            ),
          ],
        ),
      ],
    );
  }
}

class _ResumeActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final dynamic colors;

  const _ResumeActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: c.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: c.primary.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: c.primary),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 10.sp,
                color: c.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _SkillsContent
// ---------------------------------------------------------------------------
class _SkillsContent extends StatelessWidget {
  final List<SkillItem> skills;
  final void Function(SkillItem) onEditSkill;
  final void Function(SkillItem) onDeleteSkill;

  const _SkillsContent({
    required this.skills,
    required this.onEditSkill,
    required this.onDeleteSkill,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (skills.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No skills added yet.',
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return Column(
      children: skills
          .map(
            (skill) => _SkillRow(
              skill: skill,
              onEdit: onEditSkill,
              onDelete: onDeleteSkill,
            ),
          )
          .toList(),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final SkillItem skill;
  final void Function(SkillItem) onEdit;
  final void Function(SkillItem) onDelete;

  const _SkillRow({
    required this.skill,
    required this.onEdit,
    required this.onDelete,
  });

  Color _levelColor(String level, dynamic colors) {
    switch (level) {
      case 'Expert':
        return colors.success;
      case 'Advanced':
        return colors.primary;
      case 'Intermediate':
        return colors.warning;
      default:
        return colors.slate500;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final levelColor = _levelColor(skill.level, colors);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  skill.name,
                  style: AppTextStyle.labelLarge.copyWith(
                    fontSize: 13.sp,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  skill.level,
                  style: AppTextStyle.labelSmall.copyWith(
                    fontSize: 10.sp,
                    color: levelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                skill.experience,
                style: AppTextStyle.labelSmall.copyWith(
                  fontSize: 10.sp,
                  color: colors.slate500,
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: () => onEdit(skill),
                child: Icon(
                  Icons.edit_outlined,
                  size: 15.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: () => onDelete(skill),
                child: Icon(
                  Icons.delete_outline,
                  size: 15.sp,
                  color: colors.error,
                ),
              ),
            ],
          ),
          if (skill.subskills.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: skill.subskills
                  .map(
                    (sub) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.slate100,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: colors.border),
                      ),
                      child: Text(
                        sub,
                        style: AppTextStyle.labelSmall.copyWith(
                          fontSize: 10.sp,
                          color: colors.slate600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          SizedBox(height: 4.h),
          Divider(height: 1.h, thickness: 1, color: colors.border),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ExperienceContent
// ---------------------------------------------------------------------------
class _ExperienceContent extends StatelessWidget {
  final List<ExperienceItem> experiences;
  final void Function(ExperienceItem) onEditExperience;
  final void Function(ExperienceItem) onDeleteExperience;

  const _ExperienceContent({
    required this.experiences,
    required this.onEditExperience,
    required this.onDeleteExperience,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (experiences.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No experience added yet.',
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return Column(
      children: experiences
          .map(
            (exp) => _ExperienceRow(
              experience: exp,
              onEdit: onEditExperience,
              onDelete: onDeleteExperience,
            ),
          )
          .toList(),
    );
  }
}

class _ExperienceRow extends StatelessWidget {
  final ExperienceItem experience;
  final void Function(ExperienceItem) onEdit;
  final void Function(ExperienceItem) onDelete;

  const _ExperienceRow({
    required this.experience,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.business_outlined,
                  size: 18.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title,
                      style: AppTextStyle.labelLarge.copyWith(
                        fontSize: 13.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      experience.company,
                      style: AppTextStyle.bodySmall.copyWith(
                        fontSize: 12.sp,
                        color: colors.primary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            experience.period,
                            style: AppTextStyle.labelSmall.copyWith(
                              fontSize: 10.sp,
                              color: colors.slate500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.slate100,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            experience.type,
                            style: AppTextStyle.labelSmall.copyWith(
                              fontSize: 10.sp,
                              color: colors.slate600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onEdit(experience),
                child: Icon(
                  Icons.edit_outlined,
                  size: 15.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => onDelete(experience),
                child: Icon(
                  Icons.delete_outline,
                  size: 15.sp,
                  color: colors.error,
                ),
              ),
            ],
          ),
          if (experience.responsibilities.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              'Responsibilities',
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 10.sp,
                color: colors.slate500,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              experience.responsibilities,
              style: AppTextStyle.bodySmall.copyWith(
                fontSize: 11.sp,
                color: colors.textSecondary,
              ),
            ),
          ],
          if (experience.achievements.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              'Achievements',
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 10.sp,
                color: colors.slate500,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              experience.achievements,
              style: AppTextStyle.bodySmall.copyWith(
                fontSize: 11.sp,
                color: colors.textSecondary,
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Divider(height: 1.h, thickness: 1, color: colors.border),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ProjectsContent
// ---------------------------------------------------------------------------
class _ProjectsContent extends StatelessWidget {
  final List<ProjectAssignmentItem> projects;
  final void Function(ProjectAssignmentItem) onEditProject;
  final void Function(ProjectAssignmentItem) onDeleteProject;
  final int rowsPerPage;
  final int currentPage;
  final void Function(int?) onRowsPerPageChanged;
  final VoidCallback? onPagePrev;
  final VoidCallback? onPageNext;

  const _ProjectsContent({
    required this.projects,
    required this.onEditProject,
    required this.onDeleteProject,
    required this.rowsPerPage,
    required this.currentPage,
    required this.onRowsPerPageChanged,
    this.onPagePrev,
    this.onPageNext,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (projects.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            l10n.noProjectsAdded,
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project rows
        ...projects.map(
          (proj) => _ProjectRow(
            project: proj,
            onEdit: onEditProject,
            onDelete: onDeleteProject,
          ),
        ),
        SizedBox(height: 8.h),
        // Pagination row
        Row(
          children: [
            Text(
              'Rows:',
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 11.sp,
                color: colors.slate500,
              ),
            ),
            SizedBox(width: 6.w),
            DropdownButton<int>(
              value: rowsPerPage,
              isDense: true,
              underline: const SizedBox.shrink(),
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 11.sp,
                color: colors.textPrimary,
              ),
              items: [5, 10, 20]
                  .map((v) => DropdownMenuItem(value: v, child: Text('$v')))
                  .toList(),
              onChanged: onRowsPerPageChanged,
            ),
            const Spacer(),
            Text(
              'Page $currentPage',
              style: AppTextStyle.labelSmall.copyWith(
                fontSize: 11.sp,
                color: colors.slate500,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onPagePrev,
              child: Icon(
                Icons.chevron_left,
                size: 18.sp,
                color: onPagePrev != null ? colors.primary : colors.slate300,
              ),
            ),
            GestureDetector(
              onTap: onPageNext,
              child: Icon(
                Icons.chevron_right,
                size: 18.sp,
                color: onPageNext != null ? colors.primary : colors.slate300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final ProjectAssignmentItem project;
  final void Function(ProjectAssignmentItem) onEdit;
  final void Function(ProjectAssignmentItem) onDelete;

  const _ProjectRow({
    required this.project,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isActive = project.status == 'Active';
    final statusColor = isActive ? colors.success : colors.slate500;
    final statusBg = isActive ? colors.successBg : colors.slate100;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: AppTextStyle.labelLarge.copyWith(
                              fontSize: 13.sp,
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            project.status,
                            style: AppTextStyle.labelSmall.copyWith(
                              fontSize: 10.sp,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      project.code,
                      style: AppTextStyle.labelSmall.copyWith(
                        fontSize: 10.sp,
                        color: colors.slate400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _ProjChip(
                          label: 'Role: ${project.role}',
                          colors: colors,
                        ),
                        _ProjChip(
                          label: 'Lead: ${project.lead}',
                          colors: colors,
                        ),
                        _ProjChip(
                          label: '${project.allocation}% allocation',
                          colors: colors,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${project.startDate} → ${project.endDate}',
                      style: AppTextStyle.labelSmall.copyWith(
                        fontSize: 10.sp,
                        color: colors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => onEdit(project),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 15.sp,
                      color: colors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => onDelete(project),
                    child: Icon(
                      Icons.delete_outline,
                      size: 15.sp,
                      color: colors.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(height: 1.h, thickness: 1, color: colors.border),
        ],
      ),
    );
  }
}

class _ProjChip extends StatelessWidget {
  final String label;
  final dynamic colors;

  const _ProjChip({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: c.slate100,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: c.border),
      ),
      child: Text(
        label,
        style: AppTextStyle.labelSmall.copyWith(
          fontSize: 10.sp,
          color: c.slate600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _LanguagesContent
// ---------------------------------------------------------------------------
class _LanguagesContent extends StatelessWidget {
  final List<LanguageItem> languages;
  final void Function(LanguageItem) onDeleteLanguage;

  const _LanguagesContent({
    required this.languages,
    required this.onDeleteLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (languages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No languages added yet.',
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return Column(
      children: languages
          .map(
            (lang) => _LanguageRow(language: lang, onDelete: onDeleteLanguage),
          )
          .toList(),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  final LanguageItem language;
  final void Function(LanguageItem) onDelete;

  const _LanguageRow({required this.language, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: colors.infoBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.language_outlined,
              size: 16.sp,
              color: colors.info,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language.name,
                  style: AppTextStyle.labelLarge.copyWith(
                    fontSize: 13.sp,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  language.proficiency,
                  style: AppTextStyle.labelSmall.copyWith(
                    fontSize: 11.sp,
                    color: colors.slate500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onDelete(language),
            child: Icon(Icons.delete_outline, size: 15.sp, color: colors.error),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _CertificationsContent
// ---------------------------------------------------------------------------
class _CertificationsContent extends StatelessWidget {
  final List<CertificationItem> certifications;
  final void Function(CertificationItem) onDeleteCertification;

  const _CertificationsContent({
    required this.certifications,
    required this.onDeleteCertification,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (certifications.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No certifications added yet.',
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return Column(
      children: certifications
          .map(
            (cert) => _CertificationRow(
              certification: cert,
              onDelete: onDeleteCertification,
            ),
          )
          .toList(),
    );
  }
}

class _CertificationRow extends StatelessWidget {
  final CertificationItem certification;
  final void Function(CertificationItem) onDelete;

  const _CertificationRow({
    required this.certification,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: colors.warningBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              size: 18.sp,
              color: colors.warning,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certification.name,
                  style: AppTextStyle.labelLarge.copyWith(
                    fontSize: 12.sp,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  certification.issuer,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 11.sp,
                    color: colors.slate500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  certification.year,
                  style: AppTextStyle.labelSmall.copyWith(
                    fontSize: 10.sp,
                    color: colors.slate400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onDelete(certification),
            child: Icon(Icons.delete_outline, size: 15.sp, color: colors.error),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _EducationContent
// ---------------------------------------------------------------------------
class _EducationContent extends StatelessWidget {
  final List<EducationItem> education;
  final void Function(EducationItem) onDeleteEducation;

  const _EducationContent({
    required this.education,
    required this.onDeleteEducation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (education.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No education added yet.',
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.slate500,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return Column(
      children: education
          .map(
            (edu) => _EducationRow(education: edu, onDelete: onDeleteEducation),
          )
          .toList(),
    );
  }
}

class _EducationRow extends StatelessWidget {
  final EducationItem education;
  final void Function(EducationItem) onDelete;

  const _EducationRow({required this.education, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.school_outlined,
              size: 18.sp,
              color: colors.primary,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education.degree,
                  style: AppTextStyle.labelLarge.copyWith(
                    fontSize: 12.sp,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  education.school,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 11.sp,
                    color: colors.slate500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  education.period,
                  style: AppTextStyle.labelSmall.copyWith(
                    fontSize: 10.sp,
                    color: colors.slate400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onDelete(education),
            child: Icon(Icons.delete_outline, size: 15.sp, color: colors.error),
          ),
        ],
      ),
    );
  }
}
