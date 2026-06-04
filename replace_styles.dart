import 'dart:io';

void main() {
  final file = File('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart');
  String content = file.readAsStringSync();

  // Replace colors
  content = content.replaceAll('const Color(0xFF1E293B)', 'AppColors.of(context).surface');
  content = content.replaceAll('const Color(0xFF475569)', 'AppColors.of(context).slate600');
  content = content.replaceAll('const Color(0xFFCBD5E1)', 'AppColors.of(context).slate300');
  content = content.replaceAll('const Color(0xFF334155)', 'AppColors.of(context).slate700');
  
  // Replace TextStyle
  content = content.replaceAll('TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)', 'AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp)');
  content = content.replaceAll('TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)', 'AppTextStyle.bodyMedium.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold)');
  content = content.replaceAll('TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)', 'AppTextStyle.bodySmall.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600)');
  content = content.replaceAll('TextStyle(', 'AppTextStyle.bodyMedium.copyWith(');

  file.writeAsStringSync(content);
  print('Replaced styles and colors');
}
