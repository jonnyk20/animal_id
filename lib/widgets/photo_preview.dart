import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/image_preview_model.dart';

class PhotoPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ImagePreview>(
      converter: (store) => store.state.imagePreview,
      builder: (context, imagePreview) {
        return imagePreview == null
            ? Container(
                child: Text('No Image'),
              )
            : Container(
                child: Image.file(File(imagePreview.path)),
              );
      },
    );
  }
}
