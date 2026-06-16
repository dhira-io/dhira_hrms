import json
import re
import glob

missing_strings = [
    'Save Profile',
    'Expert',
    'Beginner',
    'Intermediate',
    'Accessibility & UX',
    'Agentic AI',
    'Analytics',
    'Animation & Game Loops',
    'Backend Development',
    'Cloud Computing',
    'Data Transformation & Modeling',
    'Frontend Development',
    'Machine Learning',
    'Mobile Development',
    'Skill cannot be empty',
    'Please select a valid skill from the list',
    'Please select a valid designation',
    'Please select a valid project'
]

def to_camel_case(text):
    text = re.sub(r'[^a-zA-Z0-9 ]', '', text)
    parts = text.split()
    if not parts: return 'empty'
    return parts[0].lower() + ''.join(p.capitalize() for p in parts[1:])

string_to_key = {s: to_camel_case(s) for s in missing_strings}

for arb_file in ['lib/l10n/app_en.arb', 'lib/l10n/app_hi.arb']:
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for s, k in string_to_key.items():
        if k not in data:
            data[k] = s
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

print('Updated ARB files.')

files = glob.glob('lib/features/profile/presentation/widgets/**/*.dart', recursive=True)
files.extend(glob.glob('lib/features/profile/presentation/widgets/*.dart'))
files = list(set(files))

for fpath in files:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    modified = False
    for s, k in string_to_key.items():
        escaped_s = re.escape(s)
        # Using negative lookbehind/lookahead to prevent partial matches if any
        if re.search(f'"{escaped_s}"', content) or re.search(f"'{escaped_s}'", content):
            content = re.sub(f'"{escaped_s}"', f'AppLocalizations.of(context)!.{k}', content)
            content = re.sub(f"'{escaped_s}'", f'AppLocalizations.of(context)!.{k}', content)
            modified = True
            
    if modified:
        # Check for import
        import_statement = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';"
        if 'app_localizations.dart' not in content:
            content = re.sub(r'(import .*?;)', r'\1\n' + import_statement, content, count=1)
        
        # Remove const around Text/SnackBar/InputDecoration
        content = content.replace('const Text(', 'Text(')
        content = content.replace('const SnackBar(', 'SnackBar(')
        content = content.replace('const InputDecoration(', 'InputDecoration(')

        with open(fpath, 'w', encoding='utf-8') as f:
            f.write(content)

print('Replaced strings in files.')
