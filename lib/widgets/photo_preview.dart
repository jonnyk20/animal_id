import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';

class PhotoPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.previewPath,
      builder: (context, previewPath) {
        return previewPath.isEmpty
            ? Container(
                child: Text('No Image'),
              )
            : Container(
                child: Image.file(File(previewPath)),
              );
      },
    );
  }
}
