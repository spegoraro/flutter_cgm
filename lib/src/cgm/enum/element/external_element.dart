enum ExternalElements {
  unused0(0),
  message(1),
  applicationData(1);

  final int elementCode;

  const ExternalElements(this.elementCode);

  static ExternalElements getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
