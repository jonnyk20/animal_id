import 'package:flutter/material.dart';
import 'package:animal_id/screens/home.dart';
import 'package:animal_id/screens/detection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:animal_id/models/app_state.dart';
import 'package:camera/camera.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  final CameraDescription camera;

  App(this.store, this.camera);

  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store,
        child: StoreBuilder<AppState>(builder: (context, store) {
          return MaterialApp(
            title: 'animal id',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
            routes: {
              '/': (context) => Home(),
              '/detection': (context) => DetectionScreen(camera)
            },
          );
        }));
  }
}
