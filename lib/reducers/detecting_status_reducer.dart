import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final detectingStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetDetectingStatus>(_setDetectingStatus),
]);

bool _setDetectingStatus(bool state, SetDetectingStatus action) {
  return action.detectingStatus;
}
