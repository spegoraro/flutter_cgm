import 'dart:ui' as ui;

import 'package:cgm/cgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cgm/flutter_cgm.dart';
import 'package:flutter_cgm/src/render_cgm.dart';

class PictureInfo {
  PictureInfo(this.picture, this.size);

  final ui.Picture picture;

  final Size size;
}

PictureInfo _renderPicture(CGM cgm, Size size) {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder, ui.Rect.fromLTWH(0, 0, size.width, size.height));

  final cgmDisplay = CGMDisplay(cgm);
  cgmDisplay.scale(size.width, size.height);
  cgmDisplay.paint(FlutterCGMCanvas(canvas));

  return PictureInfo(recorder.endRecording(), size);
}

class CGMWidget extends StatelessWidget {
  final CGM cgm;
  final double scale;

  /// The width of the renndered [CGM],
  /// if null, the width will be the largest width that fits
  /// the [CGMWidget.height] while maintaining the aspect ratio.
  final double? width;

  /// The height of the rendered [CGM],
  /// if null, the height will be the largest height that fits
  /// the [CGMWidget.width] while maintaining the aspect ratio.
  final double? height;

  const CGMWidget({
    super.key,
    required this.cgm,
    this.scale = 1,
    this.width = 300,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = cgm.getSize();
        if (size == null) {
          return const SizedBox();
        }

        final aspectRatio = size.x / size.y;
        double x, y;
        if (width != null) {
          x = width!;
          y = width! / aspectRatio;
        } else if (height != null) {
          x = height! * aspectRatio;
          y = height!;
        } else {
          x = constraints.maxWidth;
          y = constraints.maxHeight;
        }

        return SizedBox(
          width: x,
          height: y,
          child: RawCGMWidget(
            cgm: cgm,
            scale: scale,
            size: Size(x, y),
          ),
        );
      },
    );
  }
}

class RawCGMWidget extends SingleChildRenderObjectWidget {
  final CGM cgm;
  final double scale;
  final Size size;

  const RawCGMWidget({required this.cgm, super.key, required this.scale, required this.size});

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderCGM).scale = scale;
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    final pictureInfo = _renderPicture(cgm, size);
    return RenderCGM(
      cgm: cgm,
      assetKey: Object(),
      scale: scale,
      opacity: null,
      pictureInfo: pictureInfo,
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
    );
  }
}
