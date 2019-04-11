import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/widgets/detection_label.dart';

class InfoBox extends StatelessWidget {
  final String selectedClass;
  InfoBox(this.selectedClass);

  confirmCatch(context, DetectedObject detectedObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Congratulations on your new Catch: ${detectedObject.name}!",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          content: new Text(
            "Go to your info book to learn about it",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text("Close"),
              onPressed: () {
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
        }
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
                    props["saveDetection"](detectedObject.name);
                    confirmCatch(context, detectedObject);
                  },
                );
              }),
        ),
      );
    });
  }
}
