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
              child: Text('Open Camera'),
              onPressed: () {
                Navigator.pushNamed(context, '/detection');
              },
            ),
            RaisedButton(
              child: Text('See Animals'),
              onPressed: () {
                Navigator.pushNamed(context, '/animals');
              },
            ),
          ],
        ),
      ),
    );
  }
}
