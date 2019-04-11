import 'package:flutter/material.dart';

class Target extends StatelessWidget {
  final bool isTargeting;
  Target(this.isTargeting);
  Widget build(BuildContext context) {
    Color color = (isTargeting ? Colors.green : Colors.white).withOpacity(0.5);
    return Center(
      child: Container(
        alignment: FractionalOffset(0.5, 0.4),
        child: Container(
          // constraints: BoxConstraints(maxHeight: 50.0, maxWidth: 50.0),
          height: 50.0,
          width: 50.0,
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
    );
  }
}
