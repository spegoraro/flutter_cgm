import 'package:buffer/buffer.dart';
import 'package:cgm/cgm.dart';

class BeginPicture extends Command {
  late final String _pictureName;
  String get pictureName => _pictureName;

  BeginPicture(int ec, int eid, int l, ByteDataReader buffer, CGM cgm) : super(ec, eid, l, buffer, cgm) {
    _pictureName = l > 0 ? makeString() : '';
  }

  @override
  String toString() => 'Begin Picture -> $_pictureName ';
}
