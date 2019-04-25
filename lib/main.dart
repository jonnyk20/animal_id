import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:redux/redux.dart';
import 'package:animal_id/app.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/reducers/reducers.dart';

List<CameraDescription> cameras;
Map<String, ObjectRecord> objectsInfo;

loadModel() async {
  print('------LOADING MODEL');
  var res = await Tflite.loadModel(
    model: "assets/models/detection/model.tflite",
    labels: "assets/models/detection/labels.txt",
  );
  print('-------LOADED MODEL');
  print(res);
}

Future<Map<String, ObjectRecord>> loadObjectInfo() async {
  var file = await rootBundle.loadString('assets/models/detection/info.txt');
  var objectsInfo = Map<String, ObjectRecord>();

  file.split('\n').forEach((str) {
    var name = str.trim();
    if (name.isNotEmpty) {
      var isCaught = name == "cup";
      var info = 'This is info about $name';
      var record = ObjectRecord(name: name, info: info, isCaught: isCaught);
      objectsInfo[name] = record;
    }
  });
  return objectsInfo;
}

Future<void> main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  cameras = await availableCameras();
  // cameras = [
  //   CameraDescription(
  //       name: 'false',
  //       lensDirection: CameraLensDirection.back,
  //       sensorOrientation: 90)
  // ];
  await loadModel();
  objectsInfo = await loadObjectInfo();
  final store = Store<AppState>(appReducers,
      initialState: AppState.initial(objectsInfo), middleware: []);
  runApp(App(store, cameras[0]));
}
