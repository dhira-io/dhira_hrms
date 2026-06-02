import re
import os

with open('analyze_errors.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# error - Extension methods can't be used in constant expressions - lib\features\...dart:65:50 - const_eval_extension_method
pattern = re.compile(r'lib[\\/].*\.dart:(\d+):(\d+)')

files_to_fix = {}

for line in lines:
    if 'const_eval_extension_method' in line:
        # Find the file path
        match = re.search(r'(lib[\\/][^:]+\.dart):(\d+):(\d+)', line)
        if match:
            filepath = match.group(1)
            lineno = int(match.group(2)) - 1 # 0-indexed
            colno = int(match.group(3)) - 1
            
            if filepath not in files_to_fix:
                files_to_fix[filepath] = []
            files_to_fix[filepath].append((lineno, colno))

count = 0

for filepath, errors in files_to_fix.items():
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # We will search backwards from the error index in the string content
    # But wait, multiple errors in the same file might share the same `const`.
    # To handle this, we process errors. If we remove a `const`, its position changes, 
    # but we can replace `const ` with `      ` (spaces) to keep string length identical, 
    # then strip later, or just replace `const ` with `      `.
    
    lines_of_file = content.split('\n')
    
    for lineno, colno in errors:
        # trace backwards from lineno, colno
        # start at lineno
        found = False
        
        # search in the same line first, before colno
        line_prefix = lines_of_file[lineno][:colno]
        if 'const ' in line_prefix:
            # find the last 'const '
            last_idx = line_prefix.rfind('const ')
            lines_of_file[lineno] = lines_of_file[lineno][:last_idx] + '      ' + lines_of_file[lineno][last_idx+6:]
            count += 1
            continue
            
        # if not found, search previous lines
        for i in range(lineno - 1, max(-1, lineno - 20), -1):
            if 'const ' in lines_of_file[i]:
                last_idx = lines_of_file[i].rfind('const ')
                lines_of_file[i] = lines_of_file[i][:last_idx] + '      ' + lines_of_file[i][last_idx+6:]
                count += 1
                found = True
                break
                
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines_of_file))

print(f"Removed const from {count} places.")
