enum ControlElement {
  unused0(0),
  vdcIntegerPrecision(1),
  vdcRealPrecision(2),
  auxiliaryColour(3),
  transparency(4),
  clipRectangle(5),
  clipIndicator(6),
  lineClippingMode(7),
  markerClippingMode(8),
  edgeClippingMode(9),
  newRegion(10),
  savePrimitiveContext(11),
  restorePrimitiveContext(12),
  unused13(13),
  unused14(14),
  unused15(15),
  unused16(16),
  protectionRegionIndicator(17),
  generalizedTextPathMode(18),
  mitreLimit(19),
  transparentCellColour(20);

  final int elementCode;

  const ControlElement(this.elementCode);

  static ControlElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
