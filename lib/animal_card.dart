import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';

class AnimalCard extends StatelessWidget {
  final ObjectRecord objectRecord;
  AnimalCard({
    this.objectRecord,
  });
  Widget build(BuildContext context) {
    return objectRecord.isCaught
        ? Container(
            alignment: Alignment.center,
            color: Colors.blue,
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Text(
              "${objectRecord.name}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            color: Colors.grey,
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Text(
              "?????",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
  }
}
