import 'package:animal_id/models/object_record_model.dart';

class ClassificationResult {
  final String name;
  final ObjectRecord record;
  final double score;

  ClassificationResult({this.name, this.score, this.record});

  static ClassificationResult empty = ClassificationResult(
    name: '',
    score: 0,
  );

  ClassificationResult.withRecord(
      ClassificationResult result, ObjectRecord record)
      : name = result.name,
        score = result.score,
        record = record;
}
