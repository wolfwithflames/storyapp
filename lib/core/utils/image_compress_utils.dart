import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:storyapp/core/logger/app_logger.dart';

abstract class ImageCompressHelper {
  Future<Uint8List?> compressFile(File file);
}

class ImageCompressHelperImpl extends ImageCompressHelper {
  @override
  Future<Uint8List?> compressFile(File file) async {
    try {
      var result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 50,
      );
      return result;
    } catch (e) {
      AppLog.e("Image Compression Error");
      AppLog.e(e);
    }
    return null;
  }
}
