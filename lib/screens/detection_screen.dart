import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/detector.dart';
import 'package:animal_id/info_box.dart';
import 'package:animal_id/bounding_box.dart';
import 'package:animal_id/target.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/actions/actions.dart';

class DetectionScreen extends StatelessWidget {
  final CameraDescription camera;

  DetectionScreen(this.camera);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'addDetections': (List<Detection> detections) {
          store.dispatch(SetCurrentDetections(detections));
          var detectionsToCount = detections.where((detection) {
            var detectionName = detection.detectedClass;
            return store.state.objectRecords[detectionName].isCaught == false;
          }).toList();
          store.dispatch(AddTrackedDetections(detectionsToCount));
        },
        'currentDetections': store.state.currentDetections,
        'objectRecords': store.state.objectRecords,
        'isTargeting': store.state.isTargeting,
        'updateTargetingState': (bool targetingState) =>
            store.dispatch(UpdateTargetingStatus(targetingState)),
      };
    }, builder: (context, props) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Detector(
                camera,
                props["addDetections"],
                screen.height,
                screen.width,
                props["objectRecords"],
                props["updateTargetingState"]),
            BoundingBox(
              props["currentDetections"],
              (selectedClass) => print('SELECTED CLASS: $selectedClass'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InfoBox("[Selected Class]"),
            ),
            Target(props["isTargeting"]),
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
