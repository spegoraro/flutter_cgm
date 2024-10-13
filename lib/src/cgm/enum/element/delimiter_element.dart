enum DelimiterElement {
  noOp(0),
  beginMetafile(1),
  endMetafile(2),
  beginPicture(3),
  beginPictureBody(4),
  endPicture(5),
  beginSegment(6),
  endSegment(7),
  beginFigure(8),
  endFigure(9),
  unused10(10),
  unused11(11),
  unused12(12),
  beginProtectionRegion(13),
  endProtectionRegion(14),
  beginCompoundLine(15),
  endCompoundLine(16),
  beginCompoundTextPath(17),
  endCompoundTextPath(18),
  beginTileArray(19),
  endTileArray(20),
  beginApplicationStructure(21),
  beginApplicationStructureBody(22),
  endApplicationStructure(23);

  final int elementCode;

  const DelimiterElement(this.elementCode);

  static DelimiterElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(
        ec,
        values.length,
        message: 'Invalid delimiter element number: $ec',
      );
    }

    return values[ec];
  }
}
