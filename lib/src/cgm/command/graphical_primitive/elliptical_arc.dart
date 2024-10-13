import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:vector_math/vector_math.dart';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class EllipticalArc extends Ellipse {
  late final double startVectorDeltaX;
  late final double startVectorDeltaY;
  late final double endVectorDeltaX;
  late final double endVectorDeltaY;
  Path? path;

  EllipticalArc(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    startVectorDeltaX = makeVdc();
    startVectorDeltaY = makeVdc();
    endVectorDeltaX = makeVdc();
    endVectorDeltaY = makeVdc();
  }

  double angle(double x, double y) {
    return normalizeAngle(atan2(y, x));
  }

  double normalizeAngle(double angle) {
    if (angle < 0) {
      return angle + 2 * pi;
    }

    return angle;
  }

  void _initializePath() {
    bool clockwise = true;

    double firstConjugateAngle = angle(
      firstConjugateDiameterEndPoint.y - center.y,
      firstConjugateDiameterEndPoint.x - center.x,
    );
    double secondConjugateAngle = angle(
      secondConjugateDiameterEndPoint.y - center.y,
      secondConjugateDiameterEndPoint.x - center.x,
    );

    if (firstConjugateAngle > secondConjugateAngle) {
      if (firstConjugateAngle - secondConjugateAngle < pi) {
        clockwise = true;
      } else {
        clockwise = false;
      }
    } else {
      if (secondConjugateAngle - firstConjugateAngle < pi) {
        clockwise = false;
      } else {
        clockwise = true;
      }
    }

    var centerSecondDistance = center.distanceTo(secondConjugateDiameterEndPoint);

    firstConjugateAngle = atan2(
      firstConjugateDiameterEndPoint.y - center.y,
      firstConjugateDiameterEndPoint.x - center.x,
    );

    final secondFirstConjugateAngle = atan2(
          secondConjugateDiameterEndPoint.y - center.y,
          secondConjugateDiameterEndPoint.x - center.x,
        ) -
        firstConjugateAngle;

    centerSecondDistance = sin(secondFirstConjugateAngle).abs() * centerSecondDistance;

    path = Path();
    path!.moveTo(
      center.x + startVectorDeltaX,
      center.y + startVectorDeltaY,
    );
    path!.arcToPoint(
      Offset(
        center.x + endVectorDeltaX,
        center.y + endVectorDeltaY,
      ),
      radius: Radius.elliptical(
        centerSecondDistance * 2.0,
        centerSecondDistance * 2.0,
      ),
      largeArc: false,
      clockwise: clockwise,
    );
  }

  @override
  void paint(CGMDisplay display) {
    if (path == null) _initializePath();

    final Canvas canvas = display.canvas;
    final Paint paint = display.linePaint!;

    canvas.drawPath(path!, paint);
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
