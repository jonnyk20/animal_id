import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/constants/constants.dart';

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

class SetSavingStatus {
  final SavingStatuses savingStatus;
  SetSavingStatus(this.savingStatus);
}

class SelectObjectRecord {
  final ObjectRecord objectRecord;
  SelectObjectRecord(this.objectRecord);
}

class SetTargetingStatus {
  final bool targetingStatus;
  SetTargetingStatus(this.targetingStatus);
}
