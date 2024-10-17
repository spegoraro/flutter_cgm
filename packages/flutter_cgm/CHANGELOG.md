## 0.0.1

* Initial release

## 0.0.2

* Add CGMWidget to exports

## 0.0.3

Additions:
- Added example project, showcasing basic usage and features.
- Added support for specifying a color and blend mode in `CGMWidget`
- `CGMWidget` can now render both raster and vector representations of a file,
  with the use of the `rasterize` property.


Fixes:
- `CGMWidget` now renders raster images better, using bilinear interpolation. 
    This helps with quality if the image is scaled up.
