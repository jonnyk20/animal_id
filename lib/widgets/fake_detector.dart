import 'package:flutter/material.dart';

class FakeDetector extends StatelessWidget {
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
