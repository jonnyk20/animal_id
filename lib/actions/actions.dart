import 'package:animal_id/models/detection_model.dart';

class SetCurrentDetections {
  final List<Detection> detections;
  SetCurrentDetections(this.detections);
}

class AddTrackedDetections {
  final List<Detection> detections;
  AddTrackedDetections(this.detections);
}

class RemoveTrackedDetection {
  final String detectedObjectName;
  RemoveTrackedDetection(this.detectedObjectName);
}

class ReduceObjecDetectionCounts {}

class ReduceTrackedDetectionCounts {}

class SaveDetection {
  final String detectionName;
  SaveDetection(
    this.detectionName,
  );
}
