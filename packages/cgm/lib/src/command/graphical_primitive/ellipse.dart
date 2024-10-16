import 'dart:math';

import 'package:vector_math/vector_math.dart';
import 'dart:typed_data';

import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';

class Ellipse extends Command {
  late final Vector2 center;
  late final Vector2 firstConjugateDiameterEndPoint;
  late final Vector2 secondConjugateDiameterEndPoint;

  @protected
  CGMPath? shape;

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

    shape = createShape(display, centerFirstDistance, centerSecondDistance);

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

    CGMPath transformedShape = shape!.transform(Float64List.fromList(translationMatrix.storage));
    shape = transformedShape;
  }

  @protected
  void applyArcs(CGMDisplay display, Matrix4 transform) {} // Implemented in subclasses

  @protected
  CGMPath createShape(CGMDisplay display, double centerFirstDistance, double centerSecondDistance) {
    return display.canvas.createPath()
      ..addOval(
        center: Vector2(
          -centerFirstDistance,
          -centerSecondDistance,
        ),
        radii: Vector2(
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
