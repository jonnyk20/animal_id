import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/detection_label.dart';

class InfoBox extends StatelessWidget {
  final String selectedClass;
  InfoBox(this.selectedClass);

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      var dectedObjects = store.state.detectedObjects.keys
          .map<DetectedObject>((key) => store.state.detectedObjects[key])
          .toList();
      return {
        'clearDetections': () => store.dispatch(ReduceObjecDetectionCounts()),
        'detectedObjects': dectedObjects
      };
    }, builder: (context, props) {
      return Column(
        children: props["detectedObjects"]
            .map<Widget>((DetectedObject detectedObject) {
          return DetectionLabel(
            detectedObject: detectedObject,
            catchObject: (detectedObject) =>
                print('CATCHING: ${detectedObject.name}'),
          );
        }).toList(),
      );
    });
  }
}
