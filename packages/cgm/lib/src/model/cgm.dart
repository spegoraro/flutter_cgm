// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:cgm/cgm.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

/// The [CGM] class parses and stores the commands of a ***Computer Graphics Metafile (CGM)*** file.
///
/// The class provides a method to paint the CGM file's commands to a [CGMCanvas] object.
class CGM {
  @internal
  final Logger logger = Logger('CGM');

  late List<Command> _commands;

  /// The parsed commands of the input ***CGM*** file.
  List<Command> get commands => _commands;
  int integerPrecision = 16;
  int indexPrecision = 16;
  int namePrecision = 16;
  int vdcIntegerPrecision = 16;
  VDCTypeType vdcType = VDCTypeType.integer;
  RealPrecisionType realPrecision = RealPrecisionType.fixed32;
  bool realPrecisionProcessed = false;
  VDCRealPrecisionType vdcRealPrecision = VDCRealPrecisionType.fixedPoint32bit;
  ColorSelectionType colorSelectionMode = ColorSelectionType.indexed;
  int colorIndexPrecision = 8;
  int colorPrecision = 8;
  ColorModelType colorModel = ColorModelType.rgb;
  List<int> minimumColorValueRGB = [0, 0, 0];
  List<int> maximumColorValueRGB = [255, 255, 255];
  DeviceViewportSpecificationType deviceViewportSpecificationMode =
      DeviceViewportSpecificationType.fractionOfDrawingSurface;
  SpecificationMode lineWidthSpecificationMode = SpecificationMode.absolute;
  SpecificationMode markerSizeSpecificationMode = SpecificationMode.absolute;
  SpecificationMode edgeWidthSpecificationMode = SpecificationMode.absolute;
  RestrictedTextTypeType restrictedTextType = RestrictedTextTypeType.basic;

  /// Creates a new instance of the [CGM] class.
  CGM(Uint8List bytes) {
    final buffer = ByteDataReader()..add(bytes);

    _read(buffer);
  }

  /// Creates a new instance of the [CGM] class, with the input [File].
  ///
  /// Throws a [FileSystemException] if the file is not found.
  CGM.fromFile(File file) {
    if (!file.existsSync()) {
      throw FileSystemException('File not found', file.path);
    }

    final buffer = ByteDataReader()..add(file.readAsBytesSync());

    _read(buffer);
  }

  /// Creates a new instance of the [CGM] class, using the file at the input [path].
  ///
  /// Throws a [FileSystemException] if the file is not found.
  CGM.fromPath(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw FileSystemException('File not found', path);
    }

    final buffer = ByteDataReader()..add(file.readAsBytesSync());
    _read(buffer);
  }

  /// Called by [CGMCanvas] to paint the [commands] of the [CGM] object.
  void paint(CGMDisplay display) {
    for (final command in _commands) {
      switch (command) {
        case BeginFigure beginFigure:
          display.currentFigure = beginFigure;
          display.currentPolyBezier.clear();

        case EndFigure _:
          if (display.currentPolyBezier.isNotEmpty) {
            final polyBezier = _mergePolyBezier(display.currentPolyBezier);
            polyBezier.paint(display, display.currentFigure);
          }
          display.currentPolyBezier.clear();
          display.currentFigure = null;

        case PolyBezier polyBezier:
          if (display.currentFigure == null) {
            polyBezier.paint(display, null);
          } else {
            display.currentPolyBezier.add(polyBezier);
          }

        default:
          command.paint(display);
      }
    }
  }

  void _read(ByteDataReader buffer) {
    reset();
    _commands = <Command>[];

    // A while loop calls Command.read() until the end of the file is reached.
    while (true) {
      final command = Command.read(buffer, this);
      if (command == null) break;

      // TODO: command listeners?

      command.cleanupArguments();
      _commands.add(command);
    }
  }

  /// Returns a list of the extents of the parsed [CGM], if it exists.
  ///
  /// The extents are the minimum and maximum values of the VDC space.
  List<Vector2>? getExtent() {
    for (final command in _commands) {
      if (command is VDCExtent) {
        return command.extent;
      }
    }

    return null;
  }

  /// Returns the scaling mode of the parsed [CGM], if it exists.
  ScalingMode? getScalingMode() {
    for (final command in _commands) {
      if (command is ScalingMode) return command;
    }

    return null;
  }

  /// Returns the size of the parsed [CGM] in pixels, if the file has extents.
  Vector2? getSize([double dpi = 96]) {
    final extent = getExtent();
    if (extent == null) return null;

    double factor = 1;

    final scalingMode = getScalingMode();
    if (scalingMode != null) {
      final type = scalingMode.mode;
      if (type == ScalingType.metric) {
        final metricScalingFactor = scalingMode.metricScalingFactor;
        if (metricScalingFactor != 0) {
          factor = (dpi * metricScalingFactor) / 25.4;
        }
      }
    }

    final width = ((extent[1].x - extent[0].x).abs() * factor).ceil();
    final height = ((extent[1].y - extent[0].y).abs() * factor).ceil();

    return Vector2(width.toDouble(), height.toDouble());
  }

  /// Merges a list of [PolyBezier] objects into a single [PolyBezier] object.
  PolyBezier _mergePolyBezier(List<PolyBezier> tomerge) {
    PolyBezier ret = tomerge.first;
    if (tomerge.length == 1) {
      return ret;
    }
    for (int i = 1; i < tomerge.length; i++) {
      ret.mergeShape(tomerge[i]);
    }
    return ret;
  }

  void reset() {
    // TODO: Reset all state variables.
  }
}
