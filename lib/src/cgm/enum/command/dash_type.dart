enum DashType {
  solid(1),
  dash(2),
  dot(3),
  dashDot(4),
  dashDotDot(5),
// Registered at later date:
  singleArrow(6),
  singleDot(7),
  doubleArrow(8),
  stitchLine(9),
  chainLine(10),
  centerLine(11),
  hiddenLine(12),
  phantomLine(13),
  breakLine1Freehand(14),
  breakLine2Freehand(15);

  final int value;
  const DashType(this.value);

  static DashType from(int index) => DashType.values.firstWhere((e) => e.value == index);
}
