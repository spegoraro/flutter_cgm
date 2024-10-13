import 'dart:math';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:meta/meta.dart';

abstract class TextCommand extends Command {
  @protected
  late final String text;
  @protected
  late final Point<double> position;
  @protected
  late final bool finalFlag;
  @protected
  bool stringComplete = true;

  TextCommand(super.ec, super.eid, super.l, super.buffer, super.cgm);

  Point<double> getTextOffset(CGMDisplay display);

  @protected
  void scaleText(CGMDisplay display);
}
