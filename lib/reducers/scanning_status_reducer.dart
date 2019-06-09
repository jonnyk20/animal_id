import 'package:redux/redux.dart';
import 'package:animal_id/actions/actions.dart';

final scanningStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetScanningStatus>(_setScanningStatus),
]);

bool _setScanningStatus(bool state, SetScanningStatus action) {
  return action.scanningStatus;
}
