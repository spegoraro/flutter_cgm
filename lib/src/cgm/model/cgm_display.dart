// ignore_for_file: unused_field, prefer_final_fields

import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/model/paint_holder.dart';
import 'package:meta/meta.dart';

class CGMDisplay {
  late Canvas _canvas;
  Canvas get canvas => _canvas;

  late CGM _cgm;
  CGM get cgm => _cgm;

  late int _canvasWidth, _canvasHeight;

  Color? _fillColor, _edgeColor, _lineColor, _textColor, _markerColor;
  int _fillColorIndex = 1, _edgeColorIndex = 1, _lineColorIndex = 1, _textColorIndex = 1, _markerColorIndex = 1;

  double _lineWidth = 1;
  double _edgeWidth = 1;

  bool _isFilled = false;
  bool _drawEdge = false;

  double characterHeight = 32;

  late List<Point<double>> _extent;

  List<FontWrapper> _fonts = [];
  HorizontalAlignment _horizontalTextAlignment = HorizontalAlignment.normalHorizontal;
  VerticalAlignment _verticalTextAlignment = VerticalAlignment.normalVertical;
  @protected
  late final HashMap<int, List<double>> lineDashes;

  List<Color> _colorTable = [];

  InteriorStyleStyle _interiorStyle = InteriorStyleStyle.hollow;

  bool _beforeBeginPicture = true;

  double additionalCharacterSpace = 0;
  bool _isScaled = false;

  Point<double> _upVector = const Point(0, 0), _baseVector = const Point(0, 0);

  bool _useSymbolEncoding = false;

  StrokeCap _lineStroke = StrokeCap.butt;
  StrokeJoin _edgeStroke = StrokeJoin.miter;

  MarkerTypeType _markerType = MarkerTypeType.asterisk;

  double _markerSize = 32;

  double _continuousHorizontalAlignment = 0, _continuousVerticalAlignment = 0;

  TextPathType _textPath = TextPathType.right;

  HatchType _hatchType = HatchType.horizontalLines;

  bool _clipFlag = true;

  Float64List _transformMatrix = Float64List(16);

  late TileArrayInfo _tileArrayInfo;

  bool _isTransparent = false;
  bool _isViewCleared = false;

  Text? _textCommand;

  // TODO: TESTING TESTING 123
  BeginApplicationStructure? currentApplicationStructure;
  HashMap<BeginApplicationStructure, PaintHolder> _applicationStructurePaintHolders = HashMap();
  PaintHolder? get currentPaintHolder => _applicationStructurePaintHolders[currentApplicationStructure];

  Paint? linePaint, fillPaint, edgePaint;

  // TODO: get rid
  bool isWithinApplicationStructureBody = false;

  //-< Constructor >-//
  CGMDisplay(CGM cgm) {
    reset(true);

    lineDashes = HashMap<int, List<double>>();
    lineDashes.putIfAbsent(DashType.solid.value, () => [100, 0]);
    lineDashes.putIfAbsent(DashType.dash.value, () => [55, 20]);
    lineDashes.putIfAbsent(DashType.dot.value, () => [13, 13]);
    lineDashes.putIfAbsent(DashType.dashDot.value, () => [55, 20, 13, 20]);
    lineDashes.putIfAbsent(DashType.dashDotDot.value, () => [55, 20, 13, 20, 13, 20]);

    final vdcType = cgm.vdcType;
    _extent = switch (vdcType) {
      VDCTypeType.integer => const [Point(0, 0), Point(32767, 32767)],
      VDCTypeType.real => const [Point(0, 0), Point(1, 1)],
    };

    final extent = cgm.getExtent();
    if (extent != null) {
      _extent = extent;
    }

    _cgm = cgm;
  }

  //-< Paint >-//
  void paint(Canvas canvas) {
    _canvas = canvas;

    final size = _cgm.getSize() ?? const Size(1, 1);
    if (!_isTransparent) {
      _canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          _isScaled ? _canvasWidth.toDouble() : size.width,
          _isScaled ? _canvasHeight.toDouble() : size.height,
        ),
        Paint()..color = const Color.fromARGB(255, 255, 255, 255),
      );
    }

    var minX = _extent[0].x, maxX = _extent[1].x;
    var minY = _extent[0].y, maxY = _extent[1].y;

    final sX = _canvasWidth / (maxX - minX).abs();
    final sY = _canvasHeight / (maxY - minY).abs();
    final s = min(sX, sY);

    double m00, m11, m02, m12;
    if (minX < maxX) {
      m00 = s;
      m02 = -minX * s;
    } else {
      m00 = -s;
      m02 = _canvasWidth + maxX * s;
    }

    if (minY < maxY) {
      m11 = -s;
      m12 = _canvasHeight + minY * s;
    } else {
      m11 = s;
      m12 = -minY * s;
    }

    _transformMatrix[0] = m00;
    _transformMatrix[5] = m11;
    _transformMatrix[10] = 1;
    _transformMatrix[15] = 1;
    _transformMatrix[12] = m02;
    _transformMatrix[13] = m12;

    _canvas.transform(Float64List.fromList(_transformMatrix));

    _cgm.paint(this);
  }

  void newApplicationStructure(BeginApplicationStructure applicationStructure) {
    currentApplicationStructure = applicationStructure;
    _applicationStructurePaintHolders[applicationStructure] = PaintHolder()
      ..setApsId(applicationStructure.applicationStructureIdentifier);
  }

  void endApplicationStructure() {
    currentApplicationStructure = null;
  }

  void reachedPictureBody() {
    _beforeBeginPicture = false;
  }

  void scale(double width, double height) {
    if (_extent.isEmpty) return;

    final extentWidth = (_extent[1].x - _extent[0].x).abs();
    final extentHeight = (_extent[1].y - _extent[0].y).abs();

    var fX = width / extentWidth;
    if (fX * extentHeight > height) {
      fX = height / extentHeight;
    }

    _canvasWidth = (extentWidth * fX).ceil();
    _canvasHeight = (extentHeight * fX).ceil();

    _isScaled = true;
  }

  //-< Reset >-//
  void reset([bool initial = false]) {
    _beforeBeginPicture = true;

    _clipFlag = true;

    characterHeight = 32;
    additionalCharacterSpace = 0;

    _lineWidth = 1;
    _edgeWidth = 1;

    _lineStroke = StrokeCap.butt;
    _edgeStroke = StrokeJoin.miter;

    linePaint = Paint()
      ..strokeCap = _lineStroke
      ..strokeJoin = _edgeStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = _lineWidth;

    fillPaint = Paint();

    edgePaint = Paint()
      ..strokeCap = _lineStroke
      ..strokeJoin = _edgeStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = _edgeWidth;

    _drawEdge = false;
    _hatchType = HatchType.horizontalLines;
    setInteriorStyle(InteriorStyleStyle.hollow);

    _initializeColorTable();
    _fillColor = null;
    _fillColorIndex = 1;
    _edgeColor = null;
    _edgeColorIndex = 1;
    _lineColor = null;
    _lineColorIndex = 1;
    _textColor = null;
    _textColorIndex = 1;

    _markerType = MarkerTypeType.asterisk;

    final markerSizeSpecificationMode = initial ? SpecificationMode.absolute : _cgm.markerSizeSpecificationMode;
    _markerSize = switch (markerSizeSpecificationMode) {
      SpecificationMode.absolute => 32767.0 / 100.0,
      SpecificationMode.scaled => 1.0,
      SpecificationMode.fractional => 0.01,
      SpecificationMode.mm => 2.50,
    };

    _fonts = [];
    _useSymbolEncoding = false;
    _horizontalTextAlignment = HorizontalAlignment.normalHorizontal;
    _verticalTextAlignment = VerticalAlignment.normalVertical;
    _textPath = TextPathType.right;

    _upVector = const Point(0, 32767);
    _baseVector = const Point(32767, 0);

    _isTransparent = false;
    _isViewCleared = false;
    _beforeBeginPicture = true;

    _canvasWidth = 1;
    _canvasHeight = 1;
  }

  //-< Getters >-//
  Color get fillColor => _fillColor ?? _colorTable[_fillColorIndex];
  Color get edgeColor => _edgeColor ?? _colorTable[_edgeColorIndex];
  Color get lineColor => _lineColor ?? _colorTable[_lineColorIndex];

  double get lineWidth => _lineWidth;
  double get edgeWidth => _edgeWidth;

  bool get isFilled => _isFilled;
  bool get drawEdge => _drawEdge;
  bool get isTransparent => _isTransparent;
  bool get isBeforeBeginPicture => _beforeBeginPicture;
  bool get isViewCleared => _isViewCleared;
  bool get clipFlag => _clipFlag;
  bool get isScaled => _isScaled;

  HorizontalAlignment get horizontalTextAlignment => _horizontalTextAlignment;
  VerticalAlignment get verticalTextAlignment => _verticalTextAlignment;
  double get continuousHorizontalAlignment => _continuousHorizontalAlignment;
  double get continuousVerticalAlignment => _continuousVerticalAlignment;

  BeginFigure? currentFigure;
  List<PolyBezier> currentPolyBezier = [];

  InteriorStyleStyle get interiorStyle => _interiorStyle;

  List<Point<double>> get extent => _extent;

  //-< Setters >-//
  void setInteriorStyle(InteriorStyleStyle style) {
    _interiorStyle = style;
    _isFilled = style == InteriorStyleStyle.solid || style == InteriorStyleStyle.interpolated;
  }

  void setTextAlignment(
      {required HorizontalAlignment horizontal,
      required VerticalAlignment vertical,
      required double continuousHorizontal,
      required double continuousVertical}) {
    _horizontalTextAlignment = horizontal;
    _verticalTextAlignment = vertical;
    _continuousHorizontalAlignment = continuousHorizontal;
    _continuousVerticalAlignment = continuousVertical;
  }

  void setFlag({bool? filled, bool? drawEdge, bool? transparent, bool? clip}) {
    if (filled != null) {
      _isFilled = filled;
    } else if (drawEdge != null) {
      _drawEdge = drawEdge;
    } else if (transparent != null) {
      _isTransparent = transparent;
    } else if (clip != null) {
      _clipFlag = clip;
    }
  }

  void setFillColor({Color? color, int? index}) {
    if (color != null) {
      _fillColor = color;
    } else if (index != null) {
      assert(index >= 0 && index < _colorTable.length, 'Index out of bounds');
      _fillColor = _colorTable[index];
    }

    fillPaint?.color = fillColor;
    fillPaint?.style = PaintingStyle.fill;
    fillPaint?.strokeWidth = 0;
  }

  void fill(Path path) {
    if (_interiorStyle == InteriorStyleStyle.hatch) {
      _drawHatch(path);
    } else {
      final paint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;

      _canvas.drawPath(path, paint);
    }
  }

  void _drawHatch(Path path) {
    _canvas.save();
    _canvas.clipPath(path);
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final rect = path.getBounds();

    final hatchPaint = Paint()
      ..color = edgeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = edgeWidth;

    final hatchPath = Path();

    const hatchSpacing = 10.0;

    final hatchWidth = rect.width;
    final hatchHeight = rect.height;

    final hatchCountX = (hatchWidth / hatchSpacing).ceil();
    final hatchCountY = (hatchHeight / hatchSpacing).ceil();

    for (int i = 0; i < hatchCountX; i++) {
      hatchPath.moveTo(rect.left + i * hatchSpacing, rect.top);
      hatchPath.lineTo(rect.left + i * hatchSpacing, rect.bottom);
    }

    for (int i = 0; i < hatchCountY; i++) {
      hatchPath.moveTo(rect.left, rect.top + i * hatchSpacing);
      hatchPath.lineTo(rect.right, rect.top + i * hatchSpacing);
    }

    _canvas.drawPath(hatchPath, hatchPaint);

    _canvas.drawPath(path, paint);

    _canvas.restore();
  }

  void setCurrentFillColor(FillColor fillColor) => currentPaintHolder?.setFillColor(fillColor);
  void setCurrentEdgeColor(EdgeColor edgeColor) => currentPaintHolder?.setEdgeColor(edgeColor);
  void setCurrentEdgeWidth(EdgeWidth edgeWidth) => currentPaintHolder?.setEdgeWidth(edgeWidth);
  void setCurrentLineColor(LineColor lineColor) => currentPaintHolder?.setLineColor(lineColor);
  void setCurrentLineWidth(LineWidth lineWidth) => currentPaintHolder?.setLineWidth(lineWidth);

  Color getIndexedColor(int index) {
    assert(index >= 0 && index < _colorTable.length, 'getIndexedColor: Index out of bounds ($index)');
    return _colorTable[index];
  }

  Color fillColorOf(FillColor fillColor) {
    if (fillColor.getColor() != null) {
      return fillColor.getColor()!;
    } else {
      return _colorTable[fillColor.getColorIndex()];
    }
  }

  Color lineColorOf(LineColor lineColor) {
    if (lineColor.getColor() != null) {
      return lineColor.getColor()!;
    } else {
      return _colorTable[lineColor.getColorIndex()];
    }
  }

  void setIndexedColor(int index, Color color) {
    _colorTable[index] = color;
  }

  void setHatchStyle(HatchType type) {
    _hatchType = type;
  }

  void setEdge({Color? color, int? index, double? width, StrokeJoin? strokeJoin}) {
    if (color != null) {
      _edgeColor = color;
    } else if (index != null) {
      assert(index >= 0 && index < _colorTable.length, 'Index out of bounds');
      _edgeColor = _colorTable[index];
    }

    if (width != null) {
      _edgeWidth = width;
    }

    if (strokeJoin != null) {
      _edgeStroke = strokeJoin;
    }

    edgePaint?.color = edgeColor;
    edgePaint?.strokeWidth = _edgeWidth;
  }

  void setLine({Color? color, int? index, double? width, StrokeCap? strokeCap, StrokeJoin? strokeJoin}) {
    if (color != null) {
      _lineColor = color;
    } else if (index != null) {
      assert(index >= 0 && index < _colorTable.length, 'Index out of bounds');
      _lineColor = _colorTable[index];
    }

    if (width != null) {
      _lineWidth = width;
    }

    if (strokeCap != null) {
      _lineStroke = strokeCap;
    }

    if (strokeJoin != null) {
      _edgeStroke = strokeJoin;
    }

    linePaint?.color = lineColor;
    linePaint?.strokeWidth = _lineWidth;
  }

  void addLineType(int lineType, List<int> dashElements, double dashCycleRepeatLength) {
    lineDashes[lineType] = dashElements.map((e) => e.toDouble()).toList();
  }

  void _initializeColorTable([int size = 63]) {
    _colorTable = List.generate(
      size,
      (index) => index == 0 ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
