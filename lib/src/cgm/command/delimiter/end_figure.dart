import 'package:flutter_cgm/src/cgm/command/command.dart';

class EndFigure extends Command {
  EndFigure(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndFigure ';
}
