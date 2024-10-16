import 'package:cgm/cgm.dart';

class DeviceViewportSpecificationMode extends Command {
  late final double metricScaleFactor;

  DeviceViewportSpecificationMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    final specifier = switch (index) {
      0 => DeviceViewportSpecificationType.fractionOfDrawingSurface,
      1 => DeviceViewportSpecificationType.millimetersWithScaleFactor,
      2 => DeviceViewportSpecificationType.physicalDeviceCoordinates,
      _ => DeviceViewportSpecificationType.fractionOfDrawingSurface,
    };

    cgm.deviceViewportSpecificationMode = specifier;

    if (cgm.realPrecisionProcessed) {
      metricScaleFactor = makeReal();
    } else {
      metricScaleFactor = makeFloatingPoint32();
    }
  }

  @override
  String toString() => 'Device Viewport Specification Mode -> '
      '{ mode: ${cgm.deviceViewportSpecificationMode},'
      'metricScaleFactor: $metricScaleFactor }';
}
