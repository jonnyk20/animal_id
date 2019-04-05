import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/object_record_model.dart';

final selelectedObjectRecordReducer = combineReducers<ObjectRecord>([
  TypedReducer<ObjectRecord, SelectObjectRecord>(_saveDetection),
]);

ObjectRecord _saveDetection(ObjectRecord state, SelectObjectRecord action) {
  return action.objectRecord;
}
