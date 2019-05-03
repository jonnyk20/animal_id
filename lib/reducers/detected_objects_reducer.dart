import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detected_object_model.dart';

final detectedObjectsReducer = combineReducers<Map<String, DetectedObject>>([
  TypedReducer<Map<String, DetectedObject>, AddTrackedDetections>(
      _increaseObjectDetectionCounts),
  TypedReducer<Map<String, DetectedObject>, ReduceObjecDetectionCounts>(
      _reduceDetectedObjectCounts),
  TypedReducer<Map<String, DetectedObject>, RemoveTrackedDetection>(
      _removeDetectedObject),
  TypedReducer<Map<String, DetectedObject>, ClearDetectionStates>(
      _clearDetectedObject),
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

Map<String, DetectedObject> _removeDetectedObject(
    Map<String, DetectedObject> state, RemoveTrackedDetection action) {
  if (state.isEmpty) {
    return state;
  }
  var updatedDetections = Map<String, DetectedObject>.from(state);
  updatedDetections.remove(action.detectedObjectName);
  return updatedDetections;
}

Map<String, DetectedObject> _clearDetectedObject(
    Map<String, DetectedObject> state, ClearDetectionStates action) {
  return Map<String, DetectedObject>();
}

/*
import 'dart:math' as math;
import 'dart:async';

main() {
  const oneSec = const Duration(seconds:1);
  const fiveSec = const Duration(seconds:5);
  var interval = Timer.periodic(oneSec, (Timer t) => print('hi!'));
  var timer = Timer(fiveSec, () => interval.cancel());
}
*/
