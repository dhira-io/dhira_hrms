import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;

class ImageCompressService {
  /// Compresses an image at [filePath] by 50% quality.
  /// Returns the compressed [File] or null if compression fails.
  Future<File?> compressImage(String filePath) async {
    try {
      final file = File(filePath);
      final int originalSize = await file.length();
      // Get temporary directory to store compressed image
      final tempDir = await path_provider.getTemporaryDirectory();
      final fileName = p.basenameWithoutExtension(filePath);
      final targetPath = p.join(tempDir.path, "$fileName.jpg");
      // Compress image
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 50,
      );

      if (result != null) {
        final compressedFile = File(result.path);
        final int compressedSize = await compressedFile.length();
        return compressedFile;
      }
      return null;
    } catch (e) {
      // In case of error, return null or original file?
      // User specifically asked to compress, so if it fails, returning null is safer or log it.
      return null;
    }
  }
}
