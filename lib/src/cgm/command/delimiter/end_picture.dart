import 'package:flutter_cgm/src/cgm/command/command.dart';

class EndPicture extends Command {
  EndPicture(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  String toString() => 'EndPicture ';
}
