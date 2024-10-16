import 'package:cgm/cgm.dart';
import 'package:cgm/src/render/color.dart';

/// Wrapper for Flutter's [Paint] class.
class CGMPaint {
  /// The color of the paint.
  Color color = Color(0xFF000000);

  /// The width of the stroke.
  /// Default is 0.0, which results in hairline width.
  double strokeWidth = 0.0;

  /// The stroke cap of the paint.
  StrokeCap strokeCap = StrokeCap.butt;

  /// The stroke join of the paint.
  StrokeJoin strokeJoin = StrokeJoin.miter;

  /// Whether the paint is filled or stroked.
  bool filled = true;

  /// Creates a new [CGMPaint] object.
  CGMPaint({Color? color, double? strokeWidth, StrokeCap? strokeCap, StrokeJoin? strokeJoin}) {
    if (color != null) this.color = color;
    if (strokeWidth != null) this.strokeWidth = strokeWidth;
    if (strokeCap != null) this.strokeCap = strokeCap;
    if (strokeJoin != null) this.strokeJoin = strokeJoin;
  }
}
