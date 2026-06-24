import 'dart:convert';
import 'package:dhira_hrms/features/profile/data/models/resume_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parsing custom_sub_skill', () {
    final jsonStr = '''
    {
        "name": "gtni922e3l",
        "skill": "Accessibility & UX",
        "proficiency": "Advanced",
        "years_of_experience": 1.0,
        "custom_sub_skill": [
            {"sub_skill": "Keyboard nav"},
            {"sub_skill": "alternative DOM views"}
        ]
    }
    ''';
    
    final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    final model = ResumeSkillModel.fromJson(jsonMap);
    final entity = model.toEntity();
    
    expect(entity.skill, 'Accessibility & UX');
    expect(entity.subSkills.length, 2);
    expect(entity.subSkills[0].subSkill, 'Keyboard nav');
    expect(entity.subSkills[1].subSkill, 'alternative DOM views');
  });
}
