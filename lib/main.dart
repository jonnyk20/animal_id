import 'dart:async';
import 'package:animal_id/utils/model_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:animal_id/app.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/reducers/reducers.dart';

List<CameraDescription> cameras;
Map<String, ObjectRecord> objectsInfo;

Future<Map<String, ObjectRecord>> loadObjectInfo() async {
  var file =
      await rootBundle.loadString('assets/models/classification/info.txt');
  var objectsInfo = Map<String, ObjectRecord>();

  file.split('\n').forEach((str) {
    var name = str.trim().toLowerCase();
    if (name.isNotEmpty) {
      var isFound = name == "pug";
      var info = 'This is info about $name';
      var record = ObjectRecord(
        name: name,
        info: info,
        isFound: isFound,
      );
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
  await loadModel(MlModels.detection);
  objectsInfo = await loadObjectInfo();
  final store = Store<AppState>(appReducers,
      initialState: AppState.initial(objectsInfo), middleware: []);
  runApp(App(store, cameras[0]));
}
