import 'package:flutter/material.dart';
import 'package:animal_id/widgets/ui/image_container.dart';

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
            ImageContainer(300.0, 'assets/images/misc/kennel.png'),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Find Dogs'),
              onPressed: () {
                Navigator.pushNamed(context, '/detection');
              },
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Saved Dogs'),
              onPressed: () {
                Navigator.pushNamed(context, '/record-list-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
