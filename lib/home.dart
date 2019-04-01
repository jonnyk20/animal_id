import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/camera.dart';

class Home extends StatefulWidget {
  final CameraDescription camera;

  Home(this.camera);

  @override
  _HomeState createState() => _HomeState(camera);
}

class _HomeState extends State<Home> {
  CameraController controller;
  CameraDescription camera;

  _HomeState(this.camera);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Camera(camera);
  }
}
