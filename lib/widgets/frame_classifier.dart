import 'dart:async';
import 'package:animal_id/widgets/classification_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/utils/classify_frames.dart';
import 'package:animal_id/utils/model_loader.dart';
import 'package:animal_id/constants/constants.dart';

const detection = "detection";
const classification = "classification";
const duration = Duration(milliseconds: 300);

class FrameClassifier extends StatefulWidget {
  final DetectedObject objectToClassify;
  final List<TargetDetectionFrame> targetDetectionFrames;
  final Function setClassificationStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;
  final Function clearTargetDetectionFrames;

  FrameClassifier({
    this.objectToClassify,
    this.targetDetectionFrames,
    this.setClassificationResult,
    this.setClassificationStatus,
    this.clearClassificationResult,
    this.clearTargetDetectionFrames,
  });
  State<FrameClassifier> createState() => FrameClassifierState(
      objectToClassify: objectToClassify,
      targetDetectionFrames: targetDetectionFrames,
      setClassificationResult: setClassificationResult,
      clearClassificationResult: clearClassificationResult,
      setClassificationStatus: setClassificationStatus,
      clearTargetDetectionFrames: clearTargetDetectionFrames);
}

class FrameClassifierState extends State<FrameClassifier> {
  final DetectedObject objectToClassify;
  final List<TargetDetectionFrame> targetDetectionFrames;
  final Function setClassificationStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;
  final Function clearTargetDetectionFrames;
  bool isClassifying = false;
  String classifiedObject;
  FrameClassifierState({
    this.objectToClassify,
    this.targetDetectionFrames,
    this.setClassificationResult,
    this.setClassificationStatus,
    this.clearClassificationResult,
    this.clearTargetDetectionFrames,
  });
  @override
  void initState() {
    super.initState();
    Timer(duration, () {
      showResults();
    });
    startClassification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  startClassification() async {
    await classifyByFrames(
      targetDetectionFrames,
      objectToClassify,
      setClassificationResult,
    );
  }

  showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Detected Object: ${objectToClassify.name}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          content: ClassificationResults(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              child: Text(
                'close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => closeClassifier(context),
            ),
          ],
        );
      },
    );
  }

  closeClassifier(context) {
    // await reset model
    loadModel(MlModels.detection);
    // clear states
    setClassificationStatus(ClassificationStatuses.not_classifying);
    clearTargetDetectionFrames();
    clearClassificationResult();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {};
      },
      builder: (context, props) {
        return Container(
          child: classifiedObject == null
              ? Text('Classifying...')
              : Text('Classified: $classifiedObject'),
        );
      },
    );
  }
}
