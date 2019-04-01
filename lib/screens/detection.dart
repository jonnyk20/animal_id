import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/camera.dart';
import 'package:animal_id/info_box.dart';

class Detection extends StatelessWidget {
  final CameraDescription camera;

  Detection(this.camera);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Camera(camera),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InfoBox(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
