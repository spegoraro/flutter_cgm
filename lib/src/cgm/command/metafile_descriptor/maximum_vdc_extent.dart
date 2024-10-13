import 'dart:math';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class MaximumVDCExtent extends Command {
  late final Point firstCorner;
  late final Point secondCorner;

  MaximumVDCExtent(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    firstCorner = makePoint();
    secondCorner = makePoint();
  }

  @override
  toString() => 'MaximumVDCExtent -> { firstCorner: $firstCorner, secondCorner: $secondCorner } ';
}

