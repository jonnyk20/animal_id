import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.LOW_LATENCY);
AudioCache player = new AudioCache();
const alarmAudioPath = 'sounds/save.wav';

playSound() async {
  // // var file = await rootBundle.loadString('assets/sounds/save.wav');
  // int result = await audioPlayer.play('/assets/sounds/save.wav', isLocal: true);
  // print('RESULT');
  // print(result);

  player.play(alarmAudioPath);
}

var threeSec = Duration(milliseconds: 300);

class FakeSaveButton extends StatelessWidget {
  final bool isSaving;
  final Function changeSavingState;

  FakeSaveButton({
    this.isSaving,
    this.changeSavingState,
  });

  onSave() {
    playSound();
    changeSavingState(true);
    Timer(threeSec, () {
      changeSavingState(false);
    });
  }

  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        child: RaisedButton(
          child: Text('Save'),
          onPressed: isSaving ? null : onSave,
        ),
      ),
    );
  }
}
