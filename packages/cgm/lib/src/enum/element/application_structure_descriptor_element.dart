enum ApplicationStructureDescriptorElement {
  unused0(0),
  applicationStructureAttribute(1);

  final int elementCode;

  const ApplicationStructureDescriptorElement(this.elementCode);

  static ApplicationStructureDescriptorElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
