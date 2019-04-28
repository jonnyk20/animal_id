import 'package:redux/redux.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/actions/actions.dart';

final targetDetectionFramesReducer =
    combineReducers<List<TargetDetectionFrame>>([
  TypedReducer<List<TargetDetectionFrame>, AddTargetDetectionFrame>(
      _addTargetDetectionFrame),
  TypedReducer<List<TargetDetectionFrame>, ClearTargetDetectionFrames>(
      _clearDetectionFrames),
]);

List<TargetDetectionFrame> _addTargetDetectionFrame(
    List<TargetDetectionFrame> state, AddTargetDetectionFrame action) {
  final List<TargetDetectionFrame> updatedTargetDetectionFrames =
      List<TargetDetectionFrame>.from(state);
  updatedTargetDetectionFrames.add(action.targetDetectionFrame);
  return updatedTargetDetectionFrames;
}

List<TargetDetectionFrame> _clearDetectionFrames(
    List<TargetDetectionFrame> state, ClearTargetDetectionFrames action) {
  return List<TargetDetectionFrame>();
}
