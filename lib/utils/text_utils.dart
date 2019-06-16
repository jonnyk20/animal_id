import 'package:animal_id/models/object_record_model.dart';

String toTitleCase(String str) {
  List<String> words = str.split(' ').toList();
  List<String> titleCaseWords = words.map<String>((word) {
    return '${word[0].toUpperCase()}${word.substring(1)}';
  }).toList();
  return titleCaseWords.join(' ');
}

String getImagePath(ObjectRecord record) {
  return 'assets/images/dogs/${record.number.toString().padLeft(3, '0')}.jpg';
}
