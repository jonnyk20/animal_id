import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  VerticalSpace(this.height);
  Widget build(BuildContext context) {
    return Container(height: height);
  }
}
