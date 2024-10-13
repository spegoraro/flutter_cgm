enum PictureDescriptorElement {
  unused0(0),
  scalingMode(1),
  colourSelectionMode(2),
  lineWidthSpecificationMode(3),
  markerSizeSpecificationMode(4),
  edgeWidthSpecificationMode(5),
  vdcExtent(6),
  backgroundColour(7),
  deviceViewport(8),
  deviceViewportSpecificationMode(9),
  deviceViewportMapping(10),
  lineRepresentation(11),
  markerRepresentation(12),
  textRepresentation(13),
  fillRepresentation(14),
  edgeRepresentation(15),
  interiorStyleSpecificationMode(16),
  lineAndEdgeTypeDefinition(17),
  hatchStyleDefinition(18),
  geometricPatternDefinition(19),
  applicationStructureDirectory(20);

  final int elementCode;

  const PictureDescriptorElement(this.elementCode);

  static PictureDescriptorElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
