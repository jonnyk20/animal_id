import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:animal_id/utils/detection_utils.dart';
import 'package:animal_id/models/detection_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';

class Detector extends StatefulWidget {
  final CameraDescription camera;
  final Function setRecognitions;
  final double screenHeight;
  final double screenWidth;
  final Function setTargetingStatus;
  final bool isScanning;
  final Function addTargetDetectionFrame;

  Detector({
    this.camera,
    this.setRecognitions,
    this.screenHeight,
    this.screenWidth,
    this.setTargetingStatus,
    this.isScanning,
    this.addTargetDetectionFrame,
  });

  _DetectorState createState() => _DetectorState(
      camera: camera,
      setRecognitions: setRecognitions,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      setTargetingStatus: setTargetingStatus,
      isScanning: isScanning,
      addTargetDetectionFrame: addTargetDetectionFrame);
}

class _DetectorState extends State<Detector> {
  final CameraDescription camera;
  final Function setRecognitions;
  final double screenHeight;
  final double screenWidth;
  final Function setTargetingStatus;
  CameraController controller;
  final bool isScanning;
  bool _isDetectorActive = false;
  final Function addTargetDetectionFrame;

  _DetectorState({
    this.camera,
    this.setRecognitions,
    this.screenHeight,
    this.screenWidth,
    this.setTargetingStatus,
    this.isScanning,
    this.addTargetDetectionFrame,
  });

  @override
  void initState() {
    super.initState();
    if (camera == null) {
      print('No camera found');
    } else {
      controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!_isDetectorActive) {
            _isDetectorActive = true;

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
              List<Detection> formattedDetections = formatDetections(
                recognitions,
                math.max(img.height, img.width),
                math.min(img.height, img.width),
                screenHeight,
                screenWidth,
              );
              Detection detectedObject = formattedDetections.firstWhere(
                  (detection) => detection.isTarget,
                  orElse: () => null);
              bool isTargeting = detectedObject != null;
              setTargetingStatus(isTargeting);
              setRecognitions(
                formattedDetections,
              );
              if (isTargeting) {
                var targetDetectionFrame = TargetDetectionFrame(
                  detectionName: detectedObject.detectedClass,
                  bytesList: bytesList,
                  height: img.height,
                  width: img.width,
                );
                addTargetDetectionFrame(targetDetectionFrame);
              }
              _isDetectorActive = false;
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
