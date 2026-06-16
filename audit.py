import os
import re

def analyze_directory(dir_path):
    issues = {
        "textstyle": [],
        "color": [],
        "snackbar": [],
        "business_logic": [],
        "build_function": [],
        "init_state": [],
        "datetime": [],
        "hardcoded_string": [],
        "screenutil": []
    }
    
    for root, _, files in os.walk(dir_path):
        for file in files:
            if not file.endswith('.dart'):
                continue
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            in_init_state = False
            
            for i, line in enumerate(lines):
                # 1 & 2: Colors and TextStyles
                if re.search(r'Colors\.[a-zA-Z]+', line):
                    issues["color"].append(f"{filepath}:{i+1} -> {line.strip()}")
                if re.search(r'Color\(0x[a-fA-F0-9]+\)', line):
                    issues["color"].append(f"{filepath}:{i+1} -> {line.strip()}")
                if 'TextStyle(' in line and 'AppTextStyle' not in line:
                    issues["textstyle"].append(f"{filepath}:{i+1} -> {line.strip()}")
                
                # 3: ToastUtil vs SnackBar
                if 'ScaffoldMessenger.of(context).showSnackBar' in line or 'SnackBar(' in line:
                    issues["snackbar"].append(f"{filepath}:{i+1} -> {line.strip()}")
                
                # 5: functions returning Widget
                if re.match(r'^\s*(Widget|Expanded|Padding|Container)\s+_[a-zA-Z0-9_]+\s*\(', line):
                    issues["build_function"].append(f"{filepath}:{i+1} -> {line.strip()}")
                
                # 6: initState postFrameCallback
                if 'void initState()' in line:
                    in_init_state = True
                if in_init_state and '}' in line and '{' not in line:  # rough heuristic
                    pass
                if in_init_state and re.search(r'\w+Bloc.*?\.add\(', line) and 'addPostFrameCallback' not in ''.join(lines[i-5:i+1]):
                    issues["init_state"].append(f"{filepath}:{i+1} -> {line.strip()}")
                    
                # 10: DateTime formatter
                if 'DateFormat(' in line:
                    issues["datetime"].append(f"{filepath}:{i+1} -> {line.strip()}")
                    
                # 11: ScreenUtil missing (hardcoded doubles without .h, .w, .r, .sp)
                # looking for patterns like width: 10, height: 16.0, radius: 8, fontSize: 14
                if re.search(r'(width|height|fontSize|radius|all|symmetric|only)\s*:\s*\d+(\.\d+)?[^.a-zA-Z0-9]', line):
                    if not any(x in line for x in ['.w', '.h', '.sp', '.r']):
                         issues["screenutil"].append(f"{filepath}:{i+1} -> {line.strip()}")

    return issues

issues = analyze_directory('lib/features/profile/presentation')

for category, items in issues.items():
    print(f"--- {category.upper()} ---")
    for item in items[:20]: # print first 20 to avoid spam
        print(item)
    if len(items) > 20:
        print(f"... and {len(items) - 20} more.")
    print()
