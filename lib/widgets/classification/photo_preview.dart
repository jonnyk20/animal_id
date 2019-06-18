// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/image_preview_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/widgets/ui/image_container.dart';
import 'package:animal_id/widgets/ui/space.dart';
import 'package:animal_id/utils/text_utils.dart';

class PhotoPreview extends StatelessWidget {
  Widget renderResult(ClassificationResult result) {
    if (result == null) {
      return Text('Classifying...');
    }
    if (result.name.isEmpty) {
      return Text('Dog Species Unknown');
    }
    return Column(
      children: <Widget>[
        Text(
          toTitleCase(result.name),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        Text(
          '${(result.score * 100).toStringAsFixed(2)}% Confidence',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  renderPreview(ClassificationResult result, imagePreview) {
    String imagePath = result.record != null
        ? getImagePath(result.record)
        : 'assets/images/misc/unknown_dog.jpg';

    return ImageContainer(200.0, imagePath);
    // return Container(
    //   child: Image.file(
    //     File(imagePreview.path),
    //     height: 200.0,
    //   ),
    // );
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
        print('PREVIEW -> ${imagePreview != null}');
        ClassificationResult classificationResult =
            props['classificationResult'];
        bool waitingForResult = classificationResult == null;
        return Column(
          children: <Widget>[
            renderResult(classificationResult),
            VerticalSpace(100),
            waitingForResult
                ? CircularProgressIndicator()
                : renderPreview(classificationResult, imagePreview),
          ],
        );
      },
    );
  }
}
