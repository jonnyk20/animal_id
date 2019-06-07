import 'package:animal_id/models/object_record_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/models/target_detection_frame_model.dart';
import 'package:animal_id/models/image_preview_model.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/classification/photo_classifier.dart';
import 'package:animal_id/widgets/classification/frame_classifier.dart';

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
          'setClassificationResult': (ClassificationResult result) {
            String classificationName = result.name.toLowerCase();
            Map<String, ObjectRecord> records = store.state.objectRecords;
            ObjectRecord record = records[classificationName];
            if (record == null) {
              return store.dispatch(
                  SetClassificationResult(ClassificationResult.empty));
            }
            store.dispatch(SetClassificationResult(result));
            if (!record.isFound) {
              store.dispatch(SaveClassificationResult(result));
            }
          },
          'clearClassificationResult': () {
            store.dispatch(ClearClassificationResult());
            store.dispatch(SetImagePreview(null));
          },
          'clearTargetDetectionFrames': () =>
              store.dispatch(ClearTargetDetectionFrames),
          'setPreviewPath': (ImagePreview preview) =>
              store.dispatch(SetImagePreview(preview)),
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
        Function setPreviewPath = props['setPreviewPath'];

        switch (classifyMode) {
          case ClassifyModes.photo:
            return PhotoClassifier(
                camera: camera,
                setClassificationStatus: setClassificationStatus,
                setClassificationResult: setClassificationResult,
                clearClassificationResult: clearClassificationResult,
                setPreviewPath: setPreviewPath,
                objectToClassify: objectToClassify);
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
