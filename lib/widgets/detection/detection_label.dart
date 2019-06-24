import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'dart:io' show Platform;

int maxCount = Platform.isAndroid ? 5 : 10;

// (JK), catchObject shoudn't be fired from in here
class DetectionLabel extends StatelessWidget {
  final DetectedObject detectedObject;
  final Function catchObject;
  final bool canSave;

  DetectionLabel({
    this.detectedObject,
    this.catchObject,
    this.canSave,
  });

  @override
  Widget build(BuildContext context) {
    var progress = math.min((detectedObject.count) / maxCount, 1).toDouble();
    if (canSave && (detectedObject.count == maxCount)) {
      catchObject(detectedObject);
    }
    return Card(
      color: Colors.blue,
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Detecting ${detectedObject.name} - ${(progress * 100).toInt()}%',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: 250,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    value: progress,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
