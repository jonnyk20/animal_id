import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animal_id/models/detected_object_model.dart';

class DetectionLabel extends StatelessWidget {
  final DetectedObject detectedObject;
  final Function catchObject;

  DetectionLabel({
    this.detectedObject,
    this.catchObject,
  });

  @override
  Widget build(BuildContext context) {
    var progress = math.min((detectedObject.count) / 10, 1).toDouble();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
                'Detecting ${detectedObject.name} - ${(progress * 100).toInt()}%'),
            Container(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
              ),
            )
          ],
        ),
        RaisedButton(
          child: Text('catch'),
          color: Colors.green,
          onPressed: (detectedObject.count >= 10)
              ? () => catchObject(detectedObject)
              : null,
        )
      ],
    );
  }
}
