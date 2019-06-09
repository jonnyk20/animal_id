import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';

BorderRadiusGeometry roundedTop = BorderRadius.only(
  topLeft: Radius.circular(5.0),
  topRight: Radius.circular(5.0),
);

Widget filter = Positioned.fill(
  child: Container(
    decoration: BoxDecoration(
      borderRadius: roundedTop,
      color: Colors.blue.withOpacity(0.97),
    ),
    child: Container(
      alignment: Alignment.center,
      child: Text(
        "?",
        style: TextStyle(
          color: Colors.white.withOpacity(0.2),
          fontSize: 48.0,
        ),
      ),
    ),
  ),
);

class RecordListItem extends StatelessWidget {
  final ObjectRecord objectRecord;
  final Function selectObjectRecord;
  RecordListItem({
    this.objectRecord,
    this.selectObjectRecord,
  });

  onSelectObjectRecord(context) {
    selectObjectRecord(objectRecord);
    Navigator.pushNamed(context, '/record-screen');
  }

  Widget build(BuildContext context) {
    bool isFound = objectRecord.isFound;
    Function onTap = isFound ? onSelectObjectRecord : (context) {};

    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: roundedTop,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/dogs/adult.jpg',
                          ),
                        ),
                      ),
                    ),
                    isFound ? Container() : filter
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "${objectRecord.name}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
