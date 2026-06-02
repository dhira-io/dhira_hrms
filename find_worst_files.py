import os
import re

pattern_hardcoded_text = re.compile(r"Text\s*\(\s*['\"](.*?)['\"]")
pattern_hardcoded_color = re.compile(r"(Color\s*\(\s*0x[0-9A-Fa-f]+\s*\)|Colors\.[a-z]+)")
pattern_widget_func = re.compile(r"(?<!\bbuild\b)\s+Widget\s+[a-zA-Z0-9_]+\s*\(")

file_violations = {}

for root, dirs, files in os.walk('lib'):
    if 'generated' in root or '.g.dart' in root or '.freezed.dart' in root:
        continue
        
    for file in files:
        if file.endswith('.dart') and not file.endswith('.g.dart') and not file.endswith('.freezed.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Count violations
            strings = len(pattern_hardcoded_text.findall(content))
            colors = len(pattern_hardcoded_color.findall(content))
            functions = len([m for m in pattern_widget_func.findall(content) if 'build(' not in m])
            
            total = strings + colors + functions
            
            if total > 0:
                # Store relative to lib/ to make it cleaner
                clean_path = filepath.split('lib')[1][1:].replace('\\', '/')
                file_violations[clean_path] = {
                    'total': total,
                    'colors': colors,
                    'strings': strings,
                    'functions': functions
                }

# Sort by highest total violations
sorted_files = sorted(file_violations.items(), key=lambda x: x[1]['total'], reverse=True)

print("--- TOP 15 SCREENS/FILES REQUIRING MAJOR REFACTORING ---")
for f, v in sorted_files[:15]:
    print(f"{f}: {v['total']} total violations (Colors: {v['colors']}, Strings: {v['strings']}, Widget Functions: {v['functions']})")
