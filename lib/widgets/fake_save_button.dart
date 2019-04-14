import 'dart:async';
import 'package:flutter/material.dart';

var threeSec = Duration(milliseconds: 300);

class FakeSaveButton extends StatelessWidget {
  final bool isSaving;
  final Function changeSavingState;

  FakeSaveButton({
    this.isSaving,
    this.changeSavingState,
  });

  onSave() {
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
