import 'dart:math';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/extension.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

class Ellipse extends Command {
  late final Point<double> center;
  late final Point<double> firstConjugateDiameterEndPoint;
  late final Point<double> secondConjugateDiameterEndPoint;

  late Matrix4 transformation;

  Ellipse(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    center = makePoint();
    firstConjugateDiameterEndPoint = makePoint();
    secondConjugateDiameterEndPoint = makePoint();
  }

  @override
  String toString() => 'Ellipse -> { '
      'center: $center, firstConjugateDiameter: $firstConjugateDiameterEndPoint,'
      'secondConjugateDiameter: $secondConjugateDiameterEndPoint'
      ' }';
}
