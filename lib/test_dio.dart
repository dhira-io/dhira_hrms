import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final response = await dio.get(
      'https://countriesnow.space/api/v0.1/countries/codes',
    );
    final data = List<Map<String, dynamic>>.from(response.data['data'] as List<dynamic>);
    print(data.length);
    if(data.isNotEmpty) print(data[0]);
  } catch (e) {
    print('Error: $e');
  }
}
