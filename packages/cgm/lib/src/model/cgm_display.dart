// ignore_for_file: unused_field, prefer_final_fields

import 'dart:collection';
import 'dart:math';
import 'package:cgm/src/render/color.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:typed_data';

import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';

/// The [CGMDisplay] class is used to store the current state of the painting process.
class CGMDisplay {
  /// The [CGMCanvas] object to paint the [CGM] class' commands.
  CGMCanvas get canvas => _canvas;
  late CGMCanvas _canvas;

  late CGM _cgm;
  CGM get cgm => _cgm;

  late int _canvasWidth, _canvasHeight;

  Color? _fillColor, _edgeColor, _lineColor, textColor, _markerColor;
  int _fillColorIndex = 1, _edgeColorIndex = 1, _lineColorIndex = 1, _textColorIndex = 1, _markerColorIndex = 1;

  double _lineWidth = 1;
  double _edgeWidth = 1;

  bool _isFilled = false;
  bool _drawEdge = false;

  double characterHeight = 32;

  late List<Vector2> _extent;

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

  Vector2 _upVector = Vector2.zero(), _baseVector = Vector2.zero();

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
  HashMap<BeginApplicationStructure, CGMPaintHolder> _applicationStructureCGMPaintHolders = HashMap();
  CGMPaintHolder? get currentCGMPaintHolder => _applicationStructureCGMPaintHolders[currentApplicationStructure];

  CGMPaint? linePaint, fillPaint, edgePaint;

  // TODO: get rid
  bool isWithinApplicationStructureBody = false;

  /// Creates a new instance of the [CGMDisplay] class.
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
      VDCTypeType.integer => [Vector2(0, 0), Vector2(32767, 32767)],
      VDCTypeType.real => [Vector2(0, 0), Vector2(1, 1)],
    };

    final extent = cgm.getExtent();
    if (extent != null) {
      _extent = extent;
    }

    _cgm = cgm;
  }

  /// Paints the [CGM] class' commands to the given [canvas].
  ///
  /// The [canvas] parameter is the [CGMCanvas] object to paint the [CGM] class' commands.
  void paint(CGMCanvas canvas) {
    _canvas = canvas;

    final size = _cgm.getSize() ?? Vector2(1, 1);
    if (!_isTransparent) {
      _canvas.drawRect(
        Vector2(0, 0),
        Vector2(
          _isScaled ? _canvasWidth.toDouble() : size.x,
          _isScaled ? _canvasHeight.toDouble() : size.y,
        ),
        CGMPaint()..color = const Color.fromARGB(255, 255, 255, 255),
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
    _applicationStructureCGMPaintHolders[applicationStructure] = CGMPaintHolder()
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

    _lineStroke = StrokeCap.round;
    _edgeStroke = StrokeJoin.round;

    linePaint = CGMPaint()
      ..strokeCap = _lineStroke
      ..strokeJoin = _edgeStroke
      ..filled = false
      ..strokeWidth = _lineWidth;

    fillPaint = CGMPaint();

    edgePaint = CGMPaint()
      ..strokeCap = _lineStroke
      ..strokeJoin = _edgeStroke
      ..filled = false
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
    textColor = null;
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

    _upVector = Vector2(0, 32767);
    _baseVector = Vector2(32767, 0);

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

  List<Vector2> get extent => _extent;

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
    fillPaint?.filled = true;
    fillPaint?.strokeWidth = 0;
  }

  void setCurrentFillColor(FillColor fillColor) => currentCGMPaintHolder?.setFillColor(fillColor);
  void setCurrentEdgeColor(EdgeColor edgeColor) => currentCGMPaintHolder?.setEdgeColor(edgeColor);
  void setCurrentEdgeWidth(EdgeWidth edgeWidth) => currentCGMPaintHolder?.setEdgeWidth(edgeWidth);
  void setCurrentLineColor(LineColor lineColor) => currentCGMPaintHolder?.setLineColor(lineColor);
  void setCurrentLineWidth(LineWidth lineWidth) => currentCGMPaintHolder?.setLineWidth(lineWidth);

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
