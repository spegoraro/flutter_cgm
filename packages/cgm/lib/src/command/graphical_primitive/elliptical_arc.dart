import 'dart:math';

import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

double angle(double x, double y) {
  return normalizeAngle(atan2(y, x));
}

double normalizeAngle(double angle) {
  if (angle < 0) {
    return angle + 2.0 * pi;
  }

  return angle;
}

class EllipticalArc extends Ellipse {
  late final double startVectorDeltaX;
  late final double startVectorDeltaY;
  late final double endVectorDeltaX;
  late final double endVectorDeltaY;

  EllipticalArc(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    startVectorDeltaX = makeVdc();
    startVectorDeltaY = makeVdc();
    endVectorDeltaX = makeVdc();
    endVectorDeltaY = makeVdc();
  }

  @override
  void applyArcs(CGMDisplay display, Matrix4 transform) {
    final startVector = transform.transform3(Vector3(startVectorDeltaX, startVectorDeltaY, 0)).xy;
    final endVector = transform.transform3(Vector3(endVectorDeltaX, endVectorDeltaY, 0)).xy;

    final double firstConjugateAngle =
        angle(firstConjugateDiameterEndPoint.x - center.x, firstConjugateDiameterEndPoint.y - center.y);
    final double secondConjugateAngle =
        angle(secondConjugateDiameterEndPoint.x - center.x, secondConjugateDiameterEndPoint.y - center.y);

    // Vector2 finalStartVector = startVector;
    // Vector2 finalEndVector = endVector;

    // TODO: Improve calculation of the clockwise flag
    // bool clockwise = false;
    // if (firstConjugateAngle > secondConjugateAngle) {
    // if (firstConjugateAngle - secondConjugateAngle < pi) {
    //   finalStartVector = startVector;
    //   finalEndVector = endVector;
    // } else {
    //   finalStartVector = endVector;
    //   finalEndVector = startVector;
    // clockwise = true;
    // }
    // } else {
    // if (secondConjugateAngle - firstConjugateAngle < pi) {
    //   finalStartVector = endVector;
    //   finalEndVector = startVector;
    // } else {
    //   finalStartVector = startVector;
    //   finalEndVector = endVector;
    // clockwise = true;
    // }
    // }

    // _clockwise = clockwise;

    shape = display.canvas.createPath()
      ..moveTo(startVector.x, startVector.y)
      ..arcToPoint(
        endVector,
        radius: shape!.getBounds() / 2,
        clockwise: true,
      );
  }

  @override
  void paint(CGMDisplay display) {
    initializeShape(display);

    display.canvas.drawPath(shape!, display.linePaint!);
  }

  @override
  String toString() => 'EllipticalArc -> { '
      'center: $center, '
      'firstConjugateDiameter: $firstConjugateDiameterEndPoint, '
      'secondConjugateDiameter: $secondConjugateDiameterEndPoint, '
      'startVectorDeltaX: $startVectorDeltaX, '
      'startVectorDeltaY: $startVectorDeltaY, '
      'endVectorDeltaX: $endVectorDeltaX, '
      'endVectorDeltaY: $endVectorDeltaY'
      ' }';
}
