import 'package:cgm/cgm.dart';

class EllipticalArcClose extends EllipticalArc {
  late final int type;

  EllipticalArcClose(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();

    // TODO: jcgm used Arc2D.CHORD and Arc2D.PIE
    type = switch (index) {
      0 => 0,
      1 => 1,
      _ => 1,
    };
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'EllipticalArcClose -> { '
      'center: $center, '
      'firstConjugateDiameter: $firstConjugateDiameterEndPoint, '
      'secondConjugateDiameter: $secondConjugateDiameterEndPoint, '
      'startVectorDeltaX: $startVectorDeltaX, '
      'startVectorDeltaY: $startVectorDeltaY, '
      'endVectorDeltaX: $endVectorDeltaX, '
      'endVectorDeltaY: $endVectorDeltaY, '
      'type: $type'
      ' }';
}
