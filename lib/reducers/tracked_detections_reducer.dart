import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detection_model.dart';

final trackedDetectionsReducer = combineReducers<List<Detection>>([
  TypedReducer<List<Detection>, AddTrackedDetections>(_addTrackedDetections),
  TypedReducer<List<Detection>, ClearTrackedDetections>(
      _clearTrackedDetections),
]);

List<Detection> _addTrackedDetections(List<Detection> state, action) {
  var detections = List<Detection>.from(state);
  detections.addAll(action.detections);
  detections = detections.where((detection) {
    return detection.isTarget && detection.detectedClass == "cup";
  }).toList();
  return detections;
}

List<Detection> _clearTrackedDetections(List<Detection> state, action) {
  return [];
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
