import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/detector.dart';
import 'package:animal_id/info_box.dart';
import 'package:animal_id/bounding_box.dart';
import 'package:animal_id/target.dart';
import 'package:animal_id/services/format_detections.dart';

class Detection extends StatefulWidget {
  final CameraDescription camera;

  Detection(this.camera);

  _DetectionState createState() => _DetectionState(camera);
}

class _DetectionState extends State<Detection> {
  final CameraDescription camera;
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _selectedClass = "";

  _DetectionState(this.camera);

  setRecognitions(List recognitions, imageHeight, imageWidth) {
    var cups = [];
    cups = recognitions.where((re) {
      return re["detectedClass"] == "cup";
    }).toList();
    if (this.mounted) {
      setState(() {
        _recognitions = cups;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;
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
    var formattedDetections = [];
    if (_recognitions.isNotEmpty) {
      formattedDetections = formatDetections(
          _recognitions,
          math.max(_imageHeight, _imageWidth),
          math.min(_imageHeight, _imageWidth),
          screen.height,
          screen.width);
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Detector(camera, setRecognitions),
          BoundingBox(formattedDetections, selectClass),
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
  }
}
