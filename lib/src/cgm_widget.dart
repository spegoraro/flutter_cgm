import 'package:flutter/material.dart';
import 'package:flutter_cgm/src/cgm/model/model.dart';

class CGMWidget extends SingleChildRenderObjectWidget {
  final CGM cgm;

  const CGMWidget(this.cgm, {super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CGMRenderObject(cgm);
  }
}

class CGMRenderObject extends RenderBox {
  final CGM cgm;
  CGMDisplay? display;

  CGMRenderObject(this.cgm);

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) => constraints.smallest;

  @override
  void paint(PaintingContext context, Offset offset) {
    display ??= CGMDisplay(cgm);
    context.canvas.translate(offset.dx, offset.dy);
    display?.scale(size.width, size.height);
    display?.paint(context.canvas);
  }
}
