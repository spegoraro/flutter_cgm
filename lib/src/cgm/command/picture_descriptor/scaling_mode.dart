import 'package:buffer/buffer.dart';
import 'package:flutter_cgm/src/cgm/cgm.dart';

enum ScalingType { abstract, metric }

class ScalingMode extends Command {
  late final ScalingType _mode;
  ScalingType get mode => _mode;
  late final double metricScalingFactor;

  ScalingMode(int ec, int eid, int l, ByteDataReader buffer, CGM cgm) : super(ec, eid, l, buffer, cgm) {
    final index = l > 0 ? makeEnum() : 0;
    if (index == 0) {
      _mode = ScalingType.abstract;
    } else if (index == 1) {
      _mode = ScalingType.metric;
      metricScalingFactor = makeFloatingPoint();
    }
  }

  @override
  String toString() {
    if (mode == ScalingType.abstract) {
      return 'Scaling Mode -> $mode';
    } else {
      return 'Scaling Mode -> { mode: $mode, metricScaleFactor: -> $metricScalingFactor } ';
    }
  }
}
