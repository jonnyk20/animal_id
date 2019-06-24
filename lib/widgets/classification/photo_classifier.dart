import 'dart:io' show Platform, File, Directory;
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
    print('INITIATING PHOTO CLASSIFIER');
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
    if (!Platform.isAndroid) {
      controller?.dispose(); // Todo (JK) investigate app crash
    }
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

    File existingFile = File(filePath);
    if (await existingFile.exists()) {
      await existingFile.delete(recursive: true);
    }

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
    print('CLOSING CLASSIFIER');
    // await reset model
    loadModel(MlModels.detection);
    // clear states
    setClassificationStatus(ClassificationStatuses.not_classifying);
    clearClassificationResult();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
