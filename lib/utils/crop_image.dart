import 'dart:io';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/image_preview_model.dart';

_getDimensions(path) async {
  File image =
      new File('image.png'); // Or any other way to get a File instance.
  ui.Image img = await decodeImageFromList(image.readAsBytesSync());

  // print(decodedImage.width);
  // print(decodedImage.height);
}

cropImage(String previewPath, DetectedObject objectToClassify,
    Function setPreviewPath) async {
  ui.Image img = await decodeImageFromList(File(previewPath).readAsBytesSync());
  int imgHeight = img.height;
  int imgWidth = img.width;
  print('IMAGE HEIGHT ${imgHeight}');
  print('IMAGE WIDTH ${imgWidth}');

  Detection detection = objectToClassify.lastTargetDection;
  double top = detection.rawTop;
  double left = detection.rawLeft;
  double width = detection.rawWidth;
  double height = detection.rawHeight;
  print('TOP% $top');
  print('LEFT% $left');
  print('WIDTH% $width');
  print('HEIGHT% $height');

  int adjustedTop = (top * imgHeight).round();
  int adjustedHeight = (height * imgHeight).round();
  int adjustedLeft = (left * imgWidth).round();
  int adjustedWidth = (width * imgWidth).round();

  print('adjustedTop $adjustedTop');
  print('adjustedHeight $adjustedHeight');
  print('adjustedLeft $adjustedLeft');
  print('adjustedWidth $adjustedWidth');

  File croppedFile = await FlutterNativeImage.cropImage(
    previewPath,
    adjustedLeft,
    adjustedTop,
    adjustedWidth,
    adjustedHeight,
  );

  setPreviewPath(ImagePreview(
    path: croppedFile.path,
    height: adjustedHeight,
    width: adjustedWidth,
  ));
}
