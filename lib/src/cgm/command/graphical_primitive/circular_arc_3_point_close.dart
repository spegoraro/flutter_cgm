import 'package:flutter_cgm/src/cgm/command/graphical_primitive/graphical_primitive.dart';

class CircularArc3PointClose extends CircularArc3Point {
  late final int type;

  CircularArc3PointClose(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    type = switch (index) {
      0 => 0,
      1 => 1,
      _ => 1,
    };
  }

  @override
  String toString() => 'CircularArc3PointClose';
}
