import 'package:cgm/cgm.dart';
import 'package:cgm/src/render/color.dart';

class BackgroundColor extends Command {
  late final Color backgroundColor;

  BackgroundColor(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    backgroundColor = makeDirectColor();
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() {
    return 'Background Color -> $backgroundColor';
  }
}
