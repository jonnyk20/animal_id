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
                  width: 200,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
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
        ),
      ),
    );
  }
}
