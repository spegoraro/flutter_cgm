import 'package:cgm/cgm.dart';

class ClipIndicator extends Command {
  late final bool _flag;

  ClipIndicator(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _flag = makeEnum() == 1;
  }

  @override
  void paint(CGMDisplay display) {
    display.setFlag(clip: _flag);
  }

  @override
  toString() => 'ClipIndicator -> { $_flag } ';
}
