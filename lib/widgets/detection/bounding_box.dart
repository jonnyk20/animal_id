import 'package:flutter/material.dart';
import 'package:animal_id/models/detection_model.dart';

class BoundingBox extends StatelessWidget {
  final List<Detection> results;
  final bool isTargeting;

  BoundingBox(
    this.results,
    this.isTargeting,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBox() {
      return results.map((detection) {
        var color =
            (isTargeting && detection.isTarget) ? Colors.green : Colors.white;

        return Positioned(
            left: detection.left,
            top: detection.top,
            width: detection.width,
            height: detection.height,
            child: Container(
              padding: EdgeInsets.only(top: 5.0, left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 3.0,
                ),
              ),
              child: Text(
                "${detection.detectedClass} ${(detection.confidenceInClass * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  color: color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ));
      }).toList();
    }

    return Stack(
      children: _renderBox(),
    );
  }
}
