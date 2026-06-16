import os
import glob
import re

directory = 'lib/features/profile'
dart_files = glob.glob(f'{directory}/**/*.dart', recursive=True)

patterns = [
    r'Text\(\s*[\"\'][A-Za-z]',
    r'labelText:\s*[\"\'][A-Za-z]',
    r'hintText:\s*[\"\'][A-Za-z]',
    r'title:\s*[\"\'][A-Za-z]'
]

found = False
for fpath in dart_files:
    with open(fpath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            # Exclude lines that are comments
            if line.strip().startswith('//'):
                continue
            for pattern in patterns:
                if re.search(pattern, line):
                    print(f'{fpath}:{i+1} -> {line.strip()}')
                    found = True
                    break

if not found:
    print('No hardcoded strings found in Text, labelText, hintText, title!')
