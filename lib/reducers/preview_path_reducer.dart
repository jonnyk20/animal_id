import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final previewPathReducer = combineReducers<String>([
  TypedReducer<String, SetPreviewPath>(_setPreviewPath),
]);

String _setPreviewPath(String state, SetPreviewPath action) {
  return action.previewPath;
}
