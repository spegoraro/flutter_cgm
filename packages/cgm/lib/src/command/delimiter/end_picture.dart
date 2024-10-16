import 'package:cgm/cgm.dart';

class EndPicture extends Command {
  EndPicture(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndPicture ';
}
