import 'dart:async';
import 'dart:io';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:tflite/tflite.dart';

const def =
    '/var/mobile/Containers/Data/Application/B5CD1142-9313-435E-9015-DB3E05AB9E7D/Documents/Pictures/flutter_test/delete-this.jpg';

Future classifyImage(File image, Function setClassificationResult) async {
  List<dynamic> recognitions = await Tflite.runModelOnImage(
    path: image.path,
    numResults: 6,
    threshold: 0.05,
    imageMean: 127.5,
    imageStd: 127.5,
  );

  if (recognitions.isEmpty) {
    setClassificationResult(ClassificationResult(name: '', score: 0));
  } else {
    var topRecognition = recognitions[0];
    setClassificationResult(ClassificationResult(
        name: topRecognition['label'], score: topRecognition['confidence']));
  }
  return recognitions;
}
