import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/screens/home_screen.dart';
import 'package:animal_id/screens/detection_screen.dart';
import 'package:animal_id/screens/info_book_screen.dart';
import 'package:animal_id/screens/info_page_screen.dart';
import 'package:animal_id/screens/test_classification_screen.dart';
import 'package:animal_id/screens/photo_screen.dart';
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
        child: StoreBuilder<AppState>(
            onInit: (store) => startTimer(store),
            builder: (context, store) {
              return MaterialApp(
                title: 'animal id',
                // theme: ThemeData(
                //   brightness: Brightness.dark,
                // ),
                routes: {
                  '/': (context) => Home(),
                  '/detection': (context) => DetectionScreen(camera),
                  '/info-book': (context) => InfoBook(),
                  '/info-page': (context) => InfoPage(),
                  '/test-classification': (context) =>
                      TestClassificationScreen(),
                  '/photo': (context) => PhotoHome([camera]),
                },
              );
            }));
  }
}
