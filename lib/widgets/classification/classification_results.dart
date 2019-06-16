import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/classification_result_model.dart';
import 'package:animal_id/utils/text_utils.dart';

class ClassificationResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {
          'result': store.state.classificationResult,
        };
      },
      builder: (context, props) {
        ClassificationResult result = props['result'];
        if (result == null) {
          return Text('Classifying...');
        }
        if (result.name.isEmpty) {
          return Text('Nothing Found');
        }
        return Column(
          children: <Widget>[
            Text(
              toTitleCase(result.name),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            Text('${(result.score * 100).toStringAsFixed(2)}% Confidence'),
          ],
        );
      },
    );
  }
}
