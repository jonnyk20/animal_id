import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';

final savingStatusReducer = combineReducers<SavingStatuses>([
  TypedReducer<SavingStatuses, SetSavingStatus>(_setSavingStatus),
]);

SavingStatuses _setSavingStatus(SavingStatuses state, SetSavingStatus action) {
  return action.savingStatus;
}
