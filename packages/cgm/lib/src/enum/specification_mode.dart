enum SpecificationMode {
  scaled,
  absolute,
  fractional,
  mm;

  static SpecificationMode getMode(int mode) {
    return switch (mode) {
      0 => SpecificationMode.absolute,
      1 => SpecificationMode.scaled,
      2 => SpecificationMode.fractional,
      3 => SpecificationMode.mm,
      _ => SpecificationMode.scaled,
    };
  }
}
