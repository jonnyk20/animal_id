import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:animal_id/models/app_state_model.dart';
import 'package:animal_id/actions/actions.dart';

const String SAVED_RECORDS = "ANIMAL_ID_SAVED_RECORDS";

void saveRecordsToStorage(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(
    SAVED_RECORDS,
    json.encode(state.savedRecordNumbers()),
  );
}

void retrieveRecordsFromStorage(Store<AppState> store) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var stateString = preferences.getString(SAVED_RECORDS);
  if (stateString != null) {
    List<int> savedRecordNumbers = List<int>.from(json.decode(stateString));
    print('SAVED RECORDS');
    print(savedRecordNumbers);
    store.dispatch(LoadSavedRecords(savedRecordNumbers));
  }
}

void clearSavedRecords() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove(SAVED_RECORDS);
}

void savedRecordsMiddlware(Store<AppState> store, action, NextDispatcher next) {
  next(action);
  if (action is SaveClassificationResult) {
    saveRecordsToStorage(store.state);
  }

  if (action is RetrieveRecordsFromStorage) {
    print('HERE!!');
    retrieveRecordsFromStorage(store);
  }

  if (action is ClearSavedRecords) {
    clearSavedRecords();
  }
}
