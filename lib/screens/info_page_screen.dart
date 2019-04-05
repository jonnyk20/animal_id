import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/app_state_model.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObjectRecord>(
      converter: (store) => store.state.selectedObject,
      builder: (context, ObjectRecord selectedObject) {
        return Scaffold(
          appBar: AppBar(title: Text(selectedObject.name)),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    selectedObject.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'IMAGE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,
                  )),
                ),
                Container(
                  child: Text(selectedObject.info),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
