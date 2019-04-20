import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';

import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/widgets/detection_label.dart';
import 'package:animal_id/constants/constants.dart';

AudioCache player = AudioCache();
const alarmAudioPath = 'sounds/save.wav';

const saveDuration = Duration(milliseconds: 300);

playSound() {
  player.play(alarmAudioPath);
}

class InfoBox extends StatelessWidget {
  confirmCatch(context, DetectedObject detectedObject, callback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Congratulations on your Catch: ${detectedObject.name}!",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          content: Text(
            "Go to your info book to learn about it",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Close"),
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      var detectedObjects = store.state.detectedObjects.keys
          .map<DetectedObject>((key) => store.state.detectedObjects[key])
          .toList();
      detectedObjects.sort((a, b) {
        return b.count.compareTo(a.count);
      });
      return {
        'clearDetections': () => store.dispatch(ReduceObjecDetectionCounts()),
        'detectedObjects': detectedObjects,
        'saveDetection': (detectionName) {
          store.dispatch(SaveDetection(detectionName));
          store.dispatch(RemoveTrackedDetection(detectionName));
        },
        'canSave': store.state.savingStatus == SavingStatuses.not_saving,
        'setSavingStatus': (SavingStatuses savingStatus) =>
            store.dispatch(SetSavingStatus(savingStatus))
      };
    }, builder: (context, props) {
      return Card(
        color: Colors.white.withOpacity(0.8),
        elevation: 10.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: 250.0,
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: props["detectedObjects"].length,
              itemBuilder: (context, int index) {
                DetectedObject detectedObject = props["detectedObjects"][index];
                return DetectionLabel(
                    detectedObject: detectedObject,
                    catchObject: (detectedObject) {
                      playSound();
                      props["setSavingStatus"](SavingStatuses.saving);
                      Timer(saveDuration, () {
                        props["setSavingStatus"](SavingStatuses.confirming);
                        confirmCatch(context, detectedObject, () {
                          props["setSavingStatus"](SavingStatuses.not_saving);
                        });
                        props["saveDetection"](detectedObject.name);
                      });
                    },
                    canSave: props["canSave"]);
              }),
        ),
      );
    });
  }
}
