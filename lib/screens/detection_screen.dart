import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detector.dart';
import 'package:animal_id/widgets/fake_detector.dart';
import 'package:animal_id/widgets/info_box.dart';
import 'package:animal_id/widgets/bounding_box.dart';
import 'package:animal_id/widgets/target/target.dart';
import 'package:animal_id/widgets/fake_Save_button.dart';

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
            store.dispatch(SetTargetingStatus(targetingState)),
        'savingStatus': store.state.savingStatus,
        'setSavingStatus': (SavingStatuses savingStatus) =>
            store.dispatch(SetSavingStatus(savingStatus))
      };
    }, builder: (context, props) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            // Detector(
            //   camera,
            //   props["addDetections"],
            //   screen.height,
            //   screen.width,
            //   props["objectRecords"],
            //   props["updateTargetingState"],
            // ),
            FakeDetector(),
            BoundingBox(
              props["currentDetections"],
              (selectedClass) => print('SELECTED CLASS: $selectedClass'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InfoBox(),
            ),
            Target(
              isTargeting: props["isTargeting"],
              savingStatus: props["savingStatus"],
            ),
            FakeSaveButton(
              savingStatus: props["savingStatus"],
              setSavingStatus: props["setSavingStatus"],
            )
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
