import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/widgets/ui/image_card.dart';
import 'package:animal_id/widgets/ui/space.dart';
import 'package:animal_id/utils/text_utils.dart';

class RecordView extends StatelessWidget {
  final ObjectRecord objectRecord;
  RecordView(this.objectRecord);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VerticalSpace(40.0),
          Container(
            child: Text(
              toTitleCase(objectRecord.name),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 32,
              ),
            ),
          ),
          VerticalSpace(20.0),
          ImageCard(300.0, getImagePath(objectRecord)),
        ],
      ),
    );
  }
}
