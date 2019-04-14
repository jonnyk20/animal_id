import 'package:flutter/material.dart';
import 'package:animal_id/widgets/target/detecting_target.dart';
import 'package:animal_id/widgets/target/saving_target.dart';
import 'package:animal_id/widgets/target/pulse.dart';

class Target extends StatelessWidget {
  final bool isTargeting;
  final bool isSaving;
  Target({
    this.isTargeting,
    this.isSaving,
  });

  Widget build(BuildContext context) {
    Color color = (isTargeting ? Colors.green : Colors.white).withOpacity(0.5);
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
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: color,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            // DetectingTarget(),
            Positioned(
              top: top - 0,
              child: Pulse(50),
            ),
            !isSaving
                ? Container()
                : Positioned(
                    top: top - 50,
                    child: Pulse(150),
                  ),
            // Pulse(),
          ],
        ),
      ),
    );
  }
}
