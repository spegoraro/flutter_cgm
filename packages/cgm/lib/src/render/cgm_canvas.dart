import 'dart:typed_data';

import 'package:cgm/cgm.dart';
import 'package:cgm/src/render/color.dart';
import 'package:vector_math/vector_math.dart';

/// Wrapper around the Flutter [Canvas] class.
abstract class CGMCanvas {
  /// Saves the current state of the canvas, so that it can be restored later using [restore].
  void save();

  /// Restores the last saved state of the canvas.
  void restore();

  /// Translates the canvas by the given [x] and [y] values.
  void translate(double x, double y);

  /// Scales the canvas by the given [x] and [y] values.
  void scale(double x, double y);

  /// Transforms the canvas by the given [matrix4] matrix.
  void transform(Float64List matrix4);

  /// Sets the canvas' clip path to the given [path].
  void clipPath(CGMPath path);

  /// Creates a new path, optionally copying the given [copyFrom] path.
  CGMPath createPath([CGMPath? copyFrom]);

  /// Draws the given [path] using the given [paint].
  void drawPath(CGMPath path, CGMPaint paint);

  /// Draws a rectangle at the given [position] with the given [size] using the given [paint].
  ///
  /// The [position] is the top-left corner of the rectangle.
  void drawRect(Vector2 position, Vector2 size, CGMPaint paint);

  /// Draws a circle at the given [center] with the given [radius] using the given [paint].
  void drawCircle(Vector2 center, double radius, CGMPaint paint);

  /// Returns the line metrics for the given [text].
  LineMetrics getLineMetrics(String text);

  /// Draws [text] at [offset] with the given [color].
  void drawText(String text, {required Vector2 offset, Color color = const Color(0xFF000000)});
}
