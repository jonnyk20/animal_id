import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/detected_object_model.dart';

final objectToClassifyReducer = combineReducers<DetectedObject>([
  TypedReducer<DetectedObject, SetObjectToClassify>(_setObjectToClassify),
  TypedReducer<DetectedObject, ClearObjectToClassify>(_clearObjectToClassify),
]);

DetectedObject _setObjectToClassify(
    DetectedObject state, SetObjectToClassify action) {
  return action.objectToClassify;
}

DetectedObject _clearObjectToClassify(DetectedObject state, action) => null;
