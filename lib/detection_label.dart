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
    return Container(
      child: Column(
        children: <Widget>[
          Text('Cup Detection Score: ${detectedObject.count}'),
          LinearProgressIndicator(
              value: math.min((detectedObject.count) / 10, 1)),
          RaisedButton(
            child: Text('catch'),
            color: Colors.green,
            onPressed: (detectedObject.count >= 10)
                ? () => catchObject(detectedObject)
                : null,
          )
        ],
      ),
      color: Colors.blue,
      padding: new EdgeInsets.all(40.0),
      height: 200.0,
    );
  }
}
