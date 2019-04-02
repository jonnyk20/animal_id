import 'package:flutter/material.dart';

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final Function selectClass;

  BoundingBox(
    this.results,
    this.selectClass,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBox() {
      return results.map((re) {
        var color =
            re["isHot"] ? Colors.green : Color.fromRGBO(37, 213, 253, 1.0);

        return Positioned(
            left: re["left"],
            top: re["top"],
            width: re["width"],
            height: re["height"],
            child: GestureDetector(
              onTap: () {
                selectClass(re["detectedClass"]);
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
                  "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
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
