import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/screens/home.dart';
import 'package:animal_id/screens/detection.dart';
import 'package:tflite/tflite.dart';

List<CameraDescription> cameras;

loadModel() async {
  await Tflite.loadModel(
    model: "assets/model.tflite",
    labels: "assets/labels.txt",
  );
}

Future<void> main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  cameras = await availableCameras();
  await loadModel();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animal id',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => Home(),
        '/detection': (context) => Detection(cameras[0])
      },
    );
  }
}
