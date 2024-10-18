import 'package:cgm/cgm.dart';

class CircularArcCenterClose extends CircularArcCenter {
  late final int _type;

  CircularArcCenterClose(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _type = makeEnum();
  }

  @override
  String toString() => 'CircularArcCenterClose -> { '
      'center: $center, '
      'startDelta: $startDelta, '
      'endDelta: $endDelta, '
      'radius: $radius, '
      'type: $_type'
      ' } ';
}
