import os

# Fix import in skills_content.dart
fpath_skills = 'lib/features/profile/presentation/widgets/professional/skills_content.dart'
if os.path.exists(fpath_skills):
    with open(fpath_skills, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace("import 'package:flutter_gen/gen_l10n/app_localizations.dart';", "import '../../../../../l10n/app_localizations.dart';")
    with open(fpath_skills, 'w', encoding='utf-8') as f:
        f.write(content)

# Fix const lists in profile_professional_details_tab.dart
fpath_prof = 'lib/features/profile/presentation/widgets/profile_professional_details_tab.dart'
if os.path.exists(fpath_prof):
    with open(fpath_prof, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace('final availableSkills = const [', 'final availableSkills = [')
    content = content.replace('final levels = const [', 'final levels = [')
    with open(fpath_prof, 'w', encoding='utf-8') as f:
        f.write(content)

print('Done fixing!')
