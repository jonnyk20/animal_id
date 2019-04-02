import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/detected_object_model.dart';

class AppState {
  final List<Detection> currentDetections;
  final Map<String, DetectedObject> detectedObjects;

  AppState({
    this.currentDetections,
    this.detectedObjects,
  });
  static var initial = AppState(
    currentDetections: [],
    detectedObjects: {},
  );
}
