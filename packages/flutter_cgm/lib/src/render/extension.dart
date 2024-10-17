import 'dart:ui';

import 'package:cgm/cgm.dart' hide StrokeCap, StrokeJoin;

extension CGMPaintExtension on CGMPaint {
  /// Converts a [CGMPaint] object to flutter's equivalent [Paint].
  Paint toPaint() {
    final paint = Paint();
    paint.color = Color(color.value);
    paint.style = filled ? PaintingStyle.fill : PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.values[strokeCap.index];
    paint.strokeJoin = StrokeJoin.values[strokeJoin.index];
    paint.strokeWidth = strokeWidth;
    return paint;
  }
}
