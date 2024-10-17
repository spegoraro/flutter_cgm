import 'dart:ui' as ui;

import 'package:cgm/cgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cgm/flutter_cgm.dart';
import 'package:flutter_cgm/src/cgm_widget.dart';
import 'package:flutter_cgm/src/raster.dart';

class RenderCGM extends RenderBox {
  RenderCGM({
    required CGM cgm,
    required PictureInfo pictureInfo,
    required Object assetKey,
    required double devicePixelRatio,
    required Animation<double>? opacity,
    required double scale,
    required bool rasterize,
    Color? color,
    BlendMode? blendMode,
  })  : _cgm = cgm,
        _pictureInfo = pictureInfo,
        _assetKey = assetKey,
        _devicePixelRatio = devicePixelRatio,
        _opacity = opacity,
        _color = color,
        _blendMode = blendMode,
        _rasterize = rasterize,
        _scale = scale {
    _opacity?.addListener(_updateOpacity);
    _updateOpacity();
  }

  static final Map<RasterKey, RasterData> _liveRasterCache = {};

  /// Whether to rasterize the [CGM] before rendering.
  /// This is useful for performance, at the cost of scalability.
  bool get rasterize => _rasterize;
  bool _rasterize;
  set rasterize(bool value) {
    if (_rasterize == value) return;

    _rasterize = value;
    markNeedsPaint();
  }

  /// The [CGM] to render.
  CGM get cgm => _cgm;
  CGM _cgm;
  set cgm(CGM value) {
    if (_cgm == value) return;

    _cgm = value;
    markNeedsPaint();
  }

  /// The key of the asset that the [CGM] was loaded from.
  Object get assetKey => _assetKey;
  Object _assetKey;
  set assetKey(Object value) {
    if (_assetKey == value) return;

    _assetKey = value;
  }

  /// The [PictureInfo] to render.
  PictureInfo get pictureInfo => _pictureInfo;
  PictureInfo _pictureInfo;
  set pictureInfo(PictureInfo value) {
    if (identical(value, _pictureInfo)) return;

    _pictureInfo = value;
    markNeedsPaint();
  }

  /// The device pixel ratio of the screen.
  double get devicePixelRatio => _devicePixelRatio;
  double _devicePixelRatio;
  set devicePixelRatio(double value) {
    if (_devicePixelRatio == value) return;

    _devicePixelRatio = value;
    markNeedsPaint();
  }

  double _opacityValue = 1.0;

  /// The opacity animation to apply to the [CGM].
  Animation<double>? get opacity => _opacity;
  Animation<double>? _opacity;
  set opacity(Animation<double>? value) {
    if (_opacity == value) return;

    _opacity?.removeListener(_updateOpacity);
    _opacity = value;
    _opacity?.addListener(_updateOpacity);
    markNeedsPaint();
  }

  void _updateOpacity() {
    if (_opacity == null) return;

    final double newValue = _opacity!.value;
    if (_opacityValue == newValue) return;

    _opacityValue = newValue;
    markNeedsPaint();
  }

  /// The scale to apply to the [CGM] raster.
  /// Ignored if [rasterize] is ***false***.
  double get scale => _scale;
  double _scale;
  set scale(double value) {
    assert(value > 0.0, 'Scale must be greater than 0');
    if (_scale == value) return;

    _scale = value;
    markNeedsPaint();
  }

  /// The color to apply to the [CGM].
  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color == value) return;

    _color = value;
    markNeedsPaint();
  }

  /// The blend mode to apply to the [CGM].
  BlendMode? get blendMode => _blendMode;
  BlendMode? _blendMode;
  set blendMode(BlendMode? value) {
    if (_blendMode == value) return;

    _blendMode = value;
    markNeedsPaint();
  }

  RasterData? _rasterData;

  @override
  bool hitTestSelf(ui.Offset position) => true;

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.smallest;

  static RasterData _createRaster(CGM cgm, RasterKey key, double scaleFactor, PictureInfo pictureInfo) {
    final int scaledWidth = key.width;
    final int scaledHeight = key.height;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);

    // final cgmDisplay = CGMDisplay(cgm);
    // cgmDisplay.scale(scaledWidth.toDouble(), scaledHeight.toDouble());
    // cgmDisplay.paint(canvas);

    canvas.scale(scaleFactor);
    canvas.drawPicture(pictureInfo.picture);
    final ui.Picture picture = recorder.endRecording();

    final ui.Image image = picture.toImageSync(scaledWidth, scaledHeight);

    return RasterData(cgm, image, 0, key);
  }

  void _maybeReleaseRaster(RasterData? data) {
    if (data == null) return;

    data.count -= 1;
    if (data.count == 0 && _liveRasterCache.containsKey(data.key)) {
      _liveRasterCache.remove(data.key);
      data.dispose();
    }
  }

  void _maybeUpdateRaster() {
    final int scaledWidth = (pictureInfo.size.width * devicePixelRatio / scale).round();
    final int scaledHeight = (pictureInfo.size.height * devicePixelRatio / scale).round();

    final RasterKey key = RasterKey(assetKey, scaledWidth, scaledHeight);

    if (_liveRasterCache.containsKey(key)) {
      final RasterData data = _liveRasterCache[key]!;
      if (data != _rasterData) {
        _maybeReleaseRaster(_rasterData);
        data.count += 1;
      }
      _rasterData = data;
      return;
    }

    final RasterData data = _createRaster(cgm, key, devicePixelRatio / scale, pictureInfo);
    data.count += 1;

    assert(!_liveRasterCache.containsKey(key));
    assert(data.count == 1);
    assert(!debugDisposed!);

    _liveRasterCache[key] = data;
    _maybeReleaseRaster(_rasterData);
    _rasterData = data;
  }

  @override
  void attach(PipelineOwner owner) {
    _opacity?.addListener(_updateOpacity);
    _updateOpacity();

    super.attach(owner);
  }

  @override
  void detach() {
    _opacity?.removeListener(_updateOpacity);

    super.detach();
  }

  @override
  void dispose() {
    _maybeReleaseRaster(_rasterData);
    _opacity?.removeListener(_updateOpacity);

    super.dispose();
  }

  @override
  void paint(PaintingContext context, ui.Offset offset) {
    if (!rasterize) {
      final canvas = FlutterCGMCanvas(context.canvas);
      canvas.translate(offset.dx, offset.dy);
      final cgmDisplay = CGMDisplay(cgm);

      cgmDisplay.scale(pictureInfo.size.width, pictureInfo.size.height);
      cgmDisplay.paint(canvas);
      final paint = Paint();

      paint.color = const Color.fromRGBO(0, 0, 0, 0);
      if (blendMode != null) paint.blendMode = blendMode!;
      if (color != null) paint.color = color!;

      canvas.canvas.drawPaint(paint);
      // context.canvas.drawColor(Colors.blue, BlendMode.colorBurn);
    } else {
      _maybeUpdateRaster();
      final ui.Image image = _rasterData!.image;
      final int width = _rasterData!.key.width;
      final int height = _rasterData!.key.height;

      final ui.Rect src = ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());

      final ui.Rect dst = ui.Rect.fromLTWH(offset.dx, offset.dy, pictureInfo.size.width, pictureInfo.size.height);

      final paint = Paint();
      paint.filterQuality = FilterQuality.low;
      paint.color = color ?? const Color.fromRGBO(0, 0, 0, 0);
      if (blendMode != null) paint.colorFilter = ColorFilter.mode(paint.color, blendMode!);
      paint.color = paint.color.withOpacity(_opacityValue);

      context.canvas.drawImageRect(image, src, dst, paint);
    }
  }
}
