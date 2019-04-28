import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';

final classifyingStatusReducer = combineReducers<ClassifyingStatuses>([
  TypedReducer<ClassifyingStatuses, SetClassifyingStatus>(
      _setClassifyingStatus),
]);

ClassifyingStatuses _setClassifyingStatus(
    ClassifyingStatuses state, SetClassifyingStatus action) {
  return action.classifyingStatus;
}
