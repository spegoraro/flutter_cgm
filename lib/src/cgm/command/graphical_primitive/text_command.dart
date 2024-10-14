import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/extension.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

abstract class TextCommand extends Command {
  @protected
  late final String text;
  @protected
  late final Point<double> position;
  @protected
  late final bool finalFlag;
  @protected
  bool stringComplete = true;

  TextCommand(super.ec, super.eid, super.l, super.buffer, super.cgm);

  Point<double> getTextOffset(CGMDisplay display);

  @protected
  Vector2 scaleText(CGMDisplay display, LineMetrics lineMetrics);

  @override
  void paint(CGMDisplay display) {
    if (text.trim().isEmpty) return;

    final random = Random();
    randomColor() => Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);

    final textStyle = TextStyle(
      color: randomColor(),
      fontFamily: 'Atkinson Hyperlegible',
      fontWeight: FontWeight.w500,
    );

    final span = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    )..layout();

    final fontMetrics = textPainter.computeLineMetrics().first;
    final Vector2 scale = scaleText(display, fontMetrics);

    display.canvas.save();
    display.canvas.translate(position.x, position.y);
    display.canvas.scale(scale.x, -scale.y);

    final offset = getTextOffset(display);
    final finalPosition = offset.toOffset();

    textPainter.paint(display.canvas, finalPosition);
    display.canvas.restore();
  }
}
