import 'package:flutter/material.dart';
import 'package:animal_id/models/object_record_model.dart';
import 'package:animal_id/widgets/ui/image_card.dart';
import 'package:animal_id/widgets/ui/space.dart';

class RecordView extends StatelessWidget {
  final ObjectRecord objectRecord;
  RecordView(this.objectRecord);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VerticalSpace(20.0),
          Container(
            child: Text(
              objectRecord.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 32,
              ),
            ),
          ),
          VerticalSpace(40.0),
          ImageCard(200.0, 'assets/images/dogs/adult.jpg'),
          VerticalSpace(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageCard(100.0, 'assets/images/dogs/puppy.jpg'),
              Container(
                margin: EdgeInsets.all(10.0),
                width: 50.0,
                height: 50.0,
                child: Icon(
                  Icons.forward,
                  color: Colors.blue,
                  size: 48.0,
                ),
              ),
              ImageCard(100.0, 'assets/images/dogs/adult.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}
