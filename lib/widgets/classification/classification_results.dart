import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/models/classification_result_model.dart';

class ClassificationResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) {
        return {'result': store.state.classificationResult};
      },
      builder: (context, props) {
        ClassificationResult result = props['result'];
        if (result == null) {
          return Text('Classifying...');
        }
        if (result.name.isEmpty) {
          return Text('Nothing Found');
        }
        return Container(
            child: Text(
                'Found ${result.name} with confindence of ${result.score}'));
      },
    );
  }
}
