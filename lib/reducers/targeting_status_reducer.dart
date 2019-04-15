import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final targetStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetTargetingStatus>(_setTargetingStatus),
]);

bool _setTargetingStatus(bool state, SetTargetingStatus action) {
  return action.targetingStatus;
}
