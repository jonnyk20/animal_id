import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final detectingStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetDetectingStatus>(_setDetectingStatus),
  TypedReducer<bool, ClearDetectionStates>(_clearDetectingStatus),
]);

bool _setDetectingStatus(bool state, SetDetectingStatus action) {
  return action.detectingStatus;
}
bool _clearDetectingStatus(bool state, ClearDetectionStates action) {
  return false;
}
