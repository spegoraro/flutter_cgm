import 'package:flutter_cgm/src/cgm/cgm.dart';

class LineAndEdgeTypeDefinition extends Command {
  late final int lineType;
  late final double dashCycleRepeatLength;
  late final List<int> dashElements;

  LineAndEdgeTypeDefinition(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    lineType = makeIndex();

    dashCycleRepeatLength = makeSizeSpecification(cgm.lineWidthSpecificationMode).abs();

    final length = (arguments.length - currentArgument) ~/ sizeOfInt();
    dashElements = List.generate(length, (index) => makeInt());
  }

  @override
  void paint(CGMDisplay display) {
    display.addLineType(
      lineType,
      dashElements,
      dashCycleRepeatLength,
    );
  }

  @override
  String toString() => 'LineAndEdgeTypeDefinition -> { '
      'lineType: $lineType, '
      'dashCycleRepeatLength: $dashCycleRepeatLength, '
      'dashElements: [${dashElements.join(', ')}] '
      ' } ';
}
