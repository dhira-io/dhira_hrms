import os
import re

# We use (?![0-9a-zA-Z\.]) to prevent backtracking from matching a partial number or matching something that already has .w .h .sp .r

pattern_font = re.compile(r'(fontSize:\s*)(\d+(\.\d+)?)(?!\s*\.(sp|w|h|r)|[0-9\.])')
def replace_font(match):
    return f"{match.group(1)}{match.group(2)}.sp"

pattern_width = re.compile(r'(?<!stroke)(?<!border)(?<!line)(?<!item)(width:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_width(match):
    return f"{match.group(1)}{match.group(2)}.w"

pattern_height = re.compile(r'(?<!line)(?<!item)(height:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_height(match):
    return f"{match.group(1)}{match.group(2)}.h"

pattern_radius = re.compile(r'(circular\(\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_radius(match):
    return f"{match.group(1)}{match.group(2)}.r"

pattern_all = re.compile(r'(all\(\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_all(match):
    return f"{match.group(1)}{match.group(2)}.w"

pattern_horizontal = re.compile(r'(horizontal:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_horizontal(match):
    return f"{match.group(1)}{match.group(2)}.w"

pattern_vertical = re.compile(r'(vertical:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
def replace_vertical(match):
    return f"{match.group(1)}{match.group(2)}.h"

pattern_left = re.compile(r'(left:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
pattern_right = re.compile(r'(right:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
pattern_top = re.compile(r'(top:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')
pattern_bottom = re.compile(r'(bottom:\s*)(\d+(\.\d+)?)(?!\s*\.(w|h|sp|r)|[0-9\.])')

def replace_left(match):
    return f"{match.group(1)}{match.group(2)}.w"
def replace_right(match):
    return f"{match.group(1)}{match.group(2)}.w"
def replace_top(match):
    return f"{match.group(1)}{match.group(2)}.h"
def replace_bottom(match):
    return f"{match.group(1)}{match.group(2)}.h"


modified_files_count = 0

for root, dirs, files in os.walk('lib'):
    if 'generated' in root or '.g.dart' in root or '.freezed.dart' in root:
        continue
        
    for file in files:
        if file.endswith('.dart') and not file.endswith('.g.dart') and not file.endswith('.freezed.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                original_content = f.read()

            content = original_content
            
            content = pattern_font.sub(replace_font, content)
            content = pattern_width.sub(replace_width, content)
            content = pattern_height.sub(replace_height, content)
            content = pattern_radius.sub(replace_radius, content)
            content = pattern_all.sub(replace_all, content)
            content = pattern_horizontal.sub(replace_horizontal, content)
            content = pattern_vertical.sub(replace_vertical, content)
            content = pattern_left.sub(replace_left, content)
            content = pattern_right.sub(replace_right, content)
            content = pattern_top.sub(replace_top, content)
            content = pattern_bottom.sub(replace_bottom, content)
            
            if content != original_content:
                if 'flutter_screenutil' not in content and ('flutter/material.dart' in content or 'flutter/cupertino.dart' in content):
                    import_str = "import 'package:flutter_screenutil/flutter_screenutil.dart';\n"
                    first_import = content.find('import')
                    if first_import != -1:
                        end_of_line = content.find('\n', first_import)
                        if end_of_line != -1:
                            content = content[:end_of_line+1] + import_str + content[end_of_line+1:]
                        else:
                            content = import_str + content
                    else:
                        content = import_str + content

                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                modified_files_count += 1

print(f"Successfully processed and updated {modified_files_count} files!")
