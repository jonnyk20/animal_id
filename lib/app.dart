import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/screens/home_screen.dart';
import 'package:animal_id/screens/detection_screen.dart';
import 'package:animal_id/screens/record_list_screen.dart';
import 'package:animal_id/screens/record_screen.dart';
import 'package:animal_id/screens/settings_screen.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/actions/actions.dart';

var interval;
const oneSec = const Duration(milliseconds: 500);

startTimer(store) {
  interval = Timer.periodic(oneSec, (Timer t) {
    store.dispatch(ReduceObjecDetectionCounts());
  });
}

class App extends StatelessWidget {
  final Store<AppState> store;
  final CameraDescription camera;

  App(this.store, this.camera);

  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreBuilder<AppState>(onInit: (store) {
          startTimer(store);
          store.dispatch(RetrieveRecordsFromStorage());
        }, builder: (context, store) {
          return MaterialApp(
            title: 'animal id',
            // theme: ThemeData(
            //   brightness: Brightness.dark,
            // ),
            routes: {
              '/': (context) => Home(),
              '/detection': (context) => DetectionScreen(camera),
              '/record-list-screen': (context) => RecordListScreen(),
              '/record-screen': (context) => RecordScreen(),
              '/settings-screen': (context) => SettingsScreen(),
            },
          );
        }));
  }
}
