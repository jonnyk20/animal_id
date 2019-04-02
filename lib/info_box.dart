import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';

class InfoBox extends StatelessWidget {
  final String selectedClass;
  InfoBox(this.selectedClass);

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'clearDetections': () => store.dispatch(ClearTrackedDetections()),
        'detectionsCount': store.state.trackedDetections.length
      };
    }, builder: (context, props) {
      return Container(
        child: Column(
          children: <Widget>[
            selectedClass.isEmpty
                ? Text('No selected classes')
                : Text('Selected: $selectedClass'),
            Text('Total Detections: ${props["detectionsCount"]}'),
            RaisedButton(
              child: Text('Test Action'),
              onPressed: props["clearDetections"],
            )
          ],
        ),
        color: Colors.blue,
        padding: new EdgeInsets.all(40.0),
        height: 200.0,
      );
    });
  }
}
