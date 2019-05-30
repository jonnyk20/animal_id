import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/utils/model_loader.dart';
import 'package:animal_id/models/classification_model.dart';
import 'package:tflite/tflite.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';

List<TargetDetectionFrame> filterFrames(
    List<TargetDetectionFrame> frames, DetectedObject objectToClassify) {
  var filteredFrames =
      frames.where((frame) => frame.detectionName == objectToClassify.name);
  return filteredFrames.toList();
}

Future<List<Classification>> classifyFrame(TargetDetectionFrame frame) async {
  var rawClassifications = await Tflite.runModelOnFrame(
    bytesList: frame.bytesList, // required
    imageHeight: frame.height,
    imageWidth: frame.width,
    imageMean: 127.5, // defaults to 127.5
    imageStd: 127.5, // defaults to 127.5
    rotation: 90, // defaults to 90, Android only
    numResults: 5, // defaults to 5
    threshold: 0.1, // defaults to 0.1
    // asynch: true        // defaults to true
  );
  return rawClassifications
      .map<Classification>((classification) => Classification(
          index: classification['index'],
          confidence: classification['confidence'],
          label: classification['label']))
      .toList();
}

classifyFrames(List<TargetDetectionFrame> frames) async {
  var pendingClassifications =
      frames.map<Future<List<Classification>>>((frame) => classifyFrame(frame));
  var classifications = await Future.wait(pendingClassifications);
  return classifications;
}

calculateTopClassification(List<List<Classification>> classifications) async {
  var classificationsMap = {};
  String topClassificationName = '';
  classifications.forEach((classification) {
    classification.forEach((object) {
      if (classificationsMap[object.label] == null) {
        classificationsMap[object.label] = object.confidence;
      } else {
        classificationsMap[object.label] += object.confidence;
      }
    });
  });
  classificationsMap.forEach((label, confidence) {
    if (topClassificationName.isEmpty ||
        confidence > classificationsMap[topClassificationName]) {
      topClassificationName = label;
    }
  });
  await loadModel(MlModels.detection);
  double score = classificationsMap[topClassificationName]
      ? classificationsMap[topClassificationName]
      : 0;
  return ClassificationResult(name: topClassificationName, score: score);
}

classifyByFrames(
  List<TargetDetectionFrame> targetDetectionFrames,
  DetectedObject objectToClassify,
  Function setClassificationResult,
) async {
  await loadModel(MlModels.classification);
  List<TargetDetectionFrame> filteredFrames =
      filterFrames(targetDetectionFrames, objectToClassify);
  List<List<Classification>> classifications =
      await classifyFrames(filteredFrames);
  ClassificationResult topClassification =
      await calculateTopClassification(classifications);
  setClassificationResult(topClassification);
}
