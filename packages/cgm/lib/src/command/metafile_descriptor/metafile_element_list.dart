import 'package:cgm/cgm.dart';

class MetafileElementList extends Command {
  late List<String> _metafileElements;

  MetafileElementList(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final nElements = makeInt();

    _metafileElements = List.filled(nElements, '');

    for (var i = 0; i < nElements; i++) {
      var code1 = makeIndex();
      var code2 = makeIndex();
      if (code1 == -1) {
        _metafileElements[i] = switch (code2) {
          0 => 'DRAWING SET',
          1 => 'DRAWING PLUS CONTROL SET',
          2 => 'VERSION 2 SET',
          3 => 'EXTENDED PRIMITIVES SET',
          4 => 'VERSION 2 GKSM SET',
          5 => 'VERSION 3 SET',
          6 => 'VERSION 4 SET',
          _ => 'UNKNOWN'
        };
      } else {
        _metafileElements[i] = ' ($code1, $code2)';
      }
    }
  }

  @override
  toString() => 'MetafileElementList -> { metafileElements: $_metafileElements } ';
}
