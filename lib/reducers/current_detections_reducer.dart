import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detection_model.dart';

final currentDetectionsReducer = combineReducers<List<Detection>>([
  TypedReducer<List<Detection>, SetCurrentDetections>(_setCurrentDetections),
  TypedReducer<List<Detection>, ClearDetectionStates>(_clearCurrentDetections),
]);

List<Detection> _setCurrentDetections(List<Detection> state, action) {
  return action.currentDetections;
}

List<Detection> _clearCurrentDetections(List<Detection> state, action) {
  return List<Detection>();
}
