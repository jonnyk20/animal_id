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
  final SavingStatuses savingStatus;
  final Function setSavingStatus;

  FakeSaveButton({
    this.savingStatus,
    this.setSavingStatus,
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
                setSavingStatus(SavingStatuses.not_saving);
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
    setSavingStatus(SavingStatuses.saving);
    Timer(threeSec, () {
      setSavingStatus(SavingStatuses.confirming);
      fakeConfirm(context);
    });
  }

  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        child: RaisedButton(
          child: Text('Save'),
          onPressed: savingStatus == SavingStatuses.not_saving
              ? () => onSave(context)
              : null,
        ),
      ),
    );
  }
}
