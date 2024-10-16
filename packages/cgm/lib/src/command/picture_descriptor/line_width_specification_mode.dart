import 'package:cgm/cgm.dart';

class LineWidthSpecificationMode extends Command {
  LineWidthSpecificationMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    final mode = SpecificationMode.getMode(index);

    cgm.lineWidthSpecificationMode = mode;
  }

  @override
  String toString() => 'LineWidthSpecificationMode -> ${cgm.lineWidthSpecificationMode}';
}
