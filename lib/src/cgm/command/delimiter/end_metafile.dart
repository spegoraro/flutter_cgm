import 'package:flutter_cgm/src/cgm/command/command.dart';

class EndMetafile extends Command {
  EndMetafile(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndMetafile ';
}
