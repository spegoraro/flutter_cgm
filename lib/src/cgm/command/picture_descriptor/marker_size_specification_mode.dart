import 'package:flutter_cgm/src/cgm/cgm.dart';

class MarkerSizeSpecificationMode extends Command {
  MarkerSizeSpecificationMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    final mode = SpecificationMode.getMode(index);

    cgm.markerSizeSpecificationMode = mode;
  }

  @override
  String toString() => 'MarkerSizeSpecificationMode -> ${cgm.markerSizeSpecificationMode}';
}
