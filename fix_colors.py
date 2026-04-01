import os
import re
import subprocess

# 1. Modify the AppColors class to be mutable
app_colors_path = r'r:\Rota\Flutter\flutter_tasks_mostafa\lib\core\constants\app_colors.dart'

with open(app_colors_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace static const Color with static Color
content = content.replace('static const Color', 'static Color')

# Append the toggle methods
if 'static void setDark()' not in content:
    content = content[:-2] + """
  static void setDark() {
    primary = const Color(0xFFE23030);
    secondary = const Color(0xFFF3F4F6);
    background = const Color(0xFF121212);
    textPrimary = const Color(0xFFFFFFFF);
    textSecondary = const Color(0xFFAAAAAA);
    grey50 = const Color(0xFF1E1E1E);
    grey100 = const Color(0xFF2C2C2C);
    grey200 = const Color(0xFF333333);
    grey300 = const Color(0xFF444444);
    grey400 = const Color(0xFF666666);
    grey500 = const Color(0xFFAAAAAA);
    success = const Color(0xFF10B981);
    error = const Color(0xFFEF4444);
    warning = const Color(0xFFF59E0B);
    info = const Color(0xFF3B82F6);
  }

  static void setLight() {
    primary = const Color(0xFFE23030);
    secondary = const Color(0xFF2C2C2C);
    background = const Color(0xFFFFFFFF);
    textPrimary = const Color(0xFF1E1E1E);
    textSecondary = const Color(0xFF757575);
    grey50 = const Color(0xFFF9FAFB);
    grey100 = const Color(0xFFF3F4F6);
    grey200 = const Color(0xFFE5E7EB);
    grey300 = const Color(0xFFD1D5DB);
    grey400 = const Color(0xFF9CA3AF);
    grey500 = const Color(0xFF6B7280);
    success = const Color(0xFF10B981);
    error = const Color(0xFFEF4444);
    warning = const Color(0xFFF59E0B);
    info = const Color(0xFF3B82F6);
  }
}
"""
    with open(app_colors_path, 'w', encoding='utf-8') as f:
        f.write(content)

# 2. Run flutter analyze to find where 'const' is breaking because AppColors is no longer const
def fix_const_errors():
    print("Running flutter analyze...")
    result = subprocess.run(['flutter', 'analyze'], capture_output=True, text=True, cwd=r'r:\Rota\Flutter\flutter_tasks_mostafa', shell=True)
    output = result.stdout + result.stderr

    # Parse errors like:
    # error • Arguments of a constant creation must be constant expressions • lib\features\auth\views\login_view.dart:12:30 • non_constant_value
    # error • Cannot invoke a non-'const' constructor where a const expression is expected • lib\foo.dart:20:5 • invalid_constant

    lines = output.splitlines()
    files_to_lines = {}
    for line in lines:
        if ('non_constant' in line or 'invalid_constant' in line or 'cannot_be_assigned' in line or 'not_a_constant' in line or 'Arguments of a constant' in line):
            parts = line.split('•')
            if len(parts) >= 3:
                file_info = parts[2].strip()
                if ':' in file_info:
                    filepath, line_num, _ = file_info.split(':')
                    full_path = os.path.join(r'r:\Rota\Flutter\flutter_tasks_mostafa', filepath)
                    if full_path not in files_to_lines:
                        files_to_lines[full_path] = set()
                    files_to_lines[full_path].add(int(line_num))
    
    # We also iteratively just strip "const " from the lines that have the error
    changes_made = False
    for filepath, line_nums in files_to_lines.items():
        if os.path.exists(filepath):
            with open(filepath, 'r', encoding='utf-8') as f:
                content_lines = f.readlines()
            
            for line_num in line_nums:
                idx = line_num - 1
                if idx < len(content_lines):
                    # Remove 'const '
                    if 'const ' in content_lines[idx]:
                        content_lines[idx] = content_lines[idx].replace('const ', '')
                        changes_made = True
            
            with open(filepath, 'w', encoding='utf-8') as f:
                f.writelines(content_lines)
    
    return changes_made

# Run fix loops until no const errors remain
max_loops = 5
for i in range(max_loops):
    made_changes = fix_const_errors()
    if not made_changes:
        break

print("Done fixing app colors constants.")
