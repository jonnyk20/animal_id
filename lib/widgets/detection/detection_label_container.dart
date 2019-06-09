import 'package:flutter/material.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detection/detections_list.dart';

class InfoBox extends StatelessWidget {
  final List<TargetDetectionFrame> targetDetectionFrames;

  InfoBox({
    this.targetDetectionFrames,
  });

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      var detectedObjects = store.state.detectedObjects.keys
          .map<DetectedObject>((key) => store.state.detectedObjects[key])
          .toList();
      detectedObjects.sort((a, b) {
        return b.count.compareTo(a.count);
      });
      return {
        'clearDetections': () => store.dispatch(ReduceObjecDetectionCounts()),
        'detectedObjects': detectedObjects,
        'initiateClassification': (detectionName) {
          store.dispatch(RemoveTrackedDetection(detectionName));
        },
        'canSave': store.state.classifyingStatus ==
            ClassificationStatuses.not_classifying,
        'setClassificationStatus': (ClassificationStatuses classifyingStatus) =>
            store.dispatch(SetClassificationStatus(classifyingStatus)),
        'setScanningStatus': (bool scanningStatus) =>
            store.dispatch(SetScanningStatus(scanningStatus)),
        'setTargetingStatus': (bool scanningStatus) =>
            store.dispatch(SetTargetingStatus(scanningStatus)),
        'clearTargetingAndDetectiongStatuses': () {
          store.dispatch(SetScanningStatus(false));
          store.dispatch(SetTargetingStatus(false));
        },
        'classifyingStatus': store.state.classifyingStatus,
        'setObjectToClassify': (DetectedObject objectToClassify) =>
            store.dispatch(SetObjectToClassify(objectToClassify)),
      };
    }, builder: (context, props) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  props['setScanningStatus'](true);
                },
                onTapUp: (details) {
                  props['setScanningStatus'](false);
                },
                child: Card(
                  color: Colors.blue,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 100.0,
                    child: Text(
                      'Find a Dog',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            DetectionsList(
              detectedObjects: props['detectedObjects'],
              initiateClassification: props['initiateClassification'],
              canSave: props['canSave'],
              setClassificationStatus: props['setClassificationStatus'],
              clearTargetingAndDetectiongStatuses:
                  props['clearTargetingAndDetectiongStatuses'],
              setObjectToClassify: props['setObjectToClassify'],
            )
          ],
        ),
      );
    });
  }
}
