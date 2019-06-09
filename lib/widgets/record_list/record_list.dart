import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/widgets/record_list/record_list_item.dart';

class RecordList extends StatelessWidget {
  final List<ObjectRecord> objectRecords;
  final Function selectObjectRecord;

  RecordList({this.objectRecords, this.selectObjectRecord});

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int count = (width / 100).floor();
    return GridView.count(
      padding: EdgeInsets.all(5.0),
      addRepaintBoundaries: false,
      crossAxisCount: count,
      childAspectRatio: (1 / 1.2),
      children: objectRecords.map<Widget>((objectRecord) {
        return Container(
          child: RecordListItem(
            objectRecord: objectRecord,
            selectObjectRecord: selectObjectRecord,
          ),
        );
      }).toList(),
    );
  }
}
