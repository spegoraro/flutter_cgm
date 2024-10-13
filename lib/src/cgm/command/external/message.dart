import 'package:flutter_cgm/src/cgm/cgm.dart';

class Message extends Command {
  late final int actionFlag;
  late final String message;

  Message(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    actionFlag = makeEnum();
    message = makeString();
  }

  @override
  String toString() => 'Message -> { '
      'actionFlag: $actionFlag, '
      'message: $message'
      ' }';
}
