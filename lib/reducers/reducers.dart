import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/reducers/current_detections_reducer.dart';
import 'package:animal_id/reducers/tracked_detections_reducer.dart';

// Todo, restructure reducers to look like:
// https://github.com/brianegan/flutter_architecture_samples/blob/master/example/redux/lib/reducers/

AppState appReducers(AppState state, dynamic action) {
  return AppState(
    currentDetections:
        currentDetectionsReducer(state.currentDetections, action),
    trackedDetections:
        trackedDetectionsReducer(state.trackedDetections, action),
  );
}
