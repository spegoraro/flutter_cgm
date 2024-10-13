// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/command/command.dart';
import 'package:buffer/buffer.dart';
import 'package:flutter_cgm/src/cgm/enum/enum.dart';
import 'package:flutter_cgm/src/cgm/model/model.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class CGM {
  @internal
  final Logger logger = Logger('CGM');

  late List<Command> _commands;
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

  //-< Constructor >-//
  CGM(File file) {
    if (!file.existsSync()) {
      throw Exception('File does not exist');
    }

    final bytes = file.readAsBytesSync();
    final buffer = ByteDataReader()..add(bytes);

    read(buffer);
  }

  /// Paints the CGM file's commands to the given [display].
  void paint(CGMDisplay display) {
    for (final command in _commands) {
      switch (command) {
        case BeginFigure beginFigure:
          display.currentFigure = beginFigure;
          display.currentPolyBezier.clear();

        case EndFigure _:
          if (display.currentPolyBezier.isNotEmpty) {
            final polyBezier = mergePB(display.currentPolyBezier);
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

  //-< Public methods >-//
  void read(ByteDataReader buffer) {
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

  List<Point<double>>? getExtent() {
    for (final command in _commands) {
      if (command is VDCExtent) {
        return command.extent;
      }
    }

    return null;
  }

  ScalingMode? getScalingMode() {
    for (final command in _commands) {
      if (command is ScalingMode) return command;
    }

    return null;
  }

  Size? getSize([double dpi = 96]) {
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

    return Size(width.toDouble(), height.toDouble());
  }

  PolyBezier mergePB(List<PolyBezier> tomerge) {
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
