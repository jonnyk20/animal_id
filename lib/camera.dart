import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  final CameraDescription camera;

  Camera(this.camera);

  @override
  _CameraState createState() => _CameraState(camera);
}

class _CameraState extends State<Camera> {
  final CameraDescription camera;
  CameraController controller;

  _CameraState(this.camera);

  @override
  void initState() {
    super.initState();
    controller = CameraController(camera, ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller);
  }
}
