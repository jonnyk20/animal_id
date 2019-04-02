import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:redux/redux.dart';
import 'package:animal_id/app.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/reducers/reducers.dart';

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
  final store = new Store<AppState>(appReducers,
      initialState: AppState.initial, middleware: []);
  runApp(App(store, cameras[0]));
}
