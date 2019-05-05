import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/classification_result_model.dart';

final classificationResultReducer = combineReducers<ClassificationResult>([
  TypedReducer<ClassificationResult, SetClassificationResult>(
      _setClassificationResult),
  TypedReducer<ClassificationResult, ClearClassificationResult>(
      _clearClassificationResult),
]);

ClassificationResult _setClassificationResult(
    ClassificationResult state, SetClassificationResult action) {
  return action.classificationResult;
}

ClassificationResult _clearClassificationResult(
        ClassificationResult state, action) =>
    null;
