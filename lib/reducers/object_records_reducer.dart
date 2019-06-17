import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/object_record_model.dart';

final objectRecordsReducer = combineReducers<Map<String, ObjectRecord>>([
  TypedReducer<Map<String, ObjectRecord>, SaveClassificationResult>(
      _saveClassification),
  TypedReducer<Map<String, ObjectRecord>, LoadSavedRecords>(_loadSavedRecords),
  TypedReducer<Map<String, ObjectRecord>, ClearSavedRecords>(
      _clearSavedRecords),
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

Map<String, ObjectRecord> _loadSavedRecords(
  Map<String, ObjectRecord> state,
  LoadSavedRecords action,
) {
  Map<String, ObjectRecord> records = Map<String, ObjectRecord>.from(state);
  records.forEach((recordName, record) {
    if (action.savedRecordNumbers.contains(record.number)) {
      record.isFound = true;
    }
  });
  return records;
}

Map<String, ObjectRecord> _clearSavedRecords(
  Map<String, ObjectRecord> state,
  ClearSavedRecords action,
) {
  Map<String, ObjectRecord> records = Map<String, ObjectRecord>.from(state);
  records.forEach((recordName, record) {
    record.isFound = false;
  });
  return records;
}
