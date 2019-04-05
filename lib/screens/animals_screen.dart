import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/animal_card.dart';

class AnimalsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      var animalRecords = store.state.objectRecords;
      var animalsList = animalRecords.keys
          .map<ObjectRecord>((animalName) => animalRecords[animalName])
          .toList();
      animalsList.sort((a, b) {
        return b.isCaught.toString().compareTo(a.isCaught.toString());
      });
      return {
        "animals": animalsList,
      };
    }, builder: (context, props) {
      return Scaffold(
        appBar: AppBar(
          title: Text('View Animals'),
        ),
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: props["animals"].length,
            itemBuilder: (context, int index) {
              ObjectRecord objectRecord = props["animals"][index];
              return Container(
                padding: EdgeInsets.all(10.0),
                child: AnimalCard(
                  objectRecord: objectRecord,
                ),
              );
            },
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 150.0),
          child: FloatingActionButton(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
    });
  }
}
