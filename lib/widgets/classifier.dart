import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tflite/tflite.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/classification_model.dart';
import 'package:animal_id/utils/model_loader.dart';

const detection = "detection";
const classification = "classification";

List<TargetDetectionFrame> filterFrames(
    List<TargetDetectionFrame> frames, DetectedObject detectedObject) {
  print('filterFrames');
  var filteredFrames =
      frames.where((frame) => frame.detectionName == detectedObject.name);
  return filteredFrames.toList();
}

Future<List<Classification>> classifyFrame(TargetDetectionFrame frame) async {
  print('classifyFrame');
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
  print('ClassifyFrames');
  var pendingClassifications =
      frames.map<Future<List<Classification>>>((frame) => classifyFrame(frame));
  var classifications = await Future.wait(pendingClassifications);
  print('TYPE:');
  print(classifications.runtimeType);
  return classifications;
}

calculateTopClassification(List<List<Classification>> classifications) async {
  print('calculateTopClassification[0]');
  print(classifications[0][0]);
  var classificationsMap = {};
  String topClassification = '';
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
    if (topClassification.isEmpty ||
        confidence > classificationsMap[topClassification]) {
      topClassification = label;
    }
  });
  print('CLASSIFICATIONS_MAP');
  print(classificationsMap);
  print('TOP CLASSIFICATION');
  print(topClassification);
  await loadModel(MlModels.detection);
  return topClassification;
}

class Classifier extends StatefulWidget {
  final DetectedObject detectedObject;
  final List<TargetDetectionFrame> targetDetectionFrames;
  Classifier({
    this.detectedObject,
    this.targetDetectionFrames,
  });
  State<Classifier> createState() => ClassifierState(
        detectedObject: detectedObject,
        targetDetectionFrames: targetDetectionFrames,
      );
}

class ClassifierState extends State<Classifier> {
  final DetectedObject detectedObject;
  final List<TargetDetectionFrame> targetDetectionFrames;
  bool isClassifying = true;
  String classifiedObject;
  ClassifierState({
    this.detectedObject,
    this.targetDetectionFrames,
  });
  @override
  void initState() {
    print('INITSTATE');
    startClassification();
    super.initState();
  }

  @override
  void dispose() {
    print('DISPOSE');
    super.dispose();
  }

  startClassification() async {
    await loadModel(MlModels.classification);
    print('STARTING CLASSIFICATION');
    List<TargetDetectionFrame> filteredFrames =
        filterFrames(targetDetectionFrames, detectedObject);
    List<List<Classification>> classifications =
        await classifyFrames(filteredFrames);
    String topClassification =
        await calculateTopClassification(classifications);
    setState(() {
      classifiedObject = topClassification;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {};
      },
      builder: (context, props) {
        print('classifiedObject');
        print(classifiedObject);
        return Container(
          child: classifiedObject == null
              ? Text('Classifying...')
              : Text('Classified: $classifiedObject'),
        );
      },
    );
  }
}
