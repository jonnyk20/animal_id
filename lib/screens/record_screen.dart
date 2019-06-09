import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/widgets/record_view/record_view.dart';

class RecordScreen extends StatelessWidget {
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
          body: RecordView(selectedObject),
        );
      },
    );
  }
}
