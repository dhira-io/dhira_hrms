const fs = require('fs');
function applyFixes(file) {
  let content = fs.readFileSync(file, 'utf8');

  // 1. Swap Role and Lead Builder blocks
  // Find lead builder block
  const leadRegex = /Builder\(\s*builder: \(context\) \{\s*return Autocomplete<SearchEmployeeModel>\([\s\S]*?return Align\([\s\S]*?;\s*\},?\s*\);\s*\},\s*\),/g;
  // Find role builder block
  const roleRegex = /Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\([\s\S]*?SearchDesignationsUseCase[\s\S]*?return Align\([\s\S]*?;\s*\},?\s*\);\s*\},\s*\),/g;

  let leadMatch = content.match(leadRegex);
  let roleMatch = content.match(roleRegex);

  if (leadMatch && roleMatch) {
    let leadBlock = leadMatch[0];
    let roleBlock = roleMatch[0];
    // Replace lead with unique placeholder
    content = content.replace(leadBlock, '___LEAD_BLOCK___');
    // Replace role with lead
    content = content.replace(roleBlock, leadBlock);
    // Replace placeholder with role
    content = content.replace('___LEAD_BLOCK___', roleBlock);
  }

  // 2. Fix date formats in UI and mappings
  content = content.replace(/hintText: "yyyy-mm-dd"/g, 'hintText: "dd-mm-yyyy"');
  
  // replace fromC picker format
  content = content.replace(/fromC\.text = "\$\{picked\.year\}-\$\{picked\.month\.toString\(\)\.padLeft\(2, '0'\)\}-\$\{picked\.day\.toString\(\)\.padLeft\(2, '0'\)\}";/g, 'fromC.text = "${picked.day.toString().padLeft(2, \\\'0\\\')}-${picked.month.toString().padLeft(2, \\\'0\\\')}-${picked.year}";');

  // replace toC picker format
  content = content.replace(/toC\.text = "\$\{picked\.year\}-\$\{picked\.month\.toString\(\)\.padLeft\(2, '0'\)\}-\$\{picked\.day\.toString\(\)\.padLeft\(2, '0'\)\}";/g, 'toC.text = "${picked.day.toString().padLeft(2, \\\'0\\\')}-${picked.month.toString().padLeft(2, \\\'0\\\')}-${picked.year}";');

  // Add _formatDate function at the end of the classes
  if (!content.includes('_formatDateForApi')) {
    content = content.replace(/}\n*$/, `
  String _formatDateForApi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 2) {
      return "\${parts[2]}-\${parts[1]}-\${parts[0]}";
    }
    return dateStr;
  }

  String _formatDateForUi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 4) {
      return "\${parts[2]}-\${parts[1]}-\${parts[0]}";
    }
    return dateStr;
  }
}
`);
  }

  // Format startDate and endDate initial text using _formatDateForUi
  content = content.replace(/final fromC = TextEditingController\(text: proj\.startDate \?\? ""\);/, 'final fromC = TextEditingController(text: _formatDateForUi(proj.startDate ?? ""));');
  content = content.replace(/final toC = TextEditingController\(text: proj\.endDate \?\? ""\);/, 'final toC = TextEditingController(text: _formatDateForUi(proj.endDate ?? ""));');

  // Format startDate and endDate before saving
  content = content.replace(/startDate: fromC\.text/g, 'startDate: _formatDateForApi(fromC.text)');
  content = content.replace(/endDate: toC\.text/g, 'endDate: _formatDateForApi(toC.text)');

  fs.writeFileSync(file, content, 'utf8');
}

applyFixes('lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart');
applyFixes('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart');
