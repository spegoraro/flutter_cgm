import 'package:flutter_cgm/src/cgm/cgm.dart';

class BeginPictureBody extends Command {
  BeginPictureBody(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.reachedPictureBody();
  }

  @override
  String toString() => 'BeginPictureBody';
}
