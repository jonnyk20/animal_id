import 'dart:math' as math;
import 'dart:io';
import 'package:animal_id/utils/classify_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animal_id/utils/model_loader.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/widgets/classification_results.dart';
import 'package:animal_id/constants/constants.dart';


void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class PhotoClassifier extends StatefulWidget {
  final CameraDescription camera;
  final Function setClassifyingStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;

  PhotoClassifier({
    this.camera,
    this.setClassifyingStatus,
    this.setClassificationResult,
    this.clearClassificationResult
  });

  _PhotoClassifierState createState() => _PhotoClassifierState(
      setClassifyingStatus: setClassifyingStatus,
      camera: camera,
      setClassificationResult: setClassificationResult,
      clearClassificationResult: clearClassificationResult,
      );
}

class _PhotoClassifierState extends State<PhotoClassifier> {
  final CameraDescription camera;
  CameraController controller;
  String imagePath;
  final Function setClassifyingStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;

  _PhotoClassifierState({
    this.camera,
    this.setClassifyingStatus,
    this.setClassificationResult,
    this.clearClassificationResult,
  });

  @override
  void initState() {
    super.initState();
    print('-------INITIATING PhotoClassifier----------');
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
        showResults();
        captureImage();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    print('MESSAGE:');
    print(message);
  }

    Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath =
        '$dirPath/delete-this.jpg'; // '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    print('ATTEMPTING TO SAVE TO ');
    print(filePath);
    try {

      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print('PHOTO ERROR');
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  captureImage() async {
    await loadModel(MlModels.classification);
    String filePath = await takePicture();
    if (mounted) {
      await classifyImage(File(filePath), setClassificationResult);
      setState(() {
        imagePath = filePath;
      });
      if (filePath != null) showInSnackBar('Picture saved to $filePath');
    }
  }

  showResults() {
    showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          child: ClassificationResults(),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text('close'),
            onPressed: () => closeClassifier(context),
          )
        ],
      );
    });
  }

  closeClassifier(context) {
    // await reset model
    loadModel(MlModels.detection);
    // clear states
    setClassifyingStatus(ClassifyingStatuses.not_classifying);
    clearClassificationResult();
    Navigator.pop(context);
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
