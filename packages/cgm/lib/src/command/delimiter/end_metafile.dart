import 'package:cgm/cgm.dart';

class EndMetafile extends Command {
  EndMetafile(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndMetafile ';
}
