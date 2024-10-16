import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class MaximumVDCExtent extends Command {
  late final Vector2 firstCorner;
  late final Vector2 secondCorner;

  MaximumVDCExtent(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    firstCorner = makePoint();
    secondCorner = makePoint();
  }

  @override
  toString() => 'MaximumVDCExtent -> { firstCorner: $firstCorner, secondCorner: $secondCorner } ';
}
