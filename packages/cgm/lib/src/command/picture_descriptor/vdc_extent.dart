import 'package:cgm/cgm.dart';
import 'package:vector_math/vector_math.dart';

class VDCExtent extends Command {
  late final Vector2 lowerLeft;
  late final Vector2 upperRight;

  VDCExtent(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    lowerLeft = makePoint();
    upperRight = makePoint();
  }

  List<Vector2> get extent => [lowerLeft, upperRight];

  @override
  String toString() => 'VDC Extent -> { lowerLeft: $lowerLeft, upperRight: $upperRight }';
}
