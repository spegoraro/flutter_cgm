import 'package:flutter_cgm/src/cgm/cgm.dart';

class TextFontIndex extends Command {
  late final int fontIndex;

  TextFontIndex(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    fontIndex = makeIndex();
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'TextFontIndex -> $fontIndex';
}
