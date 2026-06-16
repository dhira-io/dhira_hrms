import json
import re
import os

# 1. Define the missing strings and generate camelCase keys
hardcoded_strings = [
    "Professional Summary",
    "Profile saved successfully!",
    "Add New Skill",
    "Skill Name",
    "Start typing to search skills...",
    "Proficiency",
    "Experience (Years)",
    "SUB SKILLS",
    "Please select a skill from the dropdown list",
    "Add Work Experience",
    "COMPANY NAME",
    "Designation",
    "FROM DATE",
    "To Date",
    "Currently Working Here",
    "Employment Type",
    "Assignment Summary",
    "Responsibilities",
    "Achievements",
    "Add Consulting Project",
    "Project Name",
    "Client Name",
    "Parent Company",
    "From Date",
    "Project Overview",
    "Business Impact (Optional)",
    "Tools & Technologies",
    "Please fill all mandatory fields",
    "Add Language",
    "Language",
    "Speaking Proficiency",
    "Reading Proficiency",
    "Writing Proficiency",
    "Add Certification",
    "Certification Name",
    "Issuer / Organization",
    "Year of Acquisition",
    "Add Education",
    "Degree / Course",
    "School / University",
    "Year of Passing",
    "Level",
    "Emergency Contact Name",
    "Nationality",
    "Current Location",
    "Profile",
    "Bandwidth"
]

def to_camel_case(text):
    text = re.sub(r'[^a-zA-Z0-9 ]', '', text)
    parts = text.split()
    if not parts: return "empty"
    return parts[0].lower() + ''.join(p.capitalize() for p in parts[1:])

string_to_key = {}
for s in hardcoded_strings:
    string_to_key[s] = to_camel_case(s)

# 2. Update ARB files
for arb_file in ['lib/l10n/app_en.arb', 'lib/l10n/app_hi.arb']:
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for s, k in string_to_key.items():
        if k not in data:
            data[k] = s
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

# 3. Replace in Dart files
files_to_update = [
    'lib/features/profile/presentation/widgets/profile_professional_details_tab.dart',
    'lib/features/profile/presentation/widgets/profile_contact_tab.dart',
    'lib/features/profile/presentation/widgets/profile_header.dart',
    'lib/features/profile/presentation/widgets/profile_overview_tab.dart'
]

for fpath in files_to_update:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # We need to make sure l10n is available. Usually it's final l10n = AppLocalizations.of(context)!;
    # Let's replace strings carefully.
    for s, k in string_to_key.items():
        # Escape for regex
        escaped_s = re.escape(s)
        # Replace "String" and 'String'
        content = re.sub(f'"{escaped_s}"', f'l10n.{k}', content)
        content = re.sub(f"'{escaped_s}'", f'l10n.{k}', content)
    
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Updated ARB files and replaced strings in dart files.")
