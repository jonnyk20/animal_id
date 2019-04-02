import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detected_object_model.dart';

final detectedObjectsReducer = combineReducers<Map<String, DetectedObject>>([
  TypedReducer<Map<String, DetectedObject>, AddTrackedDetections>(
      _increaseObjectDetectionCounts),
  TypedReducer<Map<String, DetectedObject>, ReduceObjecDetectionCounts>(
      _reduceDetectedObjectCounts),
]);

Map<String, DetectedObject> _increaseObjectDetectionCounts(
    Map<String, DetectedObject> state, AddTrackedDetections action) {
  var detections = Map<String, DetectedObject>.from(state);
  var targetDetections =
      action.detections.where((detection) => detection.isTarget).toList();
  targetDetections.forEach((detection) {
    var detectedClass = detection.detectedClass;
    if (detections[detectedClass] == null) {
      detections[detectedClass] = DetectedObject(detectedClass, 1);
    } else if (detections[detectedClass].count < 15) {
      detections[detectedClass] =
          DetectedObject(detectedClass, detections[detectedClass].count + 1);
    }
  });

  return detections;
}

Map<String, DetectedObject> _reduceDetectedObjectCounts(
    Map<String, DetectedObject> state, action) {
  if (state.isEmpty) {
    return state;
  }
  var updatedDetections = Map<String, DetectedObject>();
  state.keys.forEach((k) {
    var detection = state[k];
    if (detection.count > 0) {
      updatedDetections[k] =
          DetectedObject(detection.name, detection.count - 1);
    }
  });
  return updatedDetections;
}

/*
import 'dart:math' as math;
import 'dart:async';

main() {
  const oneSec = const Duration(seconds:1);
  const fiveSec = const Duration(seconds:5);
  var interval = Timer.periodic(oneSec, (Timer t) => print('hi!'));
  var timer = new Timer(fiveSec, () => interval.cancel());
}
*/
