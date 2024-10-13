import 'package:flutter_cgm/src/cgm/command/command.dart';

class BeginFigure extends Command {
  BeginFigure(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'BeginFigure ';
}
