import 'package:flutter/rendering.dart';
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
      double width = MediaQuery.of(context).size.width;
      int count = (width / 100).floor();
      List<ObjectRecord> objectRecords = props["objects"];
      return Scaffold(
        appBar: AppBar(
          title: Text('View Objects'),
        ),
        body: Container(
          child: GridView.count(
            padding: EdgeInsets.all(5.0),
            addRepaintBoundaries: false,
            crossAxisCount: count,
            childAspectRatio: (1 / 1.2),
            children: objectRecords.map<Widget>((objectRecord) {
              return Container(
                child: ObjectCard(
                  objectRecord: objectRecord,
                  selectObjectRecord: props["selectObjectRecord"],
                ),
              );
            }).toList(),
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
