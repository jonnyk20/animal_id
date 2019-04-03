import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/detection_label.dart';

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
            "You have caught a ${detectedObject.name}!",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          content: new Text(
            "Go to your animal book to learn about this animal",
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
      var dectedObjects = store.state.detectedObjects.keys
          .map<DetectedObject>((key) => store.state.detectedObjects[key])
          .toList();
      return {
        'clearDetections': () => store.dispatch(ReduceObjecDetectionCounts()),
        'detectedObjects': dectedObjects
      };
    }, builder: (context, props) {
      return Container(
        height: 300.0,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: props["detectedObjects"].length,
                    itemBuilder: (context, int index) {
                      var detectedObject = props["detectedObjects"][index];
                      return DetectionLabel(
                        detectedObject: detectedObject,
                        catchObject: (detectedObject) {
                          confirmCatch(context, detectedObject);
                          // confirmCatch(context, detectedObject);
                        },
                      );
                    }))
          ],
        ),
      );
    });
  }
}
