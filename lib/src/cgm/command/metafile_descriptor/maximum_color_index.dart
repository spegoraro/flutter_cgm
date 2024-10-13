import 'package:flutter_cgm/src/cgm/cgm.dart';

class MaximumColorIndex extends Command {
  late final int _maxColorIndex;

  MaximumColorIndex(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _maxColorIndex = makeColorIndex();
  }

  @override
  toString() => 'MaximumColorIndex -> { $_maxColorIndex } ';
}
