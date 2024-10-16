import 'package:cgm/cgm.dart';

class NoOp extends Command {
  NoOp(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'NoOp ';
}
