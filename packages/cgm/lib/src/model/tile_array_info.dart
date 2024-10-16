import 'package:vector_math/vector_math.dart';

class TileArrayInfo {
  late final Vector2 _startPosition;
  late final int _nTilesInPathDirection;
  late final double _tileSizeInPathDirection;
  late final double _tileSizeInLineDirection;
  late final int _nTilesInLineDirection;
  late final int _amountOfLastLineCellsInLineDirection;

  int _pathIndex = 0;
  int _lineIndex = 0;
  Vector2 _currentPosition = Vector2(0, 0);

  late final int _nCellsPerTileInPathDirection;
  late final int _nCellsPerTileInLineDirection;

  int get pathIndex => _pathIndex;
  int get lineIndex => _lineIndex;

  Vector2 get currentPosition => _currentPosition;

  int get nCellsPerTileInLineDirection => _nCellsPerTileInLineDirection;
  double get tileSizeInLineDirection => _tileSizeInLineDirection;

  int get nCellsPerTileInPathDirection => _nCellsPerTileInPathDirection;
  double get tileSizeInPathDirection => _tileSizeInPathDirection;

  int get amountOfLastLineCellsInLineDirection => _amountOfLastLineCellsInLineDirection;

  bool get isLastLine => _lineIndex == _nTilesInLineDirection - 1;

  TileArrayInfo(
    this._startPosition,
    this._nTilesInPathDirection,
    this._tileSizeInPathDirection,
    this._tileSizeInLineDirection,
    this._nTilesInLineDirection,
    this._amountOfLastLineCellsInLineDirection,
    this._nCellsPerTileInPathDirection,
    this._nCellsPerTileInLineDirection,
  );

  void next() {
    _pathIndex++;

    if (_pathIndex == _nTilesInPathDirection) {
      _pathIndex = 0;
      _lineIndex++;
    }

    _currentPosition = Vector2(
      _startPosition.x + _pathIndex * _tileSizeInPathDirection,
      _startPosition.y + _lineIndex * _tileSizeInLineDirection,
    );
  }
}
