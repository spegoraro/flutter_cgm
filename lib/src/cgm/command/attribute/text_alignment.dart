import 'package:flutter_cgm/src/cgm/cgm.dart';

enum HorizontalAlignment { normalHorizontal, left, center, right, continuousHorizontal }

enum VerticalAlignment { normalVertical, top, cap, half, base, bottom, continuousVertical }

class TextAlignment extends Command {
  late final HorizontalAlignment horizontalAlignment;
  late final VerticalAlignment verticalAlignment;
  late final double continuousHorizontalAlignment;
  late final double continuousVerticalAlignment;

  TextAlignment(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    horizontalAlignment = switch (makeEnum()) {
      0 => HorizontalAlignment.normalHorizontal,
      1 => HorizontalAlignment.left,
      2 => HorizontalAlignment.center,
      3 => HorizontalAlignment.right,
      4 => HorizontalAlignment.continuousHorizontal,
      _ => HorizontalAlignment.normalHorizontal,
    };

    verticalAlignment = switch (makeEnum()) {
      0 => VerticalAlignment.normalVertical,
      1 => VerticalAlignment.top,
      2 => VerticalAlignment.cap,
      3 => VerticalAlignment.half,
      4 => VerticalAlignment.base,
      5 => VerticalAlignment.bottom,
      6 => VerticalAlignment.continuousVertical,
      _ => VerticalAlignment.normalVertical,
    };

    continuousHorizontalAlignment = makeReal();
    continuousVerticalAlignment = makeReal();
  }

  @override
  void paint(CGMDisplay display) {
    display.setTextAlignment(
      vertical: verticalAlignment,
      horizontal: horizontalAlignment,
      continuousVertical: continuousVerticalAlignment,
      continuousHorizontal: continuousHorizontalAlignment,
    );
  }

  @override
  String toString() => 'TextAlignment -> { horizontalAlignment: $horizontalAlignment, verticalAlignment:'
      '$verticalAlignment, continuousHorizontalAlignment: $continuousHorizontalAlignment, continuousVerticalAlignment:'
      '$continuousVerticalAlignment }';
}
