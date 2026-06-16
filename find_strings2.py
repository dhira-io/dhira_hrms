import re

for f in ['lib/features/profile/presentation/widgets/profile_contact_tab.dart',
          'lib/features/profile/presentation/widgets/profile_header.dart',
          'lib/features/profile/presentation/widgets/profile_overview_tab.dart']:
    print('--- ' + f + ' ---')
    with open(f, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    for i, line in enumerate(lines):
        if re.search(r'Text\([\"\'].*?[\"\']\)', line) or re.search(r'label:\s*[\"\'].*?[\"\']', line) or re.search(r'labelText:\s*[\"\'].*?[\"\']', line) or re.search(r'title:\s*[\"\'].*?[\"\']', line) or re.search(r'hintText:\s*[\"\'].*?[\"\']', line):
            print(str(i+1) + ': ' + line.strip())
