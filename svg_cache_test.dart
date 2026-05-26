import 'package:flutter_test/flutter_test.dart'; import 'package:flutter_svg/flutter_svg.dart'; void main() { test('cache', () { svg.cache.clear(); PictureProvider.cache.clear(); }); }
