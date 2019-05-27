import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/detection_model.dart';

cropImage(String previewPath, DetectedObject objectToClassify,
    Function setPreviewPath) async {
  Detection detection = objectToClassify.lastTargetDection;
  int top = detection.top.round();
  int left = detection.left.round();
  int width = detection.width.round();
  int height = detection.height.round();
  print('TOP $top');
  print('LEFT $left');
  print('WIDTH $width');
  print('HEIGHT $height');
  File croppedFile =
      await FlutterNativeImage.cropImage(previewPath, left, top, width, height);
  setPreviewPath(croppedFile.path);
}
