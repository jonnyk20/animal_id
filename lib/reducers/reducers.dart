import 'package:animal_id/models/app_state.dart';
import 'package:animal_id/reducers/is_working.dart';

// Todo, restructure reducers to look like:
// https://github.com/brianegan/flutter_architecture_samples/blob/master/example/redux/lib/reducers/

AppState appReducers(AppState state, dynamic action) {
  return AppState(isWorkingReducer(state.isWorking, action));
}
