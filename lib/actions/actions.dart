import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/models/image_preview_model.dart';
import 'package:animal_id/constants/constants.dart';

class SetCurrentDetections {
  final List<Detection> currentDetections;
  SetCurrentDetections(this.currentDetections);
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

class SetClassificationStatus {
  final ClassificationStatuses classifyingStatus;
  SetClassificationStatus(this.classifyingStatus);
}

class SelectObjectRecord {
  final ObjectRecord objectRecord;
  SelectObjectRecord(this.objectRecord);
}

class SetDetectingStatus {
  final bool detectingStatus;
  SetDetectingStatus(this.detectingStatus);
}

class SetTargetingStatus {
  final bool targetingStatus;
  SetTargetingStatus(this.targetingStatus);
}

class AddTargetDetectionFrame {
  final TargetDetectionFrame targetDetectionFrame;
  AddTargetDetectionFrame(this.targetDetectionFrame);
}

class ClearTargetDetectionFrames {}

class SetObjectToClassify {
  final DetectedObject objectToClassify;
  SetObjectToClassify(this.objectToClassify);
}

class ClearObjectToClassify {}

class SetClassificationResult {
  final ClassificationResult classificationResult;
  SetClassificationResult(this.classificationResult);
}

class ClearClassificationResult {}

class ClearDetectionStates {}

class SetImagePreview {
  final ImagePreview imagePreview;
  SetImagePreview(this.imagePreview);
}
