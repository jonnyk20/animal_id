import 'package:flutter/material.dart';
import 'package:animal_id/models/detection_model.dart';

class BoundingBox extends StatelessWidget {
  final List<Detection> results;
  final bool isScanning;

  BoundingBox(
    this.results,
    this.isScanning,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBox() {
      return results.map((detection) {
        var color = (isScanning && detection.isTarget)
            ? Colors.green
            : detection.isTarget ? Colors.blue : Colors.white.withOpacity(0.5);

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
                "${detection.detectedClass} ${(detection.confidenceInClass * 100).toStringAsFixed(2)}%",
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
