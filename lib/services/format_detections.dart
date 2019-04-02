import 'dart:math' as math;
import 'package:animal_id/models/detection_model.dart';

formatDetections(
  detections,
  previewH,
  previewW,
  screenH,
  screenW,
) {
  return detections.map<Detection>((re) {
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
    var isTarget = hitsTargetHorzontally && hitsTargetVertically;

    return Detection(
      left: math.max(0, x).toDouble(),
      top: math.max(0, y).toDouble(),
      width: w.toDouble(),
      height: h.toDouble(),
      detectedClass: re["detectedClass"],
      confidenceInClass: re["confidenceInClass"],
      isTarget: isTarget,
    );
  }).toList();
}
