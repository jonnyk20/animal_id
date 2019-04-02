import 'package:animal_id/models/detection.dart';

class AppState {
  final List<Detection> detections;
  AppState({this.detections});
  static var initial = AppState(
    detections: [],
  );
}
