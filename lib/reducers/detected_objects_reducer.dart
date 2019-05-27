import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/detection_model.dart';

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
  List<Detection> targetDetections =
      action.detections.where((detection) => detection.isTarget).toList();
  targetDetections.forEach((detection) {
    var detectedClass = detection.detectedClass;
    if (detections[detectedClass] == null) {
      detections[detectedClass] = DetectedObject(
          name: detectedClass, count: 1, lastTargetDection: detection);
    } else if (detections[detectedClass].count < 15) {
      detections[detectedClass] = DetectedObject(
        name: detectedClass,
        count: detections[detectedClass].count + 1,
        lastTargetDection: detection,
      );
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
    DetectedObject detection = state[k];
    if (detection.count > 0) {
      updatedDetections[k] = DetectedObject(
          name: detection.name,
          count: detection.count - 1,
          lastTargetDection: detection.lastTargetDection);
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
