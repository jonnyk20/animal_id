import 'package:flutter/material.dart';
import 'package:animal_id/widgets/target/pulse.dart';
import 'package:animal_id/constants/constants.dart';

class Target extends StatelessWidget {
  final bool isTargeting;
  final bool isScanning;
  final ClassificationStatuses classifyingStatus;
  Target({
    this.isTargeting,
    this.isScanning,
    this.classifyingStatus,
  });

  Widget build(BuildContext context) {
    Color color = (isTargeting && isScanning)
        ? Colors.green
        : isTargeting ? Colors.blue : Colors.white;

    Size screen = MediaQuery.of(context).size;
    double targetSize = 50;
    double top = (screen.height * 0.4) - (targetSize / 2);
    return Center(
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: top,
              child: Container(
                height: targetSize,
                width: targetSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            isTargeting && isScanning
                ? Positioned(
                    top: top - 0,
                    child: Pulse(50),
                  )
                : Container(),
            classifyingStatus ==
                    ClassificationStatuses.initiating_classification
                ? Positioned(
                    top: top - 50,
                    child: Pulse(150),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
