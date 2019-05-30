class ClassificationResult {
  final String name;
  final double score;
  ClassificationResult({
    this.name,
    this.score,
  });

  static ClassificationResult empty = ClassificationResult(
    name: '',
    score: 0,
  );
}
