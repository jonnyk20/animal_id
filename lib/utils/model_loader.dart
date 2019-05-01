import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

enum MlModels { classification, detection }

loadModel(MlModels modelType) async {
  String modelString = '';
  switch (modelType) {
    case MlModels.classification:
      modelString = 'test_classification';
      break;
    case MlModels.detection:
      modelString = 'detection';
      break;
    default:
      print('No Model to Load');
      return;
  }
  try {
    print('LOADING MODEL: $modelString');
    Tflite.close();
    var res = await Tflite.loadModel(
      model: "assets/models/$modelString/model.tflite",
      labels: "assets/models/$modelString/labels.txt",
    );
    print('LOADED MODEL');
    print(res);
  } on PlatformException {
    print('Failed to load model.');
  }
}
