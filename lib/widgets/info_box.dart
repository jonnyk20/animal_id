import 'package:flutter/material.dart';

import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detections_list.dart';

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
        child: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text('TEST'),
                onPressed: null,
              ),
            ),
            DetectionsList(
              detectedObjects: props['detectedObjects'],
              saveDetection: props['saveDetection'],
              canSave: props['canSave'],
              setSavingStatus: props['setSavingStatus'],
              confirmCatch: confirmCatch,
            )
          ],
        ),
      );
    });
  }
}
