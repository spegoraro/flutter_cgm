import 'package:cgm/cgm.dart';

enum TextPathType { right, left, up, down }

class TextPath extends Command {
  late final TextPathType path;

  TextPath(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final pathType = makeIndex();
    path = switch (pathType) {
      0 => TextPathType.right,
      1 => TextPathType.left,
      2 => TextPathType.up,
      3 => TextPathType.down,
      _ => TextPathType.right,
    };
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'TextPath -> ${path.name}';
}
