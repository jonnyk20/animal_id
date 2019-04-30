import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
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
