for f in ['lib/features/profile/presentation/widgets/profile_professional_details_tab.dart',
          'lib/features/profile/presentation/widgets/profile_contact_tab.dart',
          'lib/features/profile/presentation/widgets/profile_header.dart',
          'lib/features/profile/presentation/widgets/profile_overview_tab.dart']:
    print('--- ' + f + ' ---')
    with open(f, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    for i, line in enumerate(lines):
        if 'Text("' in line or 'Text(\'' in line or 'labelText: "' in line or 'title: "' in line or 'hintText: "' in line:
            print(str(i+1) + ': ' + line.strip())
