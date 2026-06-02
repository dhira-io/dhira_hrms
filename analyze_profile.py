import os
import re

pattern_hardcoded_text = re.compile(r"Text\s*\(\s*['\"](.*?)['\"]")
pattern_hardcoded_color = re.compile(r"(Color\s*\(\s*0x[0-9A-Fa-f]+\s*\)|Colors\.[a-z]+)")

profile_dir = os.path.join('lib', 'features', 'profile', 'presentation')
violations = {}

for root, dirs, files in os.walk(profile_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            texts = pattern_hardcoded_text.findall(content)
            colors = pattern_hardcoded_color.findall(content)
            
            if texts or colors:
                violations[filepath] = {
                    'texts': list(set(texts)),
                    'colors': list(set(colors))
                }

with open('profile_violations.txt', 'w', encoding='utf-8') as f:
    for k, v in violations.items():
        f.write(k + '\n')
        if v['texts']: f.write('  Texts: ' + str(v['texts']) + '\n')
        if v['colors']: f.write('  Colors: ' + str(v['colors']) + '\n')
