import 'dart:math' as math;
import 'package:animal_id/models/detection_model.dart';

final List<String> validClasses = ['dog', 'cat'];
final String generalClass = 'dog';

List<Detection> filterAndGeneralizeDetections(List<Detection> detections) {
  List<Detection> filteredAndGeneralizedDetections = List<Detection>();
  detections.forEach((Detection detection) {
    String detectedClass = detection.detectedClass;
    if (validClasses.contains(detectedClass)) {
      Detection generalizedDetection = Detection(
        detectedClass: generalClass,
        left: detection.left,
        top: detection.top,
        width: detection.width,
        height: detection.height,
        confidenceInClass: detection.confidenceInClass,
        isTarget: detection.isTarget,
        rawLeft: detection.rawLeft,
        rawTop: detection.rawTop,
        rawHeight: detection.rawHeight,
        rawWidth: detection.rawWidth,
      );
      filteredAndGeneralizedDetections.add(generalizedDetection);
    }
  });
  return filteredAndGeneralizedDetections;
}

formatDetections(
  detections,
  previewH,
  previewW,
  screenH,
  screenW,
) {
  var smallestTarget = {};
  List<Detection> formattedDetectionsList = [];

  Map<int, dynamic> formattedDetectionsMap = detections.asMap();
  formattedDetectionsMap.forEach((index, re) {
    var _x = re["rect"]["x"];
    var _w = re["rect"]["w"];
    var _y = re["rect"]["y"];
    var _h = re["rect"]["h"];
    double scaleW, scaleH, x, y, w, h;

    if (screenH / screenW > previewH / previewW) {
      scaleW = screenH / previewH * previewW;
      scaleH = screenH;
      var difW = (scaleW - screenW) / scaleW;
      x = (_x - difW / 2) * scaleW;
      w = _w * scaleW;
      if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
      y = _y * scaleH;
      h = _h * scaleH;
    } else {
      scaleH = screenW / previewW * previewH;
      scaleW = screenW;
      var difH = (scaleH - screenH) / scaleH;
      x = _x * scaleW;
      w = _w * scaleW;
      y = (_y - difH / 2) * scaleH;
      h = _h * scaleH;
      if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
    }

    var screenWHalf = (screenW / 2);
    var screenH40P = screenH * 0.4;
    var targetWidthHalf = 25;
    var targetHeightHalf = 25;
    var hitsTargetHorzontally = ((x + w) > (screenWHalf - targetWidthHalf)) &&
        (x < screenWHalf + targetWidthHalf);
    var hitsTargetVertically = (y + h > screenH40P - targetHeightHalf) &&
        (y < screenH40P + targetHeightHalf);
    var inTargetArea = hitsTargetHorzontally && hitsTargetVertically;
    var area = w * h;
    var isTarget = false;
    if (inTargetArea &&
        (smallestTarget.isEmpty || smallestTarget["area"] > area)) {
      smallestTarget = {
        "area": area,
        "index": index,
      };
    }

    formattedDetectionsList.add(Detection(
      left: math.max(0, x).toDouble(),
      top: math.max(0, y).toDouble(),
      width: w.toDouble(),
      height: h.toDouble(),
      detectedClass: re["detectedClass"],
      confidenceInClass: re["confidenceInClass"],
      isTarget: isTarget,
      rawLeft: _x,
      rawTop: _y,
      rawHeight: _h,
      rawWidth: _w,
    ));
  });
  if (smallestTarget.isNotEmpty) {
    formattedDetectionsList[smallestTarget["index"]].isTarget = true;
  }
  return filterAndGeneralizeDetections(formattedDetectionsList);
}
