import 'package:flutter_cgm/src/cgm/cgm.dart';

//-- Font List --//
const _fontMapping = {
  //-- Serif --//
  'times-roman': FontWrapper('Times New Roman', 'Regular'),
  'times-bold': FontWrapper('Times New Roman', 'Bold'),
  'times-italic': FontWrapper('Times New Roman', 'Italic'),
  'times-bolditalic': FontWrapper('Times New Roman', 'Bold Italic'),
  'times-bold-italic': FontWrapper('Times New Roman', 'Bold Italic'),

  //-- Sans Serif --//
  'helvetica': FontWrapper('Helvetica Neue', 'Regular'),
  'helvetica-bold': FontWrapper('Helvetica Neue', 'Bold'),
  'helvetica-oblique': FontWrapper('Helvetica Neue', 'Italic'),
  'helvetica-boldoblique': FontWrapper('Helvetica Neue', 'Bold Italic'),
  'helvetica-bold-oblique': FontWrapper('Helvetica Neue', 'Bold Italic'),

  //-- Monospace --//
  'courier': FontWrapper('Courier New', 'Regular'),
  'courier-bold': FontWrapper('Courier New', 'Bold'),
  'courier-oblique': FontWrapper('Courier New', 'Italic'),
  'courier-italic': FontWrapper('Courier New', 'Italic'),
  'courier-boldoblique': FontWrapper('Courier New', 'Bold Italic'),
  'courier-bold-oblique': FontWrapper('Courier New', 'Bold Italic'),
  'courier-bold-italic': FontWrapper('Courier New', 'Bold Italic'),
  'courier-bolditalic': FontWrapper('Courier New', 'Bold Italic'),

  //-- Symbol --//
  'symbol': FontWrapper('Symbol', 'Regular', useSymbolEncoding: true),
};

class FontList extends Command {
  late final List<String> fontNames;
  late final List<FontWrapper> fonts;

  FontList(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    int count = 0, i = 0;
    while (i < arguments.length) {
      count++;
      i += arguments[i] + 1;
    }

    fontNames = List.filled(count, '');
    count = 0;
    i = 0;

    while (i < arguments.length) {
      final a = List<int>.filled(arguments[i], 0);
      for (int j = 0; j < arguments[i]; j++) {
        a[j] = arguments[i + j + 1];
      }
      fontNames[count] = String.fromCharCodes(a);
      count++;
      i += arguments[i] + 1;
    }

    fonts = List.filled(fontNames.length, const FontWrapper('', ''));
    i = 0;
    for (final fontName in fontNames) {
      final mappedFont = _fontMapping[fontName.toLowerCase().replaceAll('_', '-')];
      if (mappedFont != null) {
        fonts[i++] = mappedFont;
      } else {
        fonts[i++] = const FontWrapper('Times New Roman', 'Regular');
        cgm.logger.warning('Font not found: $fontName');
      }
    }
  }

  @override
  String toString() => 'Font List -> { list: $fontNames } ';
}

class FontWrapper {
  final String family;
  final String style;
  final bool useSymbolEncoding;

  const FontWrapper(this.family, this.style, {this.useSymbolEncoding = false});
}
