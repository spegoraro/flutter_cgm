import 'package:flutter_cgm/src/cgm/cgm.dart';

enum RestrictedTextTypeType { basic, boxedCap, boxedAll, isotropicCap, isotropicAll, justified }

class RestrictedTextType extends Command {
  RestrictedTextType(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeIndex();

    cgm.restrictedTextType = switch (index) {
      1 => RestrictedTextTypeType.basic,
      2 => RestrictedTextTypeType.boxedCap,
      3 => RestrictedTextTypeType.boxedAll,
      4 => RestrictedTextTypeType.isotropicCap,
      5 => RestrictedTextTypeType.isotropicAll,
      6 => RestrictedTextTypeType.justified,
      _ => RestrictedTextTypeType.basic,
    };
  }

  @override
  String toString() => 'RestrictedTextType -> ${cgm.restrictedTextType}';
}
