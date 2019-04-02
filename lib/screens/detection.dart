import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/detector.dart';
import 'package:animal_id/info_box.dart';
import 'package:animal_id/bounding_box.dart';
import 'package:animal_id/target.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state.dart';
import 'package:animal_id/models/detection.dart';
import 'package:animal_id/actions/actions.dart';

class DetectionScreen extends StatefulWidget {
  final CameraDescription camera;

  DetectionScreen(this.camera);

  _DetectionScreenState createState() => _DetectionScreenState(camera);
}

class _DetectionScreenState extends State<DetectionScreen> {
  final CameraDescription camera;
  List<Detection> _recognitions = [];
  String _selectedClass = "";

  _DetectionScreenState(this.camera);

  setRecognitions(List<Detection> recognitions) {
    var cups = [];

    if (this.mounted) {
      setState(() {
        _recognitions = cups;
      });
    }
  }

  selectClass(selectedClass) {
    setState(() {
      _selectedClass = selectedClass;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'addDetections': (detections) =>
            store.dispatch(AddDetections(detections)),
        'detections': store.state.detections
      };
    }, builder: (context, props) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Detector(
              camera,
              props["addDetections"],
              screen.height,
              screen.width,
            ),
            BoundingBox(
              props["detections"],
              selectClass,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InfoBox(_selectedClass),
            ),
            Target(),
          ],
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
