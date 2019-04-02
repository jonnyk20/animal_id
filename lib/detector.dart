import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class Detector extends StatefulWidget {
  final CameraDescription camera;
  final Function setRecognitions;

  Detector(this.camera, this.setRecognitions);

  _DetectorState createState() => _DetectorState(camera, setRecognitions);
}

class _DetectorState extends State<Detector> {
  final CameraDescription camera;
  final Function setRecognitions;
  CameraController controller;
  bool isDetecting = false;

  _DetectorState(this.camera, this.setRecognitions);

  @override
  void initState() {
    super.initState();
    if (camera == null) {
      print('No camera found');
    } else {
      controller = new CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            var bytesList = img.planes.map((plane) {
              return plane.bytes;
            }).toList();

            Tflite.detectObjectOnFrame(
              bytesList: bytesList,
              model: "SSDMobileNet",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              numResultsPerClass: 1,
              threshold: 0.4,
            ).then((recognitions) {
              if (recognitions.where((re) {
                    return re["detectedClass"] == "cup";
                  }).length >
                  0) {}

              setRecognitions(recognitions, img.height, img.width);

              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;
    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
