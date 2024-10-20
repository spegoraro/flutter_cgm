## 0.0.1

- Initial release.

## 0.0.2

Fixes:

- Fixed issues caused by the library's separation from
  flutter dependencies.
  - EllipticalArc didn't have the correct radius specified.
  - Polybezier didn't work with subpaths, and didn't render. Now it uses just a single
    path.
  - Polyline didn't render at all, don't know why. Now it does.

## 0.0.3

Fixes:

- Fixed some issues with elliptical arcs.
