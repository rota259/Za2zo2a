import os
import re

with open('analyze_out_utf8.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

files_to_lines = {}
for line in lines:
    if 'invalid_constant' in line or 'const_with_non_constant_argument' in line or 'invalid_assignment' in line:
        parts = line.split('-')
        if len(parts) >= 3:
            file_info = parts[2].strip()
            if ':' in file_info:
                # "lib\core\widgets\custom_text_field.dart:45:47"
                tokens = file_info.split(':')
                if len(tokens) >= 2:
                    filepath = tokens[0]
                    line_num = int(tokens[1])
                    if filepath not in files_to_lines:
                        files_to_lines[filepath] = set()
                    files_to_lines[filepath].add(line_num)

for filepath, line_nums in files_to_lines.items():
    if not os.path.exists(filepath): continue
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.readlines()
    
    for line_num in sorted(list(line_nums), reverse=True):
        idx = line_num - 1
        # search upwards for up to 5 lines to find 'const ' and replace it
        # This handles cases where const is placed on parent widget
        for i in range(idx, max(-1, idx - 5), -1):
            if 'const ' in content[i]:
                content[i] = content[i].replace('const ', '')
                break
            
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(content)
        
print("Fixed remaining const errors automatically.")
