import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('This is an info box'),
      color: Colors.blue,
      padding: new EdgeInsets.all(40.0),
      constraints: BoxConstraints(
        maxHeight: 300.0,
        minHeight: 300.0,
      ),
    );
  }
}
