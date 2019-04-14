import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final savingStatusReducer = combineReducers<bool>([
  TypedReducer<bool, ChangeSavingStatus>(_changeSavingStatus),
]);

bool _changeSavingStatus(bool state, ChangeSavingStatus action) {
  return action.savingStatus;
}
