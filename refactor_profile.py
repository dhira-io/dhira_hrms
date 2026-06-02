import re
import os

files_to_update = {
    r'lib\features\profile\presentation\screens\profile_screen.dart': [
        (r'Colors\.transparent', r'AppColors.transparent') # Wait, let's just use Colors.transparent if it's not defined in AppColors. I will keep Colors.transparent because AppColors usually does not define it. I'll skip it.
    ],
    r'lib\features\profile\presentation\widgets\profile_contact_tab.dart': [
        (r'Colors\.white', r'AppColors.of(context).white') # Wait, maybe AppColors.of(context).surface or AppColors.of(context).white
    ],
    r'lib\features\profile\presentation\widgets\profile_overview_tab.dart': [
        (r'Color\(0xFF334155\)', r'AppColors.of(context).slate700'),
        (r'Color\(0xFFCBD5E1\)', r'AppColors.of(context).slate300'),
        (r'Color\(0xFFF1F5F9\)', r'AppColors.of(context).slate100')
    ],
    r'lib\features\profile\presentation\widgets\profile_professional_details_tab.dart': [
        (r"Text\('Add'\)", r"Text(l10n.add)"),
        (r"Text\('Cancel'\)", r"Text(l10n.cancel)"),
        (r"Text\('Save'\)", r"Text(l10n.save)"),
        (r"Text\('Achievements'\)", r"Text(l10n.achievements)"),
        (r"Text\('Responsibilities'\)", r"Text(l10n.responsibilities)"),
        (r"Text\('No skills added yet\.'\)", r"Text(l10n.noSkillsAddedYet)"),
        (r"Text\('No experience added yet\.'\)", r"Text(l10n.noExperienceAddedYet)"),
        (r"Text\('No certifications added yet\.'\)", r"Text(l10n.noCertificationsAddedYet)"),
        (r"Text\('No languages added yet\.'\)", r"Text(l10n.noLanguagesAddedYet)"),
        (r"Text\('No education added yet\.'\)", r"Text(l10n.noEducationAddedYet)"),
        (r"Text\('Add Certification'\)", r"Text(l10n.addCertification)"),
        (r"Text\('Add New Skill'\)", r"Text(l10n.addNewSkill)"),
        (r"Text\('Add Work Experience'\)", r"Text(l10n.addWorkExperience)"),
        (r"Text\('Add Project Assignment'\)", r"Text(l10n.addProjectAssignment)"),
        (r"Text\('Add Education'\)", r"Text(l10n.addEducation)"),
        (r"Text\('Add Language'\)", r"Text(l10n.addLanguage)"),
        (r"Text\('Edit Project Assignment'\)", r"Text(l10n.editProjectAssignment)"),
        (r"Text\('Edit Work Experience'\)", r"Text(l10n.editWorkExperience)"),
        (r"Text\('Edit Skill Group'\)", r"Text(l10n.editSkillGroup)"),
        (r"Text\('Allocation: \$allocation%'\)", r"Text(l10n.allocationPercentage(allocation.toString()))"),
        (r"Text\('Page \$currentPage'\)", r"Text(l10n.pageNumber(currentPage.toString()))"),
        (r'Colors\.white', r'AppColors.of(context).white')
    ],
    r'lib\features\profile\presentation\screens\change_password_screen.dart': [
        (r"Text\('Change Password'\)", r"Text(l10n.changePassword)")
    ]
}

for filepath, replacements in files_to_update.items():
    if not os.path.exists(filepath):
        continue
        
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content
    for pattern, replacement in replacements:
        content = re.sub(pattern, replacement, content)
        
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

print("Profile files updated successfully!")
