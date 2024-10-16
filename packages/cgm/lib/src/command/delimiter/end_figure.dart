import 'package:cgm/cgm.dart';

class EndFigure extends Command {
  EndFigure(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndFigure ';
}
