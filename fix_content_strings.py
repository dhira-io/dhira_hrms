import json
import re
import glob

strings_to_add = [
    'School / University', 'Year of Passing', 'Level',
    'No project assignments added yet.', 'Edit Project Assignment',
    'PROJECT NAME', 'Search project...', 'ROLE', 'Search role...',
    'PROJECT LEAD', 'Select project lead', 'START DATE', 'dd-mm-yyyy',
    'END DATE', 'ALLOCATION (%)', 'e.g. 80', 'STATUS',
    'Loading...', 'No experience added yet.', 'Edit Work Experience',
    'Job Title', 'Company', 'From Date (yyyy-mm-dd)', 'To Date (yyyy-mm-dd)',
    'Currently Working Here', 'Employment Type', 'Responsibilities',
    'Achievements', 'No languages added yet.', 'Edit Language',
    'Language', 'Speaking Proficiency', 'Reading Proficiency',
    'Writing Proficiency', 'PROFESSIONAL SUMMARY', 'AWARDS & ACHIEVEMENTS',
    'No consulting projects added yet.', 'Edit Project',
    'Search designation...', 'Search employee...', 'No skills added yet.',
    'Edit Skill', 'Skill Name', 'Proficiency', 'Experience (Years)',
    'SUB SKILLS', 'Allocation: ', 'Status: '
]

def to_camel_case(text):
    text = re.sub(r'[^a-zA-Z0-9 ]', '', text)
    parts = text.split()
    if not parts: return 'empty'
    return parts[0].lower() + ''.join(p.capitalize() for p in parts[1:])

string_to_key = {s: to_camel_case(s) for s in strings_to_add}

# Handle specific problematic keys
string_to_key['Allocation: '] = 'allocationLabel'
string_to_key['Status: '] = 'statusLabel'

for arb_file in ['lib/l10n/app_en.arb', 'lib/l10n/app_hi.arb']:
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for s, k in string_to_key.items():
        if k not in data:
            data[k] = s.strip(': ')
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

files = glob.glob('lib/features/profile/presentation/widgets/professional/*.dart')

for fpath in files:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    modified = False
    
    # Handle interpolations explicitly first
    if '"Allocation: ${proj.allocation}%"' in content:
        content = content.replace('"Allocation: ${proj.allocation}%"', '\"${AppLocalizations.of(context)!.allocationLabel}: ${proj.allocation}%\"')
        modified = True
    if '"Status: ${proj.status}"' in content:
        content = content.replace('"Status: ${proj.status}"', '\"${AppLocalizations.of(context)!.statusLabel}: ${proj.status}\"')
        modified = True
    
    for s, k in string_to_key.items():
        if s in ['Allocation: ', 'Status: ']: continue
        escaped_s = re.escape(s)
        # Search for exact quotes
        if re.search(f'"{escaped_s}"', content) or re.search(f"'{escaped_s}'", content):
            content = re.sub(f'"{escaped_s}"', f'AppLocalizations.of(context)!.{k}', content)
            content = re.sub(f"'{escaped_s}'", f'AppLocalizations.of(context)!.{k}', content)
            modified = True
            
    if modified:
        # Check for import
        import_statement = "import '../../../../../l10n/app_localizations.dart';"
        if 'app_localizations.dart' not in content:
            # Place after first import
            content = re.sub(r'(import .*?;)', r'\1\n' + import_statement, content, count=1)
        
        # Remove const decorators
        content = content.replace('const Text(', 'Text(')
        content = content.replace('const SnackBar(', 'SnackBar(')
        content = content.replace('const InputDecoration(', 'InputDecoration(')
        content = content.replace('const _SectionHeader(', '_SectionHeader(')

        with open(fpath, 'w', encoding='utf-8') as f:
            f.write(content)

print('Done fixing all content files.')
