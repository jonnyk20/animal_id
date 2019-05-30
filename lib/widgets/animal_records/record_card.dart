import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';

class ObjectCard extends StatelessWidget {
  final ObjectRecord objectRecord;
  final Function selectObjectRecord;
  ObjectCard({this.objectRecord, this.selectObjectRecord});

  onSelectObjectRecord(context) {
    selectObjectRecord(objectRecord);
    Navigator.pushNamed(context, '/info-page');
  }

  Widget build(BuildContext context) {
    return !objectRecord.isFound
        ? Card(
            color: Colors.grey,
            elevation: 5.0,
            child: Container(
              alignment: Alignment.center,
              height: 100.0,
              padding: EdgeInsets.all(10.0),
              child: Text(
                "?????",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Card(
            color: Colors.blue,
            child: GestureDetector(
              onTap: () {
                onSelectObjectRecord(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 100.0,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${objectRecord.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${objectRecord.info}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
