import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/widgets/record_list/record_list.dart';

class RecordListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      var objectRecords = store.state.objectRecords;
      var objectsList = objectRecords.keys
          .map<ObjectRecord>((animalName) => objectRecords[animalName])
          .toList();
      objectsList.sort((a, b) {
        return b.isFound.toString().compareTo(a.isFound.toString());
      });
      return {
        "objects": objectsList,
        "selectObjectRecord": (objectRecord) =>
            store.dispatch(SelectObjectRecord(objectRecord))
      };
    }, builder: (context, props) {
      List<ObjectRecord> objectRecords = props["objects"];
      Function selectObjectRecord = props["selectObjectRecord"];

      return Scaffold(
        appBar: AppBar(
          title: Text('View Objects'),
        ),
        body: Container(
          child: RecordList(
            objectRecords: objectRecords,
            selectObjectRecord: selectObjectRecord,
          ),
        ),
        floatingActionButton: Container(
          child: FloatingActionButton(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
      );
    });
  }
}
