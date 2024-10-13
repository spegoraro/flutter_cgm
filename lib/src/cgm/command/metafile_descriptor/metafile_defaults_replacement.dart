import 'package:buffer/buffer.dart';
import 'package:flutter_cgm/src/cgm/cgm.dart';

class MetafileDefaultsReplacement extends Command {
  late final Command _embeddedCommand;

  MetafileDefaultsReplacement(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    int k = makeUInt(16);

    int ec = k >> 12;
    int eid = (k >> 5) & 127;

    int nArgs = k & 31;
    if (nArgs == 31) {
      nArgs = makeUInt(16);
    }

    final commandArguments = List<int>.filled(nArgs, 0);
    int c = 0;
    while (c < nArgs) {
      commandArguments[c++] = makeByte();
    }

    _embeddedCommand = Command.readCommand(
      ByteDataReader()..add(commandArguments),
      cgm,
      ec,
      eid,
      commandArguments.length,
    );
  }

  @override
  void paint(CGMDisplay display) => _embeddedCommand.paint(display);

  @override
  toString() => 'MetafileDefaultsReplacement -> { embeddedCommand: $_embeddedCommand }';
}
