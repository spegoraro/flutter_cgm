import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class BeginTileArray extends Command {
  late final Vector2 position;
  late final int cellPathDirection;
  late final int lineProgressionDirection;
  late final int nTilesInPathDirection;
  late final int nTilesInLineDirection;
  late final int nCellsPerTileInPathDirection;
  late final int nCellsPerTileInLineDirection;
  late final double cellSizeInPathDirection;
  late final double cellSizeInLineDirection;
  late final int imageOffsetInPathDirection;
  late final int imageOffsetInLineDirection;
  late final int nCellsInPathDirection;
  late final int nCellsInLineDirection;

  BeginTileArray(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    position = makePoint();
    cellPathDirection = makeEnum();
    lineProgressionDirection = makeEnum();
    nTilesInPathDirection = makeInt();
    nTilesInLineDirection = makeInt();
    nCellsPerTileInPathDirection = makeInt();
    nCellsPerTileInLineDirection = makeInt();
    cellSizeInPathDirection = makeReal();
    cellSizeInLineDirection = makeReal();
    imageOffsetInPathDirection = makeInt();
    imageOffsetInLineDirection = makeInt();
    nCellsInPathDirection = makeInt();
    nCellsInLineDirection = makeInt();
  }

  @override
  void paint(CGMDisplay display) {} // TODO: Implement paint
}
