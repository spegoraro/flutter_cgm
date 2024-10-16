import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';

class CapCommand extends Command {
  @protected
  late final LineCapIndicator lineCapIndicator;

  @protected
  late final DashCapIndicator dashCapIndicator;

  CapCommand(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final lineIndicator = makeIndex();
    lineCapIndicator = switch (lineIndicator) {
      1 => LineCapIndicator.unspecified,
      2 => LineCapIndicator.butt,
      3 => LineCapIndicator.round,
      4 => LineCapIndicator.projectedSquare,
      5 => LineCapIndicator.triangle,
      _ => LineCapIndicator.unspecified,
    };

    final dashIndicator = makeIndex();
    dashCapIndicator = switch (dashIndicator) {
      1 => DashCapIndicator.unspecified,
      2 => DashCapIndicator.butt,
      3 => DashCapIndicator.match,
      _ => DashCapIndicator.unspecified,
    };
  }

  @override
  String toString() {
    return ' { lineCap: ${lineCapIndicator.name}, dashCap: ${dashCapIndicator.name} } ';
  }
}
