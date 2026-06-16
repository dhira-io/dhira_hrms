import json
import re
import glob

strings_to_add = [
    'Search Location...', 'Search Country Code...',
    'No certifications added yet.', 'Edit Certification',
    'Certification Name', 'Issuer / Organization', 'Year of Acquisition',
    'No education added yet.', 'Edit Education', 'Degree / Course'
]

def to_camel_case(text):
    text = re.sub(r'[^a-zA-Z0-9 ]', '', text)
    parts = text.split()
    if not parts: return 'empty'
    return parts[0].lower() + ''.join(p.capitalize() for p in parts[1:])

string_to_key = {s: to_camel_case(s) for s in strings_to_add}

for arb_file in ['lib/l10n/app_en.arb', 'lib/l10n/app_hi.arb']:
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for s, k in string_to_key.items():
        if k not in data:
            data[k] = s
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

files = glob.glob('lib/features/profile/presentation/widgets/**/*.dart', recursive=True)

for fpath in files:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    modified = False
    
    for s, k in string_to_key.items():
        escaped_s = re.escape(s)
        if re.search(f'"{escaped_s}"', content) or re.search(f"'{escaped_s}'", content):
            content = re.sub(f'"{escaped_s}"', f'AppLocalizations.of(context)!.{k}', content)
            content = re.sub(f"'{escaped_s}'", f'AppLocalizations.of(context)!.{k}', content)
            modified = True
            
    if modified:
        # Check for import based on depth
        depth = fpath.count('/') - fpath.count('lib/features/profile/presentation/widgets/')
        import_path = '../' * (depth + 1) + '../../l10n/app_localizations.dart'
        if import_path.startswith('../../../../../../'):
            import_path = '../../../../../l10n/app_localizations.dart'
        
        # It's safer to just import package:dhira_hrms/l10n/app_localizations.dart
        import_statement = "import 'package:dhira_hrms/l10n/app_localizations.dart';"
        if 'app_localizations.dart' not in content:
            content = re.sub(r'(import .*?;)', r'\1\n' + import_statement, content, count=1)
        
        content = content.replace('const Text(', 'Text(')
        content = content.replace('const SnackBar(', 'SnackBar(')
        content = content.replace('const InputDecoration(', 'InputDecoration(')

        with open(fpath, 'w', encoding='utf-8') as f:
            f.write(content)

print('Done fixing remaining strings.')
