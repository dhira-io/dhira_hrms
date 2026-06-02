import json
import os

keys_en = {
    "achievements": "Achievements",
    "responsibilities": "Responsibilities",
    "noSkillsAddedYet": "No skills added yet.",
    "noExperienceAddedYet": "No experience added yet.",
    "noCertificationsAddedYet": "No certifications added yet.",
    "noLanguagesAddedYet": "No languages added yet.",
    "noEducationAddedYet": "No education added yet.",
    "addCertification": "Add Certification",
    "addNewSkill": "Add New Skill",
    "addWorkExperience": "Add Work Experience",
    "addProjectAssignment": "Add Project Assignment",
    "addEducation": "Add Education",
    "addLanguage": "Add Language",
    "editProjectAssignment": "Edit Project Assignment",
    "editWorkExperience": "Edit Work Experience",
    "editSkillGroup": "Edit Skill Group",
    "changePassword": "Change Password",
    "allocationPercentage": "Allocation: {allocation}%",
    "pageNumber": "Page {currentPage}"
}

# Add description for keys with parameters
meta_en = {
    "@allocationPercentage": {
        "placeholders": {
            "allocation": {
                "type": "String"
            }
        }
    },
    "@pageNumber": {
        "placeholders": {
            "currentPage": {
                "type": "String"
            }
        }
    }
}

# Hindi translations
keys_hi = {
    "achievements": "उपलब्धियां",
    "responsibilities": "जिम्मेदारियां",
    "noSkillsAddedYet": "अभी तक कोई कौशल नहीं जोड़ा गया है।",
    "noExperienceAddedYet": "अभी तक कोई अनुभव नहीं जोड़ा गया है।",
    "noCertificationsAddedYet": "अभी तक कोई प्रमाण पत्र नहीं जोड़ा गया है।",
    "noLanguagesAddedYet": "अभी तक कोई भाषा नहीं जोड़ी गई है।",
    "noEducationAddedYet": "अभी तक कोई शिक्षा नहीं जोड़ी गई है।",
    "addCertification": "प्रमाणन जोड़ें",
    "addNewSkill": "नया कौशल जोड़ें",
    "addWorkExperience": "कार्य अनुभव जोड़ें",
    "addProjectAssignment": "परियोजना असाइनमेंट जोड़ें",
    "addEducation": "शिक्षा जोड़ें",
    "addLanguage": "भाषा जोड़ें",
    "editProjectAssignment": "परियोजना असाइनमेंट संपादित करें",
    "editWorkExperience": "कार्य अनुभव संपादित करें",
    "editSkillGroup": "कौशल समूह संपादित करें",
    "changePassword": "पासवर्ड बदलें",
    "allocationPercentage": "आवंटन: {allocation}%",
    "pageNumber": "पृष्ठ {currentPage}"
}

def update_arb(filepath, new_keys, meta=None):
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # insert new keys before the closing brace effectively
    for k, v in new_keys.items():
        if k not in data:
            data[k] = v
            
    if meta:
        for k, v in meta.items():
            if k not in data:
                data[k] = v

    with open(filepath, 'w', encoding='utf-8') as f:
        # standard json formatting
        json.dump(data, f, ensure_ascii=False, indent=2)

update_arb('lib/l10n/app_en.arb', keys_en, meta_en)
update_arb('lib/l10n/app_hi.arb', keys_hi)

print("Localization files updated successfully!")
