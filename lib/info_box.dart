import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';

class InfoBox extends StatelessWidget {
  final String selectedClass;
  InfoBox(this.selectedClass);

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Map>(converter: (store) {
      return {
        'isWorking': store.state.isWorking,
        'setIsWorking': () => store.dispatch(ChangeIsWorking('NO'))
      };
    }, builder: (context, props) {
      return Container(
        child: Column(
          children: <Widget>[
            selectedClass.isEmpty
                ? Text('No selected classes')
                : Text('Selected: $selectedClass'),
            Text('isWorking: ${props["isWorking"]}'),
            RaisedButton(
              child: Text('Test Action'),
              onPressed: props["setIsWorking"],
            )
          ],
        ),
        color: Colors.blue,
        padding: new EdgeInsets.all(40.0),
        constraints: BoxConstraints(
          maxHeight: 300.0,
          minHeight: 300.0,
        ),
      );
    });
  }
}
