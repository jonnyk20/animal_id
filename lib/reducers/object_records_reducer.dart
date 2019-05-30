import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/object_record_model.dart';

final objectRecordsReducer = combineReducers<Map<String, ObjectRecord>>([
  TypedReducer<Map<String, ObjectRecord>, SaveClassificationResult>(
      _saveClassification),
]);

Map<String, ObjectRecord> _saveClassification(
    Map<String, ObjectRecord> state, SaveClassificationResult action) {
  var objectRecords = Map<String, ObjectRecord>.from(state);
  ObjectRecord record = objectRecords[action.result.name.toLowerCase()];
  if (record != null) {
    record.isFound = true;
  }
  return objectRecords;
}
