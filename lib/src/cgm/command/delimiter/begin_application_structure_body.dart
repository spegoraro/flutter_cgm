import 'package:flutter_cgm/src/cgm/cgm.dart';

class BeginApplicationStructureBody extends Command {
  BeginApplicationStructureBody(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'BeginApplicationStructureBody ';
}
