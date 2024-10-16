import 'dart:ui';

import 'package:cgm/cgm.dart';

extension CGMPaintExtension on CGMPaint {
  /// Converts a [CGMPaint] object to flutter's equivalent [Paint].
  Paint toPaint() {
    final paint = Paint();
    paint.color = Color(color.value);
    paint.style = filled ? PaintingStyle.fill : PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;
    return paint;
  }
}
