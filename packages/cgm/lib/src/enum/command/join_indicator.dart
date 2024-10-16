import 'package:cgm/cgm.dart';

enum JoinIndicator {
  unspecified(StrokeJoin.bevel),
  mitre(StrokeJoin.miter),
  round(StrokeJoin.round),
  bevel(StrokeJoin.bevel);

  final StrokeJoin strokeJoin;

  const JoinIndicator(this.strokeJoin);
}
