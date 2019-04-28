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
  final ClassifyingStatuses classifyingStatus;
  final List<TargetDetectionFrame> targetDetectionFrames;
  final DetectedObject objectToClassify;

  AppState({
    this.currentDetections,
    this.detectedObjects,
    this.objectRecords,
    this.selectedObject,
    this.isDetecting = false,
    this.isTargeting = false,
    this.classifyingStatus = ClassifyingStatuses.not_classifying,
    this.targetDetectionFrames,
    this.objectToClassify,
  });
  static var initial = (objectInfo) => AppState(
        currentDetections: [],
        detectedObjects: {},
        objectRecords: objectInfo,
        targetDetectionFrames: [],
      );
}
