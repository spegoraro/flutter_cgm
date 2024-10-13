enum MetafileDescriptorElement {
  unused0(0),
  metafileVersion(1),
  metafileDescription(2),
  vdcType(3),
  integerPrecision(4),
  realPrecision(5),
  indexPrecision(6),
  colorPrecision(7),
  colorIndexPrecision(8),
  maximumColorIndex(9),
  colorValueExtent(10),
  metafileElementList(11),
  metafileDefaultsReplacement(12),
  fontList(13),
  characterSetList(14),
  characterCodingAnnouncer(15),
  namePrecision(16),
  maximumVdcExtent(17),
  segmentPriorityExtent(18),
  colorModel(19),
  colourCalibration(20),
  fontProperties(21),
  glyphMapping(22),
  symbolLibraryList(23),
  pictureDirectory(24);

  final int elementCode;

  const MetafileDescriptorElement(this.elementCode);

  static MetafileDescriptorElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(
        ec,
        values.length,
        message: 'Invalid metafile descriptor element number: $ec',
      );
    }

    return values[ec];
  }
}
