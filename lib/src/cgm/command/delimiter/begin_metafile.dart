import 'package:buffer/buffer.dart';
import 'package:flutter_cgm/src/cgm/command/command.dart';
import 'package:flutter_cgm/src/cgm/model/cgm.dart';

class BeginMetafile extends Command {
  late final String _fileName;
  String get fileName => _fileName;

  BeginMetafile(int ec, int eid, int l, ByteDataReader buffer, CGM cgm) : super(ec, eid, l, buffer, cgm) {
    _fileName = l > 0 ? makeString() : '';
  }

  @override
  String toString() => 'BeginMetafile: $fileName';
}
