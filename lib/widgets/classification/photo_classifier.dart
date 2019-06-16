import 'dart:math' as math;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:animal_id/utils/model_loader.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/utils/classify_image.dart';
import 'package:animal_id/utils/crop_image.dart';
import 'package:animal_id/widgets/classification/photo_preview.dart';

class PhotoClassifier extends StatefulWidget {
  final CameraDescription camera;
  final Function setClassificationStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;
  final Function setPreviewPath;
  final DetectedObject objectToClassify;

  PhotoClassifier({
    this.camera,
    this.setClassificationStatus,
    this.setClassificationResult,
    this.clearClassificationResult,
    this.setPreviewPath,
    this.objectToClassify,
  });

  _PhotoClassifierState createState() => _PhotoClassifierState(
        setClassificationStatus: setClassificationStatus,
        camera: camera,
        setClassificationResult: setClassificationResult,
        clearClassificationResult: clearClassificationResult,
        setPreviewPath: setPreviewPath,
        objectToClassify: objectToClassify,
      );
}

class _PhotoClassifierState extends State<PhotoClassifier> {
  final CameraDescription camera;
  CameraController controller;
  String imagePath;
  final Function setClassificationStatus;
  final Function setClassificationResult;
  final Function clearClassificationResult;
  final Function setPreviewPath;
  final DetectedObject objectToClassify;

  _PhotoClassifierState(
      {this.camera,
      this.setClassificationStatus,
      this.setClassificationResult,
      this.clearClassificationResult,
      this.setPreviewPath,
      this.objectToClassify});

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
    print('Error: ${e.code}\n${e.description}');
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
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
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  captureImage() async {
    await loadModel(MlModels.classification);
    String filePath = await takePicture();
    if (mounted) {
      File croppedFile =
          await cropImage(filePath, objectToClassify, setPreviewPath);
      await classifyImage(croppedFile, setClassificationResult);
      if (filePath != null) print('Picture saved to $filePath');
    }
  }

  showResults() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 400.0,
              child: PhotoPreview(),
              // child: ClassificationResults(),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  'close',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => closeClassifier(context),
              ),
            ],
          );
        });
  }

  closeClassifier(context) {
    // await reset model
    loadModel(MlModels.detection);
    // clear states
    setClassificationStatus(ClassificationStatuses.not_classifying);
    clearClassificationResult();
    Navigator.of(context).pushReplacementNamed('/');
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
