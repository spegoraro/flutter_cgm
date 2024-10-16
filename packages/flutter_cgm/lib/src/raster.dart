// Shamelessly copied from dnfield's vector_graphics package
// (but really thanks)

import 'dart:ui' as ui;

import 'package:cgm/cgm.dart';
import 'package:flutter/material.dart';

/// The cache key for a raster image.
@immutable
class RasterKey {
  const RasterKey(this.assetKey, this.width, this.height);

  /// An object used to identify the raster data this key represents.
  final Object assetKey;

  /// The width of the raster image, in physical pixels.
  final int width;

  /// The height of the raster image, in physical pixels.
  final int height;

  @override
  bool operator ==(Object other) {
    return other is RasterKey && other.assetKey == assetKey && other.width == width && other.height == height;
  }

  @override
  int get hashCode => Object.hash(assetKey, width, height);
}

class RasterData {
  RasterData(this._cgm, this._image, this.count, this.key);

  ui.Image? _image;
  ui.Image get image => _image!;

  CGM? _cgm;
  CGM get cgm => _cgm!;

  final RasterKey key;

  int count = 0;

  void dispose() {
    _image?.dispose();
    _image = null;
    _cgm = null;
  }
}
