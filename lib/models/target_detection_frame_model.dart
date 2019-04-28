import 'dart:typed_data';

class TargetDetectionFrame {
  final List<Uint8List> bytesList;
  final String detectionName;
  final int height;
  final int width;

  TargetDetectionFrame({
    this.bytesList,
    this.detectionName,
    this.height,
    this.width,
  });
}
