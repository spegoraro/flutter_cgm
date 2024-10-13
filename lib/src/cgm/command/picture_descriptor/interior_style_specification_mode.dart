import 'package:flutter_cgm/src/cgm/cgm.dart';

class InteriorStyleSpecificationMode extends Command {
  late final SpecificationMode mode;

  InteriorStyleSpecificationMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    mode = switch (index) {
      0 => SpecificationMode.absolute,
      1 => SpecificationMode.scaled,
      2 => SpecificationMode.fractional,
      3 => SpecificationMode.mm,
      _ => SpecificationMode.absolute,
    };
  }

  @override
  String toString() => 'InteriorStyleSpecificationMode -> $mode';
}
