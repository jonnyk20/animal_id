import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:animal_id/models/detected_object_model.dart';
import 'package:animal_id/constants/constants.dart';
import 'package:animal_id/widgets/detection_label.dart';

AudioCache player = AudioCache();
const alarmAudioPath = 'sounds/save.wav';

const saveDuration = Duration(milliseconds: 300);

playSound() {
  player.play(alarmAudioPath);
}

class DetectionsList extends StatelessWidget {
  final List<DetectedObject> detectedObjects;
  final bool canSave;
  final Function saveDetection;
  final Function triggerClassification;
  final Function setClassifyingStatus;
  final Function clearTargetingAndDetectiongStatuses;
  final Function setObjectToClassify;

  DetectionsList({
    this.detectedObjects,
    this.canSave,
    this.saveDetection,
    this.triggerClassification,
    this.setClassifyingStatus,
    this.clearTargetingAndDetectiongStatuses,
    this.setObjectToClassify,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: detectedObjects.length,
          itemBuilder: (context, int index) {
            DetectedObject detectedObject = detectedObjects[index];
            return DetectionLabel(
                detectedObject: detectedObject,
                catchObject: (detectedObject) {
                  clearTargetingAndDetectiongStatuses();
                  playSound();
                  print('SET_OBJECT_TO_CLASSIFY');
                  setObjectToClassify(detectedObject);
                  // Figure this out (JK)
                  setClassifyingStatus(ClassifyingStatuses.classifying);
                  Timer(saveDuration, () {
                  setClassifyingStatus(ClassifyingStatuses.classified);
                    triggerClassification(context, detectedObject, () {
                      setClassifyingStatus(ClassifyingStatuses.not_classifying);
                    });
                    saveDetection(detectedObject.name);
                  });
                },
                canSave: canSave);
          }),
    );
  }
}
