import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

class Ellipse extends Command {
  late final Point<double> center;
  late final Point<double> firstConjugateDiameterEndPoint;
  late final Point<double> secondConjugateDiameterEndPoint;

  @protected
  Path? shape;

  Ellipse(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    center = makePoint();
    firstConjugateDiameterEndPoint = makePoint();
    secondConjugateDiameterEndPoint = makePoint();
  }

  @protected
  void initializeShape(CGMDisplay display) {
    if (shape != null) return;

    double centerFirstDistance = center.distanceTo(firstConjugateDiameterEndPoint);
    double centerSecondDistance = center.distanceTo(secondConjugateDiameterEndPoint);

    double firstConjugateangle =
        atan2(firstConjugateDiameterEndPoint.y - center.y, firstConjugateDiameterEndPoint.x - center.x);

    double secondFirstConjugateAngle =
        atan2(secondConjugateDiameterEndPoint.y - center.y, secondConjugateDiameterEndPoint.x - center.x) -
            firstConjugateangle;

    centerSecondDistance = sin(secondFirstConjugateAngle).abs() * centerSecondDistance;

    shape = createShape(centerFirstDistance, centerSecondDistance);

    Matrix4 translationMatrix = Matrix4.identity()..translate(center.x, center.y, 0);
    Matrix4 rotationMatrix = Matrix4.identity()..rotateZ(firstConjugateangle);
    Matrix4 inverseRotationMatrix = Matrix4.identity()..rotateZ(-firstConjugateangle);

    Vector2 rotatedSecondConjugate = inverseRotationMatrix
        .transform3(
            Vector3(secondConjugateDiameterEndPoint.x - center.x, secondConjugateDiameterEndPoint.y - center.y, 0))
        .xy;

    Matrix4 shearMatrix;
    if (rotatedSecondConjugate.y != 0) {
      shearMatrix = Matrix4.skew(rotatedSecondConjugate.x / rotatedSecondConjugate.y, 0);
    } else {
      shearMatrix = Matrix4.identity();
    }

    rotationMatrix *= shearMatrix;

    try {
      applyArcs(display, Matrix4.identity()..copyInverse(rotationMatrix));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    translationMatrix.multiply(rotationMatrix);

    Path transformedShape = shape!.transform(Float64List.fromList(translationMatrix.storage));
    shape = transformedShape;
  }

  @protected
  void applyArcs(CGMDisplay display, Matrix4 transform) {} // Implemented in subclasses

  @protected
  Path createShape(double centerFirstDistance, double centerSecondDistance) {
    return Path()
      ..addOval(
        Rect.fromLTWH(
          -centerFirstDistance,
          -centerSecondDistance,
          centerFirstDistance * 2,
          centerSecondDistance * 2,
        ),
      );
  }

  @override
  String toString() => 'Ellipse -> { '
      'center: $center, firstConjugateDiameter: $firstConjugateDiameterEndPoint,'
      'secondConjugateDiameter: $secondConjugateDiameterEndPoint'
      ' }';

  @override
  void paint(CGMDisplay display) {
    initializeShape(display);

    display.canvas.drawPath(shape!, display.linePaint!);
  }
}
