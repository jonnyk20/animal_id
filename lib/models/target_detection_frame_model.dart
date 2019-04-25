import 'dart:typed_data';

class TargetDetectionFrame {
  final List<Uint8List> bytesList;
  final String detectionName;
  TargetDetectionFrame({
    this.bytesList,
    this.detectionName,
  });
}
