import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String selectedClass;
  InfoBox(this.selectedClass);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: selectedClass.isEmpty
          ? Text('No selected classes')
          : Text('Selected: $selectedClass'),
      color: Colors.blue,
      padding: new EdgeInsets.all(40.0),
      constraints: BoxConstraints(
        maxHeight: 300.0,
        minHeight: 300.0,
      ),
    );
  }
}
