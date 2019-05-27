import 'package:animal_id/models/detection_model.dart';

class DetectedObject {
  final String name;
  final int count;
  final Detection lastTargetDection;

  DetectedObject({
    this.name,
    this.count,
    this.lastTargetDection,
  });
}
