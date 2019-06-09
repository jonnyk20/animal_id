import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final targetingStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetTargetingStatus>(_setTargetingStatus),
  TypedReducer<bool, ClearDetectionStates>(_clearTargetingStatus),
]);

bool _setTargetingStatus(bool state, SetTargetingStatus action) {
  return action.targetingStatus;
}

bool _clearTargetingStatus(bool state, ClearDetectionStates action) {
  return false;
}
