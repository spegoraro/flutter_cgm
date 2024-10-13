import 'package:flutter_cgm/src/cgm/cgm.dart';

class MetafileVersion extends Command {
  late final int version;

  MetafileVersion(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    version = makeInt();
  }

  @override
  toString() => 'MetafileVersion -> { version: $version } ';
}
