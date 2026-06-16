import re

def modify_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    pattern = r'TextField\(\s*controller: langC,\s*decoration: const InputDecoration\(labelText: "Language"\),\s*\),'
    
    dropdown_code = """Builder(
                    builder: (context) {
                      final defaultLangs = [
                        "English", "Assamese", "Bengali", "Bodo", "Dogri", "Gujarati", "Hindi",
                        "Kannada", "Kashmiri", "Konkani", "Maithili", "Malayalam", "Manipuri",
                        "Marathi", "Nepali", "Odia", "Punjabi", "Sanskrit", "Santali", "Sindhi",
                        "Tamil", "Telugu", "Urdu"
                      ];
                      final items = List<String>.from(defaultLangs);
                      if (langC.text.isNotEmpty && !items.contains(langC.text)) {
                        items.insert(0, langC.text);
                      }
                      
                      return DropdownButtonFormField<String>(
                        value: langC.text.isNotEmpty ? langC.text : null,
                        decoration: const InputDecoration(labelText: "Language"),
                        items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            langC.text = val;
                          }
                        },
                      );
                    },
                  ),"""

    content = re.sub(pattern, dropdown_code, content)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    modify_file('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart')
    modify_file('lib/features/profile/presentation/widgets/professional/languages_content.dart')
