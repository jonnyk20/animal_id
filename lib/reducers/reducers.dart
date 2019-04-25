import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/reducers/current_detections_reducer.dart';
import 'package:animal_id/reducers/detected_objects_reducer.dart';
import 'package:animal_id/reducers/object_records_reducer.dart';
import 'package:animal_id/reducers/selected_object_reducer.dart';
import 'package:animal_id/reducers/detecting_status_reducer.dart';
import 'package:animal_id/reducers/targeting_status_reducer.dart';
import 'package:animal_id/reducers/saving_status_reducer.dart';
import 'package:animal_id/reducers/target_detection_frames_reducer.dart';

// Todo, restructure reducers to look like:
// https://github.com/brianegan/flutter_architecture_samples/blob/master/example/redux/lib/reducers/

AppState appReducers(AppState state, dynamic action) {
  return AppState(
    currentDetections:
        currentDetectionsReducer(state.currentDetections, action),
    detectedObjects: detectedObjectsReducer(state.detectedObjects, action),
    objectRecords: objectRecordsReducer(state.objectRecords, action),
    selectedObject: selelectedObjectRecordReducer(state.selectedObject, action),
    isDetecting: detectingStatusReducer(state.isDetecting, action),
    isTargeting: targetingStatusReducer(state.isTargeting, action),
    savingStatus: savingStatusReducer(state.savingStatus, action),
    targetDetectionFrames:
        targetDetectionFramesReducer(state.targetDetectionFrames, action),
  );
}
