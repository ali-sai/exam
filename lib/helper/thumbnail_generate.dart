import 'dart:io';
import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> generateThumbnail(File videoFile) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: videoFile.path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 240,
  );
  return uint8list;
}
