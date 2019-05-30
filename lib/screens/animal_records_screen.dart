import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/widgets/animal_records/record_card.dart';
import 'package:animal_id/actions/actions.dart';

class InfoBook extends StatelessWidget {
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
      return Scaffold(
        appBar: AppBar(
          title: Text('View Objects'),
        ),
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: props["objects"].length,
            itemBuilder: (context, int index) {
              ObjectRecord objectRecord = props["objects"][index];
              return Container(
                padding: EdgeInsets.all(10.0),
                child: ObjectCard(
                  objectRecord: objectRecord,
                  selectObjectRecord: props["selectObjectRecord"],
                ),
              );
            },
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
