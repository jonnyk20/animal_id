class Detection {
  final double left;
  final double top;
  final double width;
  final double height;
  final String detectedClass;
  final double confidenceInClass;
  bool isTarget;
  final bool isRelevant;
  final double rawLeft;
  final double rawTop;
  final double rawWidth;
  final double rawHeight;

  Detection({
    this.left,
    this.top,
    this.width,
    this.height,
    this.detectedClass,
    this.confidenceInClass,
    this.isTarget,
    this.isRelevant = true,
    this.rawLeft,
    this.rawTop,
    this.rawWidth,
    this.rawHeight,
  });
}
