/// Represents the class of a CGM command
enum ElementClass {
  delimiterElements(0),
  metafileDescriptorElements(1),
  pictureDescriptorElements(2),
  controlElements(3),
  graphicalPrimitiveElements(4),
  attributeElements(5),
  escapeElements(6),
  externalElements(7),
  segmentElements(8),
  applicationStructureElements(9);

  final int elementClass;

  const ElementClass(this.elementClass);

  /// Returns the [ElementClass] for the given [ec]
  static ElementClass getElementClass(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw ArgumentError("Invalid element class number: $ec");
    }

    return values[ec];
  }
}
