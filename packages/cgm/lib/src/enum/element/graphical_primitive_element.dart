enum GraphicalPrimitiveElement {
  unused0(0),
  polyline(1),
  disjointPolyline(2),
  polymarker(3),
  text(4),
  restrictedText(5),
  appendText(6),
  polygon(7),
  polygonSet(8),
  cellArray(9),
  generalizedDrawingPrimitive(10),
  rectangle(11),
  circle(12),
  circularArc3Point(13),
  circularArc3PointClose(14),
  circularArcCentre(15),
  circularArcCentreClose(16),
  ellipse(17),
  ellipticalArc(18),
  ellipticalArcClose(19),
  circularArcCentreReversed(20),
  connectingEdge(21),
  hyperbolicArc(22),
  parabolicArc(23),
  nonUniformBSpline(24),
  nonUniformRationalBSpline(25),
  polybezier(26),
  polysymbol(27),
  bitonalTile(28),
  tile(29);

  final int elementCode;

  const GraphicalPrimitiveElement(this.elementCode);

  static GraphicalPrimitiveElement getElement(int ec) {
    if (ec < 0 || ec >= values.length) {
      throw IndexError.withLength(ec, values.length);
    }

    return values[ec];
  }
}
