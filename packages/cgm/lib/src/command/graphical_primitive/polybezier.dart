import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class PolyBezier extends Command {
  late final int _continuityIndicator;

  CGMPath? path;

  late final List<Vector2> p1;
  late final List<Vector2> p2;
  late final List<Vector2> p3;
  late final List<Vector2> p4;

  PolyBezier(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _continuityIndicator = makeIndex();

    if (_continuityIndicator == 1) {
      final n = ((arguments.length - currentArgument) ~/ sizeOfPoint()) ~/ 4;

      p1 = List.filled(n, Vector2(0, 0));
      p2 = List.filled(n, Vector2(0, 0));
      p3 = List.filled(n, Vector2(0, 0));
      p4 = List.filled(n, Vector2(0, 0));

      int point = 0;
      while (point < n) {
        p1[point] = makePoint();
        p2[point] = makePoint();
        p3[point] = makePoint();
        p4[point] = makePoint();
        point++;
      }
    } else if (_continuityIndicator == 2) {
      final n = ((arguments.length - currentArgument - 1) ~/ sizeOfPoint()) ~/ 3;

      p1 = List.filled(n, Vector2(0, 0));
      p2 = List.filled(n, Vector2(0, 0));
      p3 = List.filled(n, Vector2(0, 0));
      p4 = List.filled(n, Vector2(0, 0));

      int point = 0;
      while (point < n) {
        if (point == 0) {
          p1[point] = makePoint();
        } else {
          p1[point] = p4[point - 1];
        }
        p2[point] = makePoint();
        p3[point] = makePoint();
        p4[point] = makePoint();
        point++;
      }
    } else {
      cgm.logger.warning('Invalid continuity indicator: $_continuityIndicator');
    }

    seed = getSeed();
  }

  void _initPath(CGMDisplay display) {
    path = display.canvas.createPath();

    // final paths = <CGMPath>[];

    for (int i = 0; i < p1.length; i++) {
      // final subPath = display.canvas.createPath();
      if (i == 0) {
        path!.moveTo(p1[i].x, p1[i].y);
      }
      // subPath.moveTo(p1[i].x, p1[i].y);
      // subPath.cubicTo(p2[i].x, p2[i].y, p3[i].x, p3[i].y, p4[i].x, p4[i].y);

      path!.cubicTo(p2[i].x, p2[i].y, p3[i].x, p3[i].y, p4[i].x, p4[i].y);

      // if (i == p1.length - 1) path!.close();

      // paths.add(subPath);
    }

    // for (final p in paths) {
    //   path!.extendWithPath(p);
    // }
  }

  getSeed() {
    final hash = StringBuffer();
    for (final p in p1) {
      hash.write(p.x);
      hash.write(p.y);
    }
    for (final p in p2) {
      hash.write(p.x);
      hash.write(p.y);
    }
    for (final p in p3) {
      hash.write(p.x);
      hash.write(p.y);
    }
    for (final p in p4) {
      hash.write(p.x);
      hash.write(p.y);
    }
    return hash.toString();
  }

  late String seed;

  @override
  void paint(CGMDisplay display, [BeginFigure? beginFigure]) {
    final mode = beginFigure == null ? 0 : 1;
    final canvas = display.canvas;
    if (path == null) _initPath(display);

    if (mode == 0) {
      canvas.drawPath(path!, display.linePaint!);
    } else {
      var paint = display.linePaint!;
      if (display.currentCGMPaintHolder?.edgeColor != null || display.currentCGMPaintHolder?.edgeWidth != null) {
        paint = display.edgePaint!;
      }

      if (display.currentCGMPaintHolder?.fillColor != null) {
        if (display.interiorStyle == InteriorStyleStyle.hatch) {
          //  TODO: implement hatch fill (what is hatch fill?)
        } else if (display.interiorStyle == InteriorStyleStyle.empty) {
          canvas.drawPath(path!, paint);
        } else {
          paint = display.fillPaint!;
          canvas.drawPath(path!, paint);
          if (display.drawEdge) {
            canvas.drawPath(path!, display.linePaint!);
          }
        }
      } else {
        if (display.interiorStyle == InteriorStyleStyle.solid) {
          canvas.drawPath(path!, display.fillPaint!);
          if (display.drawEdge) {
            canvas.drawPath(path!, display.edgePaint!);
          }
        } else {
          canvas.drawPath(path!, display.linePaint!);
        }
      }
    }
  }

  List<T> concatArray<T>(List<T> a1, List<T> a2) {
    List<T> ret = List<T>.filled(a1.length + a2.length, a1[0]);
    int index = 0;
    for (var a1Element in a1) {
      ret[index] = a1Element;
      index++;
    }
    for (var a2Element in a2) {
      ret[index] = a2Element;
      index++;
    }
    return ret;
  }

  void mergeShape(PolyBezier polyBezierV2) {
    p1 = concatArray(p1, polyBezierV2.p1);
    p2 = concatArray(p2, polyBezierV2.p2);
    p3 = concatArray(p3, polyBezierV2.p3);
    p4 = concatArray(p3, polyBezierV2.p4);
  }

  @override
  String toString() => 'PolyBezier -> { '
      '${_continuityIndicator == 1 ? 'discountinous' : _continuityIndicator == 2 ? 'continuous' : 'reserved'}, '
      'p1: [ ${p1.join(', ').replaceAll('Point', '')} ], '
      'p2: [ ${p2.join(', ').replaceAll('Point', '')} ], '
      'p3: [ ${p3.join(', ').replaceAll('Point', '')} ], '
      'p4: [ ${p4.join(', ').replaceAll('Point', '')} ] }';
}
