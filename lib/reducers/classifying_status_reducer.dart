import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';

final classifyingStatusReducer = combineReducers<ClassificationStatuses>([
  TypedReducer<ClassificationStatuses, SetClassificationStatus>(
      _setClassificationStatus),
]);

ClassificationStatuses _setClassificationStatus(
    ClassificationStatuses state, SetClassificationStatus action) {
  return action.classifyingStatus;
}
