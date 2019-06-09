import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/models/image_preview_model.dart';
import 'package:animal_id/constants/constants.dart';

class AppState {
  final List<Detection> currentDetections;
  final Map<String, DetectedObject> detectedObjects;
  final Map<String, ObjectRecord> objectRecords;
  final ObjectRecord selectedObject;
  final bool isTargeting;
  final bool isScanning;
  final ClassificationStatuses classifyingStatus;
  final List<TargetDetectionFrame> targetDetectionFrames;
  final DetectedObject objectToClassify;
  final ClassificationResult classificationResult;
  final ClassifyModes classifyMode;
  final ImagePreview imagePreview;

  AppState({
    this.currentDetections,
    this.detectedObjects,
    this.objectRecords,
    this.selectedObject,
    this.isTargeting = false,
    this.isScanning = false,
    this.classifyingStatus = ClassificationStatuses.not_classifying,
    this.targetDetectionFrames,
    this.objectToClassify,
    this.classificationResult,
    this.classifyMode = ClassifyModes.photo,
    this.imagePreview,
  });

  static var initial = (objectInfo) => AppState(
        currentDetections: [],
        detectedObjects: {},
        objectRecords: objectInfo,
        targetDetectionFrames: [],
      );
}
