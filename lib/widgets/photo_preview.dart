import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/image_preview_model.dart';
import 'package:animal_id/models/classification_result_model.dart';

class PhotoPreview extends StatelessWidget {
  Widget renderResult(ClassificationResult result) {
    if (result == null) {
      return Text('Classifying...');
    }
    if (result.name.isEmpty) {
      return Text('Nothing Found');
    }
    return Container(
        child:
            Text('Found ${result.name} with confindence of ${result.score}'));
  }

  renderPreview(ImagePreview preview) {
    return preview == null
        ? Container(
            child: Text('No Image'),
          )
        : Container(
            child: Image.file(
              File(preview.path),
              height: 300.0,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {
          'imagePreview': store.state.imagePreview,
          'classificationResult': store.state.classificationResult
        };
      },
      builder: (context, props) {
        ImagePreview imagePreview = props['imagePreview'];
        ClassificationResult classificationResult =
            props['classificationResult'];
        return Column(
          children: <Widget>[
            renderResult(classificationResult),
            renderPreview(imagePreview),
          ],
        );
      },
    );
  }
}
