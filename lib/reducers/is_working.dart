import 'package:redux/redux.dart';
import '../actions/actions.dart';

final isWorkingReducer = combineReducers<String>([
  TypedReducer<String, ChangeIsWorking>(_changeIsWorking),
]);

String _changeIsWorking(String state, action) {
  return action.isWorking;
}
