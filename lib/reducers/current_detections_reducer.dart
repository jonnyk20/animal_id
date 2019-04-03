import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detection_model.dart';

final currentDetectionsReducer = combineReducers<List<Detection>>([
  TypedReducer<List<Detection>, SetCurrentDetections>(_addDetections),
]);

List<Detection> _addDetections(List<Detection> state, action) {
  return action.detections;
}
