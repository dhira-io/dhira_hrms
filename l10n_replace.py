import re

files_to_update = [
    'lib/features/profile/presentation/widgets/profile_professional_details_tab.dart',
    'lib/features/profile/presentation/widgets/profile_contact_tab.dart',
    'lib/features/profile/presentation/widgets/profile_header.dart',
    'lib/features/profile/presentation/widgets/profile_overview_tab.dart'
]

for fpath in files_to_update:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace l10n. with AppLocalizations.of(context)!.
    content = content.replace('l10n.', 'AppLocalizations.of(context)!.')
    
    # Ensure import is present
    import_statement = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';"
    if 'app_localizations.dart' not in content:
        # Add import after other imports
        content = re.sub(r'(import .*?;)', r'\1\n' + import_statement, content, count=1)
    
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)

print('Replaced l10n with AppLocalizations.of(context)!. and ensured import.')
