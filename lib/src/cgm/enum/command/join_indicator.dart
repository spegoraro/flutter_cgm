import 'dart:ui';

enum JoinIndicator {
  unspecified(StrokeJoin.bevel),
  mitre(StrokeJoin.miter),
  round(StrokeJoin.round),
  bevel(StrokeJoin.bevel);

  final StrokeJoin strokeJoin;

  const JoinIndicator(this.strokeJoin);
}
