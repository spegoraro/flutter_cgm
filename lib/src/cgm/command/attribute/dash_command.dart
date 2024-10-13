import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:meta/meta.dart';

class DashCommand extends Command {
  @protected
  late final DashType type;

  DashCommand(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    type = DashType.from(makeIndex());
  }
}
