/// Wrapper class for flutter's [LineMetrics] class
class LineMetrics {
  /// The distance from the top of the line to the baseline.
  final double ascent;

  /// The distance from the baseline to the bottom of the line.
  final double descent;

  /// The y-coordinate of the baseline, relative to the top of the line.
  final double baseline;

  /// The total height of the line.
  final double height;

  /// Creates a new [LineMetrics] object.
  LineMetrics({
    required this.ascent,
    required this.descent,
    required this.baseline,
    required this.height,
  });

  factory LineMetrics.empty() => LineMetrics(ascent: 0, descent: 0, baseline: 0, height: 0);
}
