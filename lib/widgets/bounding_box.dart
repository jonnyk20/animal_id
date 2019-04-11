import 'package:flutter/material.dart';
import 'package:animal_id/models/detection_model.dart';

class BoundingBox extends StatelessWidget {
  final List<Detection> results;
  final Function selectClass;

  BoundingBox(
    this.results,
    this.selectClass,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBox() {
      return results.map((detection) {
        var color = detection.isCaught
            ? Colors.white
            : detection.isTarget
                ? Colors.green
                : Color.fromRGBO(37, 213, 253, 1.0);

        return Positioned(
            left: detection.left,
            top: detection.top,
            width: detection.width,
            height: detection.height,
            child: GestureDetector(
              onTap: () {
                selectClass(detection.detectedClass);
              },
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
              ),
            ));
      }).toList();
    }

    return Stack(
      children: _renderBox(),
    );
  }
}
