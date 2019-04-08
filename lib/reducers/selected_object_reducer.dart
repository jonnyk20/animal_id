import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';
import 'package:animal_id/models/object_record_model.dart';

final selelectedObjectRecordReducer = combineReducers<ObjectRecord>([
  TypedReducer<ObjectRecord, SelectObjectRecord>(_selectObjectRecord),
]);

ObjectRecord _selectObjectRecord(
    ObjectRecord state, SelectObjectRecord action) {
  return action.objectRecord;
}
