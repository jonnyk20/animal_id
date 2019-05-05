import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/photo_classifier.dart';
import 'package:animal_id/widgets/frame_classifier.dart';

class GeneralClassifier extends StatelessWidget {
  final CameraDescription camera;

  GeneralClassifier({
    this.camera,
  });

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {
          'classifyMode': store.state.classifyMode,
          'objectToClassify': store.state.objectToClassify,
          'targetDetectionFrames': store.state.targetDetectionFrames,
          'setClassificationStatus': (ClassificationStatuses status) =>
              store.dispatch(SetClassificationStatus(status)),
          'setClassificationResult': (ClassificationResult object) =>
              store.dispatch(SetClassificationResult(object)),
          'clearClassificationResult': () =>
              store.dispatch(ClearClassificationResult),
          'clearTargetDetectionFrames': () =>
              store.dispatch(ClearTargetDetectionFrames),
        };
      },
      builder: (context, props) {
        ClassifyModes classifyMode = props['classifyMode'];
        DetectedObject objectToClassify = props['objectToClassify'];
        List<TargetDetectionFrame> targetDetectionFrames =
            props['targetDetectionFrames'];
        Function setClassificationResult = props['setClassificationResult'];
        Function setClassificationStatus = props['setClassificationStatus'];
        Function clearClassificationResult = props['clearClassificationResult'];
        Function clearTargetDetectionFrames =
            props['clearTargetDetectionFrames'];

        switch (classifyMode) {
          case ClassifyModes.photo:
            return PhotoClassifier(
              camera: camera,
              setClassificationStatus: setClassificationStatus,
              setClassificationResult: setClassificationResult,
              clearClassificationResult: clearClassificationResult,
            );
          case ClassifyModes.frames:
            return FrameClassifier(
              setClassificationStatus: setClassificationStatus,
              setClassificationResult: setClassificationResult,
              clearClassificationResult: clearClassificationResult,
              objectToClassify: objectToClassify,
              targetDetectionFrames: targetDetectionFrames,
              clearTargetDetectionFrames: clearTargetDetectionFrames,
            );
          default:
            return Container(
              child: Text('Classification Mode Not Set'),
            );
        }
      },
    );
  }
}
