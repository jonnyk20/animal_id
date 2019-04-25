import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/constants/constants.dart';

class AppState {
  final List<Detection> currentDetections;
  final Map<String, DetectedObject> detectedObjects;
  final Map<String, ObjectRecord> objectRecords;
  final ObjectRecord selectedObject;
  final bool isDetecting;
  final bool isTargeting;
  final SavingStatuses savingStatus;
  final List<TargetDetectionFrame> targetDetectionFrames;

  AppState({
    this.currentDetections,
    this.detectedObjects,
    this.objectRecords,
    this.selectedObject,
    this.isDetecting = false,
    this.isTargeting = false,
    this.savingStatus = SavingStatuses.not_saving,
    this.targetDetectionFrames,
  });
  static var initial = (objectInfo) => AppState(
        currentDetections: [],
        detectedObjects: {},
        objectRecords: objectInfo,
        targetDetectionFrames: [],
      );
}
