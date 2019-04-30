import 'dart:async';
import 'dart:io';
import 'package:tflite/tflite.dart';

Future classifyImage(File image) async {
  print('RECIGNIZING IMAGE');
  var recognitions = await Tflite.runModelOnImage(
    path: image.path,
    numResults: 6,
    threshold: 0.05,
    imageMean: 127.5,
    imageStd: 127.5,
  );
  print('RECOGNITIONS');
  print(recognitions);
  return recognitions;
}
