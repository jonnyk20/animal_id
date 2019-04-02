class Detection {
  final double left;
  final double top;
  final double width;
  final double height;
  final String detectedClass;
  final double confidenceInClass;
  final bool isTarget;
  Detection({
    this.left,
    this.top,
    this.width,
    this.height,
    this.detectedClass,
    this.confidenceInClass,
    this.isTarget,
  });
}
