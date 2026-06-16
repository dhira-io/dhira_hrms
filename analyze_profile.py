import os
import re

pres_dir = 'lib/features/profile/presentation'

issues = {
  'TextStyle': [],
  'Color': [],
  'ScaffoldMessenger': [],
  'Get.find': [],
  'CircularProgressIndicator': [],
  'Hardcoded Strings in Text': [],
  'initState': [],
  'DateFormat': [],
  'Missing ScreenUtil': [],
  'Widget _build': []
}

for root, _, files in os.walk(pres_dir):
    for f in files:
        if f.endswith('.dart'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                lines = file.readlines()
                
                for i, line in enumerate(lines):
                    line_num = i + 1
                    content = line.strip()
                    
                    if 'TextStyle(' in content and 'AppTextStyle' not in content:
                        issues['TextStyle'].append(f'{f}:{line_num}')
                    if 'Color(' in content and 'AppColors' not in content and 'fromColors' not in content:
                        issues['Color'].append(f'{f}:{line_num}')
                    if 'ScaffoldMessenger' in content:
                        issues['ScaffoldMessenger'].append(f'{f}:{line_num}')
                    if 'Get.find' in content:
                        issues['Get.find'].append(f'{f}:{line_num}')
                    if 'CircularProgressIndicator' in content:
                        issues['CircularProgressIndicator'].append(f'{f}:{line_num}')
                    if re.search(r"Text\(\s*['\"].*?['\"]\s*\)", content):
                        issues['Hardcoded Strings in Text'].append(f'{f}:{line_num}')
                    if 'void initState()' in content:
                        issues['initState'].append(f'{f}:{line_num}')
                    if 'DateFormat(' in content and 'DateTimeUtils' not in content:
                        issues['DateFormat'].append(f'{f}:{line_num}')
                    if re.search(r'(height|width):\s*\d+\.?[0-9]*(?![\.hwsp])[,)]', content):
                        issues['Missing ScreenUtil'].append(f'{f}:{line_num}')
                    if 'Widget _' in content and 'build' in content.lower():
                        issues['Widget _build'].append(f'{f}:{line_num}')

for k, v in issues.items():
    print(f'{k}: {len(v)} occurrences')
    if len(v) > 0 and len(v) <= 15:
        print('  ' + ', '.join(v))
