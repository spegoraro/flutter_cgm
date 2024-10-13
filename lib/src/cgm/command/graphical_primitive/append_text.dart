import 'package:flutter_cgm/src/cgm/cgm.dart';

class AppendText extends Command {
  late final String string;
  late final bool finalNotFinal;

  late bool executed = false;

  AppendText(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    finalNotFinal = makeEnum() >= 1;
    string = makeString();
  }

  @override
  void paint(CGMDisplay display) {
    if (executed) return;

    executed = true;

    // TODO: Implement paint
  }

  @override
  String toString() => 'AppendText -> { string: $string } ';
}
