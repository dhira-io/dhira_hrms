import 'package:dio/dio.dart';

class LanguageHelper {
  static List<String>? _cachedLanguages;
  static final List<String> _fallbackLanguages = [
    "English", "Assamese", "Bengali", "Bodo", "Dogri", "Gujarati", "Hindi",
    "Kannada", "Kashmiri", "Konkani", "Maithili", "Malayalam", "Manipuri",
    "Marathi", "Nepali", "Odia", "Punjabi", "Sanskrit", "Santali", "Sindhi",
    "Tamil", "Telugu", "Urdu", "Spanish", "French", "German", "Mandarin", "Arabic"
  ];

  static Future<List<String>> getLanguages() async {
    if (_cachedLanguages != null) {
      return _cachedLanguages!;
    }
    
    try {
      final dio = Dio();
      final response = await dio.get('https://restcountries.com/v3.1/all?fields=languages');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final Set<String> langs = {};
        
        for (var country in data) {
          if (country['languages'] != null) {
            final Map<String, dynamic> langsMap = country['languages'];
            for (var lang in langsMap.values) {
              langs.add(lang.toString());
            }
          }
        }
        
        final list = langs.toList()..sort();
        _cachedLanguages = list;
        return list;
      }
    } catch (e) {
      // Fallback in case of network error
      return _fallbackLanguages..sort();
    }
    
    return _fallbackLanguages..sort();
  }
}
