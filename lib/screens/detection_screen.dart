import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detection/detector.dart';
import 'package:animal_id/widgets/detection/detection_label_container.dart';
import 'package:animal_id/widgets/detection/bounding_box.dart';
import 'package:animal_id/widgets/target/target.dart';
import 'package:animal_id/widgets/classification/general_classifier.dart';

class DetectionScreen extends StatelessWidget {
  final CameraDescription camera;

  DetectionScreen(this.camera);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'setDetections': (List<Detection> detections) {
          store.dispatch(SetCurrentDetections(detections));
          if (store.state.isScanning) {
            var detectionsToCount = detections.where((detection) {
              return detection.isTarget;
            }).toList();
            store.dispatch(AddTrackedDetections(detectionsToCount));
          }
        },
        'currentDetections': store.state.currentDetections,
        'objectRecords': store.state.objectRecords,
        'isTargeting': store.state.isTargeting,
        'isScanning': store.state.isScanning,
        'setTargetingStatus': (bool targetingStatus) {
          store.dispatch(SetTargetingStatus(targetingStatus));
        },
        'classifyingStatus': store.state.classifyingStatus,
        'setClassificationStatus': (ClassificationStatuses classifyingStatus) =>
            store.dispatch(SetClassificationStatus(classifyingStatus)),
        'addTargetDetectionFrame': (TargetDetectionFrame targetDetectionFrame) {
          if (store.state.isScanning) {
            store.dispatch(AddTargetDetectionFrame(targetDetectionFrame));
          }
        },
        'targetDetectionFrames': store.state.targetDetectionFrames,
        'classifyingStatus': store.state.classifyingStatus,
        'objectToClassify': store.state.objectToClassify,
        'clearObjectToClassify': () => store.dispatch(ClearObjectToClassify),
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
                : Container(),
            props['classifyingStatus'] == ClassificationStatuses.not_classifying
                ? Detector(
                    camera: camera,
                    setRecognitions: props["setDetections"],
                    screenHeight: screen.height,
                    screenWidth: screen.width,
                    setTargetingStatus: props['setTargetingStatus'],
                    isScanning: props['isScanning'],
                    addTargetDetectionFrame: props['addTargetDetectionFrame'],
                  )
                : Container(),
            props['classifyingStatus'] == ClassificationStatuses.not_classifying
                ? BoundingBox(
                    props["currentDetections"],
                    props["isScanning"],
                  )
                : Container(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DetectionLabelContainer(
                  targetDetectionFrames: props['targetDetectionFrames']),
            ),
            (props['classifyingStatus'] != ClassificationStatuses.classifying)
                ? Target(
                    isTargeting: props["isTargeting"],
                    isScanning: props["isScanning"],
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
