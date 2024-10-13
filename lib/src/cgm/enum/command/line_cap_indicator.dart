import 'dart:ui';

enum LineCapIndicator {
  unspecified(StrokeCap.butt),
  butt(StrokeCap.butt),
  round(StrokeCap.round),
  projectedSquare(StrokeCap.square),
  triangle(StrokeCap.butt); // TODO: not supported yet

  final StrokeCap strokeCap;

  const LineCapIndicator(this.strokeCap);
}
