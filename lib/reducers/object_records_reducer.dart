import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/object_record_model.dart';

final objectRecordsReducer = combineReducers<Map<String, ObjectRecord>>([
  TypedReducer<Map<String, ObjectRecord>, SaveDetection>(_saveDetection),
]);

Map<String, ObjectRecord> _saveDetection(
    Map<String, ObjectRecord> state, SaveDetection action) {
  var objectRecords = Map<String, ObjectRecord>.from(state);
  objectRecords[action.detectionName].isCaught = true;
  return objectRecords;
}
