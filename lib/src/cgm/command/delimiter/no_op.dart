import 'package:flutter_cgm/src/cgm/command/command.dart';

class NoOp extends Command {
  NoOp(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'NoOp ';
}
