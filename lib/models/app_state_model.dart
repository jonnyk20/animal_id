import 'package:animal_id/models/detection_model.dart';

class AppState {
  final List<Detection> currentDetections;
  final List<Detection> trackedDetections;
  AppState({this.currentDetections, this.trackedDetections});
  static var initial = AppState(
    currentDetections: [],
    trackedDetections: [],
  );
}
