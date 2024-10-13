import 'package:flutter_cgm/src/cgm/cgm.dart';

enum MarkerTypeType { dot, plus, asterisk, circle, cross }

class MarkerType extends Command {
  late final MarkerTypeType markerType;

  MarkerType(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeIndex();
    markerType = switch (index) {
      1 => MarkerTypeType.dot,
      2 => MarkerTypeType.plus,
      3 => MarkerTypeType.asterisk,
      4 => MarkerTypeType.circle,
      5 => MarkerTypeType.cross,
      _ => MarkerTypeType.asterisk,
    };
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'MarkerType -> ${markerType.name}';
}
