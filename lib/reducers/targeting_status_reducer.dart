import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final targetStatusReducer = combineReducers<bool>([
  TypedReducer<bool, UpdateTargetingStatus>(_updateTargetStatus),
]);

bool _updateTargetStatus(bool state, UpdateTargetingStatus action) {
  return action.targetingStatus;
}
