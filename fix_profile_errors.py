import re
import os

# 1. Fix change_password_screen.dart undefined 'l10n'
# We need to inject `final l10n = AppLocalizations.of(context)!;` inside the build method.
file_cp = r'lib\features\profile\presentation\screens\change_password_screen.dart'
if os.path.exists(file_cp):
    with open(file_cp, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # insert l10n inside build method
    if 'final l10n = AppLocalizations.of(context)!;' not in content:
        content = content.replace('Widget build(BuildContext context) {', 'Widget build(BuildContext context) {\n    final l10n = AppLocalizations.of(context)!;')
    
    # ensure AppLocalizations is imported
    if 'app_localizations.dart' not in content:
        # add import
        content = "import 'package:dhira_hrms/l10n/app_localizations.dart';\n" + content
        
    with open(file_cp, 'w', encoding='utf-8') as f:
        f.write(content)

# 2. profile_overview_tab.dart
# "AppColors doesn't have a constant constructor 'of'" - probably it was inside a `const` list.
# "The static getter 'slate100' can't be accessed through an instance" -> AppColors.slate100 instead of AppColors.of(context).slate100.
file_po = r'lib\features\profile\presentation\widgets\profile_overview_tab.dart'
if os.path.exists(file_po):
    with open(file_po, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # If slate100 is static, it should be AppColors.slate100.
    # The previous regex replaced Color(0xFF...) with AppColors.of(context).slate...
    content = content.replace('AppColors.of(context).slate700', 'AppColors.slate700')
    content = content.replace('AppColors.of(context).slate300', 'AppColors.slate300')
    content = content.replace('AppColors.of(context).slate100', 'AppColors.slate100')
    
    # If it was inside a `const`, the regex replacement made it `const AppColors.slate700`, which might be fine if slate700 is a const.
    # But let's remove 'const ' just in case.
    content = content.replace('const AppColors.slate', 'AppColors.slate')
    
    with open(file_po, 'w', encoding='utf-8') as f:
        f.write(content)

# 3. profile_professional_details_tab.dart
# Might be missing l10n definition?
file_pp = r'lib\features\profile\presentation\widgets\profile_professional_details_tab.dart'
if os.path.exists(file_pp):
    with open(file_pp, 'r', encoding='utf-8') as f:
        content = f.read()
        
    if 'final l10n = AppLocalizations.of(context)!;' not in content and 'Text(l10n.' in content:
        content = content.replace('Widget build(BuildContext context) {', 'Widget build(BuildContext context) {\n    final l10n = AppLocalizations.of(context)!;')
    
    if 'app_localizations.dart' not in content:
        content = "import 'package:dhira_hrms/l10n/app_localizations.dart';\n" + content
        
    with open(file_pp, 'w', encoding='utf-8') as f:
        f.write(content)

print("Fixes applied successfully!")
