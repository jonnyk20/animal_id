import 'package:animal_id/models/detection_model.dart';

class SetCurrentDetections {
  final List<Detection> detections;
  SetCurrentDetections(this.detections);
}

class AddTrackedDetections {
  final List<Detection> detections;
  AddTrackedDetections(this.detections);
}

class ReduceObjecDetectionCounts {}

class ReduceTrackedDetectionCounts {}
