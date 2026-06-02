import os
import re

stats = {
    'hardcoded_strings': 0,
    'hardcoded_colors': 0,
    'hardcoded_textstyles': 0,
    'toast_util_misses': 0,
    'widget_functions': 0,
    'initstate_postframe_misses': 0,
    'extra_values_hardcoded': 0,
    'datetime_misses': 0,
    'params_exceed_7': 0,
    'screenutil_misses': 0,
    'files_scanned': 0
}

# Regex patterns
# 1 & 8: Hardcoded strings (crude heuristic: Text('something') instead of Text(l10n.something))
pattern_hardcoded_text = re.compile(r"Text\s*\(\s*['\"](.*?)['\"]")

# 1 & 2: Hardcoded colors (Color(0x...), Colors.red)
pattern_hardcoded_color = re.compile(r"(Color\s*\(\s*0x[0-9A-Fa-f]+\s*\)|Colors\.[a-z]+)")

# 1 & 2: Hardcoded TextStyle (TextStyle( instead of AppTextStyle)
pattern_textstyle = re.compile(r"TextStyle\s*\(")

# 3: Toast messages not using ToastUtils (e.g., Fluttertoast.showToast or ScaffoldMessenger)
pattern_toast_miss = re.compile(r"(Fluttertoast\.showToast|ScaffoldMessenger\.of\(context\)\.showSnackBar)")

# 5: Function returning widget: Widget buildSomething()
pattern_widget_func = re.compile(r"(?<!\bbuild\b)\s+Widget\s+[a-zA-Z0-9_]+\s*\(")

# 6: initState without postframe
# This is complex, let's just count how many initState call bloc events directly without addPostFrameCallback
# We'll look for `initState` blocks in a crude way later.

# 7: extra values hardcoded: context.push('/route', extra: 'some_string' or extra: {'key': ...})
# Hard to grep precisely, but let's look for extra: {'key'
pattern_extra_hardcoded = re.compile(r"extra:\s*\{\s*['\"][a-zA-Z0-9_]+['\"]")

# 9: Parameters > 7. Look for constructor definitions with many parameters
pattern_constructor = re.compile(r"const\s+([A-Z][a-zA-Z0-9_]*)\s*\(\{(.*?)\}\)", re.DOTALL)

# 10: Date time formatter not using DateTimeUtils (e.g. DateFormat('...').format)
pattern_dateformat = re.compile(r"DateFormat\s*\(")

# 11: Screenutil misses (already largely fixed, but we'll check width: \d+ without .w)
pattern_screenutil = re.compile(r"(width|height):\s*\d+(\.\d+)?,")

for root, dirs, files in os.walk('lib'):
    if 'generated' in root or '.g.dart' in root or '.freezed.dart' in root:
        continue
        
    for file in files:
        if file.endswith('.dart') and not file.endswith('.g.dart') and not file.endswith('.freezed.dart'):
            filepath = os.path.join(root, file)
            stats['files_scanned'] += 1
            
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Rule 1 & 8
            if 'presentation' in filepath:
                stats['hardcoded_strings'] += len(pattern_hardcoded_text.findall(content))
                stats['hardcoded_colors'] += len(pattern_hardcoded_color.findall(content))
                stats['hardcoded_textstyles'] += len(pattern_textstyle.findall(content))
                stats['widget_functions'] += len([m for m in pattern_widget_func.findall(content) if 'build(' not in m])
            
            # Rule 3
            stats['toast_util_misses'] += len(pattern_toast_miss.findall(content))
            
            # Rule 6 (crude)
            if 'void initState()' in content:
                init_parts = content.split('void initState()')
                for part in init_parts[1:]:
                    body = part.split('}')[0] # crude body
                    if '.add(' in body and 'addPostFrameCallback' not in body:
                        stats['initstate_postframe_misses'] += 1
                        
            # Rule 7
            stats['extra_values_hardcoded'] += len(pattern_extra_hardcoded.findall(content))
            
            # Rule 9
            for match in pattern_constructor.finditer(content):
                params = match.group(2).split(',')
                # ignore empty
                params = [p for p in params if p.strip()]
                if len(params) > 7:
                    stats['params_exceed_7'] += 1
                    
            # Rule 10
            stats['datetime_misses'] += len(pattern_dateformat.findall(content))
            
            # Rule 11
            stats['screenutil_misses'] += len(pattern_screenutil.findall(content))

for k, v in stats.items():
    print(f"{k}: {v}")
