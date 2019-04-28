import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:animal_id/constants/constants.dart';

AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
AudioCache player = AudioCache();
const alarmAudioPath = 'sounds/save.wav';

playSound() {
  player.play(alarmAudioPath);
}

var threeSec = Duration(milliseconds: 300);

class FakeSaveButton extends StatelessWidget {
  final ClassifyingStatuses classifyingStatus;
  final Function setClassifyingStatus;

  FakeSaveButton({
    this.classifyingStatus,
    this.setClassifyingStatus,
  });

  fakeConfirm(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirmation",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          content: Text(
            "Confirmation details",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Close"),
              onPressed: () {
                setClassifyingStatus(ClassifyingStatuses.not_classifying);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onSave(context) {
    playSound();
    setClassifyingStatus(ClassifyingStatuses.classifying);
    Timer(threeSec, () {
      setClassifyingStatus(ClassifyingStatuses.classified);
      fakeConfirm(context);
    });
  }

  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        child: RaisedButton(
          child: Text('Save'),
          onPressed: classifyingStatus == ClassifyingStatuses.not_classifying
              ? () => onSave(context)
              : null,
        ),
      ),
    );
  }
}
