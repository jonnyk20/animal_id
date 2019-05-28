import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/image_preview_model.dart';

final imagePreviewReducer = combineReducers<ImagePreview>([
  TypedReducer<ImagePreview, SetImagePreview>(_setImagePreview),
]);

ImagePreview _setImagePreview(ImagePreview state, SetImagePreview action) {
  return action.imagePreview;
}
