import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/actions/actions.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => {
        'addSavedRecord': () {
          ClassificationResult result = ClassificationResult(
            name: 'pug',
            score: 0.9,
            record: store.state.objectRecords['pug'],
          );

          store.dispatch(SaveClassificationResult(result));
        },
        'clearSavedRecords': () => store.dispatch(ClearSavedRecords()),
      },
      builder: (context, Map<String, dynamic> props) {
        Function addSavedRecord = props['addSavedRecord'];
        Function clearSavedRecords = props['clearSavedRecords'];
        return Scaffold(
          appBar: AppBar(title: Text('Settings')),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  // (JK) Remove this
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: addSavedRecord,
                  child: Text('TEST'),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: clearSavedRecords,
                  child: Text(
                    'Clear Saved Data',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
