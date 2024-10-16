import 'package:cgm/cgm.dart';

class JoinCommand extends Command {
  late final JoinIndicator type;

  JoinCommand(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeIndex();
    type = switch (index) {
      1 => JoinIndicator.unspecified,
      2 => JoinIndicator.mitre,
      3 => JoinIndicator.round,
      4 => JoinIndicator.bevel,
      _ => JoinIndicator.unspecified,
    };
  }
}
