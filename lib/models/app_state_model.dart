import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/object_record_model.dart';

class AppState {
  final List<Detection> currentDetections;
  final Map<String, DetectedObject> detectedObjects;
  final Map<String, ObjectRecord> objectRecords;
  final ObjectRecord selectedObject;
  final bool isTargeting;

  AppState({
    this.currentDetections,
    this.detectedObjects,
    this.objectRecords,
    this.selectedObject,
    this.isTargeting = false,
  });
  static var initial = (objectInfo) => AppState(
        currentDetections: [],
        detectedObjects: {},
        objectRecords: objectInfo,
      );
}
