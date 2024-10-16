enum AttributeElement {
  unused0(0),
  lineBundleIndex(1),
  lineType(2),
  lineWidth(3),
  lineColor(4),
  markerBundleIndex(5),
  markerType(6),
  markerSize(7),
  markerColor(8),
  textBundleIndex(9),
  textFontIndex(10),
  textPrecision(11),
  characterExpansionFactor(12),
  characterSpacing(13),
  textColor(14),
  characterHeight(15),
  characterOrientation(16),
  textPath(17),
  textAlignment(18),
  characterSetIndex(19),
  alternateCharacterSetIndex(20),
  fillBundleIndex(21),
  interiorStyle(22),
  fillColor(23),
  hatchIndex(24),
  patternIndex(25),
  edgeBundleIndex(26),
  edgeType(27),
  edgeWidth(28),
  edgeColor(29),
  edgeVisibility(30),
  fillReferencePoint(31),
  patternTable(32),
  patternSize(33),
  colorTable(34),
  aspectSourceFlags(35),
  pickIdentifier(36),
  lineCap(37),
  lineJoin(38),
  lineTypeContinuation(39),
  lineTypeInitialOffset(40),
  textScoreType(41),
  restrictedTextType(42),
  interpolatedInterior(43),
  edgeCap(44),
  edgeJoin(45),
  edgeTypeContinuation(46),
  edgeTypeInitialOffset(47),
  symbolLibraryIndex(48),
  symbolColor(49),
  symbolSize(50),
  symbolOrientation(51);

  final int elementCode;

  const AttributeElement(this.elementCode);

  static AttributeElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
