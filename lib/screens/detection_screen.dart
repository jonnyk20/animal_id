import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detector.dart';
import 'package:animal_id/widgets/info_box.dart';
import 'package:animal_id/widgets/bounding_box.dart';
import 'package:animal_id/widgets/target/target.dart';
import 'package:animal_id/widgets/general_classifier.dart';

class DetectionScreen extends StatelessWidget {
  final CameraDescription camera;

  DetectionScreen(this.camera);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return StoreConnector<AppState, Map>(converter: (store) {
      // if (store.state.detectedObjects.length == 0 &&
      //     store.state.targetDetectionFrames.length > 0 &&
      //     store.state.classifyingStatus ==
      //         ClassificationStatuses.not_classifying) {
      //   store.dispatch(ClearTargetDetectionFrames());
      // }
      return {
        'setDetections': (List<Detection> detections) {
          print('SETTING DETECTIONS');
          store.dispatch(SetCurrentDetections(detections));
          if (store.state.isTargeting) {
            var detectionsToCount = detections.where((detection) {
              var detectionName = detection.detectedClass;
              return store.state.objectRecords[detectionName].isCaught ==
                      false &&
                  detection.isTarget;
            }).toList();
            store.dispatch(AddTrackedDetections(detectionsToCount));
          }
        },
        'currentDetections': store.state.currentDetections,
        'objectRecords': store.state.objectRecords,
        'isDetecting': store.state.isDetecting,
        'isTargeting': store.state.isTargeting,
        'setDetectingStatus': (bool detectingStatus) {
          if (store.state.isTargeting) {
            store.dispatch(SetDetectingStatus(detectingStatus));
          }
        },
        'classifyingStatus': store.state.classifyingStatus,
        'setClassificationStatus': (ClassificationStatuses classifyingStatus) =>
            store.dispatch(SetClassificationStatus(classifyingStatus)),
        'addTargetDetectionFrame': (TargetDetectionFrame targetDetectionFrame) {
          if (store.state.isTargeting) {
            store.dispatch(AddTargetDetectionFrame(targetDetectionFrame));
          }
        },
        'targetDetectionFrames': store.state.targetDetectionFrames,
        'classifyingStatus': store.state.classifyingStatus,
        'objectToClassify': store.state.objectToClassify,
        'clearObjectToClassify': () => store.dispatch(ClearObjectToClassify),
        'setClassificationResult': (ClassificationResult result) =>
            store.dispatch(SetClassificationResult(result)),
        'clearClassificationResult': () =>
            store.dispatch(ClearClassificationResult())
      };
    }, builder: (context, props) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            (props['classifyingStatus'] == ClassificationStatuses.classifying)
                ? GeneralClassifier(
                    camera: camera,
                  )
                : Container(
                    child: Text('BBB'),
                  ),
            props['classifyingStatus'] == ClassificationStatuses.not_classifying
                ? Detector(
                    camera: camera,
                    setRecognitions: props["setDetections"],
                    screenHeight: screen.height,
                    screenWidth: screen.width,
                    objectRecords: props['objectRecords'],
                    setDetectingStatus: props['setDetectingStatus'],
                    isTargeting: props['isTargeting'],
                    addTargetDetectionFrame: props['addTargetDetectionFrame'],
                  )
                : Container(),
            props['classifyingStatus'] == ClassificationStatuses.not_classifying
                ? BoundingBox(
                    props["currentDetections"],
                    (selectedClass) => print('SELECTED CLASS: $selectedClass'),
                    props["isTargeting"],
                  )
                : Container(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InfoBox(
                  targetDetectionFrames: props['targetDetectionFrames']),
            ),
            (props['classifyingStatus'] != ClassificationStatuses.classifying)
                ? Target(
                    isDetecting: props["isDetecting"] && props["isTargeting"],
                    classifyingStatus: props["classifyingStatus"],
                  )
                : Container(),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 150.0),
          child: FloatingActionButton(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
    });
  }
}
