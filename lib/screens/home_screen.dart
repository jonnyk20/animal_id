import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

loadNewModel() async {
  print('------LOADING NEW MODEL');
  var res = await Tflite.loadModel(
    model: "assets/models/classification/model.tflite",
    labels: "assets/models/classification/labels.txt",
  );
  print('-------LOADED NEW MODEL');
  print(res);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Open Camera'),
              onPressed: () {
                Navigator.pushNamed(context, '/detection');
              },
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('See Objects'),
              onPressed: () {
                Navigator.pushNamed(context, '/info-book');
              },
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Test Classification'),
              onPressed: () {
                Navigator.pushNamed(context, '/test-classification');
              },
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Photo'),
              onPressed: () {
                Navigator.pushNamed(context, '/photo');
              },
            ),
          ],
        ),
      ),
    );
  }
}
