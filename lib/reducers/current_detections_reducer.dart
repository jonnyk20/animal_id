import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detection_model.dart';

final currentDetectionsReducer = combineReducers<List<Detection>>([
  TypedReducer<List<Detection>, SetCurrentDetections>(_addDetections),
]);

List<Detection> _addDetections(List<Detection> state, action) {
  var detections = List<Detection>.from(state);
  detections.addAll(action.detections);
  detections = detections.where((detection) {
    return detection.detectedClass == "cup";
  }).toList();
  var newDetections = action.detections.where((detection) {
    return detection.detectedClass == "cup";
  }).toList();
  return newDetections;
}
