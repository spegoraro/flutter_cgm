import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:cgm/cgm.dart';
import 'package:cgm/src/render/color.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

//-- Exports --//
export 'escape.dart';
export 'application_structure_attribute.dart';
export 'attribute/attribute.dart';
export 'control/control.dart';
export 'delimiter/delimiter.dart';
export 'external/external.dart';
export 'graphical_primitive/graphical_primitive.dart';
export 'metafile_descriptor/metafile_descriptor.dart';
export 'picture_descriptor/picture_descriptor.dart';

/// Base class for all [CGM] commands.
class Command {
  @protected
  late List<int> arguments;

  @protected
  int currentArgument = 0;

  int _positionInArguments = 0;

  late final int _elementClass;
  late final int _elementId;
  String elementName = '';

  @protected
  CGM cgm;

  //-- Constructor --//
  Command(int ec, int eid, int l, ByteDataReader buffer, this.cgm) {
    _elementClass = ec;
    _elementId = eid;

    arguments = List<int>.filled(0, 0, growable: true);

    if (l != 31) {
      for (var i = 0; i < l; i++) {
        arguments.add(buffer.readUint8());
      }

      if (l % 2 == 1) {
        try {
          buffer.readUint8();
        } catch (e) {
          // Reached end of file, ignore.
        }
      }
    } else {
      bool done = false;
      // int a = 0;
      do {
        l = buffer.readUint16();
        if (l == -1) break;

        // Data is partitioned and not the last partition
        if ((l & (1 << 15)) != 0) {
          done = false;
          l = l & ~(1 << 15);
        } else {
          done = true;
        }

        for (var i = 0; i < l; i++) {
          arguments.add(buffer.readUint8());
        }

        // Align on word if required
        if (l % 2 == 1) {
          int skip = buffer.readUint8();
          assert(skip == 0, 'skip=$skip');
        }
      } while (!done);
    }
  }

  void paint(CGMDisplay display) {}

  //--< Read >--//
  static Command? read(ByteDataReader buffer, CGM cgm) {
    int k;

    // If we can't read the first two bytes, we're at the end of the file.
    // We return null to signal the end of the file.
    try {
      k = buffer.readUint8();
      k = (k << 8) | buffer.readUint8();
    } catch (e) {
      return null;
    }

    int elementClass = k >> 12;
    int elementId = (k >> 5) & 127;
    int l = k & 31;

    return readCommand(buffer, cgm, elementClass, elementId, l);
  }

  // TODO: remove this shit
  static Command _unipmlemented(
      ByteDataReader buffer, int elementClass, int elementId, int l, CGM cgm) {
    final eClass = ElementClass.getElementClass(elementClass);
    final eId = switch (eClass) {
      ElementClass.delimiterElements => DelimiterElement.getElement(elementId),
      ElementClass.metafileDescriptorElements =>
        MetafileDescriptorElement.getElement(elementId),
      ElementClass.pictureDescriptorElements =>
        PictureDescriptorElement.getElement(elementId),
      ElementClass.controlElements => ControlElement.getElement(elementId),
      ElementClass.graphicalPrimitiveElements =>
        GraphicalPrimitiveElement.getElement(elementId),
      ElementClass.attributeElements => AttributeElement.getElement(elementId),
      ElementClass.applicationStructureElements =>
        ApplicationStructureDescriptorElement.getElement(elementId),
      _ => null,
    };

    cgm.logger.warning('Unimplemented command: $eClass $eId');
    return Command(elementClass, elementId, l, buffer, cgm)
      ..elementName = eId?.name ?? 'Unknown';
  }

  //--< Read Command >--//
  static Command readCommand(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final element = ElementClass.getElementClass(elementClass);

    switch (element) {
      case ElementClass.delimiterElements:
        return _readDelimiterElements(buffer, cgm, elementClass, elementId, l);

      case ElementClass.metafileDescriptorElements:
        return _readMetafileDescriptorElements(
            buffer, cgm, elementClass, elementId, l);

      case ElementClass.pictureDescriptorElements:
        return _readPictureDescriptorElements(
            buffer, cgm, elementClass, elementId, l);

      case ElementClass.controlElements:
        return _readControlElements(buffer, cgm, elementClass, elementId, l);

      case ElementClass.graphicalPrimitiveElements:
        return _readGraphicalPrimitiveElements(
            buffer, cgm, elementClass, elementId, l);

      case ElementClass.attributeElements:
        return _readAttributeElements(buffer, cgm, elementClass, elementId, l);

      case ElementClass.escapeElements:
        return Escape(elementClass, elementId, l, buffer, cgm);

      case ElementClass.externalElements:
        return _readExternalElements(buffer, cgm, elementClass, elementId, l);

      case ElementClass.segmentElements:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case ElementClass.applicationStructureElements:
        return _readApplicationStructureDescriptorElements(
            buffer, cgm, elementClass, elementId, l);
    }
  }

  //--< Read Delimiter Elements >--//
  static Command _readDelimiterElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final DelimiterElement delimiterElement =
        DelimiterElement.getElement(elementId);
    switch (delimiterElement) {
      case DelimiterElement.noOp:
        return NoOp(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginMetafile:
        return BeginMetafile(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.endMetafile:
        return EndMetafile(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginPicture:
        return BeginPicture(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginPictureBody:
        return BeginPictureBody(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.endPicture:
        return EndPicture(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginSegment:
      case DelimiterElement.endSegment:
      case DelimiterElement.beginFigure:
        return BeginFigure(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.endFigure:
        return EndFigure(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginProtectionRegion:
      case DelimiterElement.endProtectionRegion:
      case DelimiterElement.beginCompoundLine:
      case DelimiterElement.endCompoundLine:
      case DelimiterElement.beginCompoundTextPath:
      case DelimiterElement.endCompoundTextPath:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginTileArray:
        return BeginTileArray(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.endTileArray:
        return EndTileArray(elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginApplicationStructure:
        return BeginApplicationStructure(
            elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.beginApplicationStructureBody:
        return BeginApplicationStructureBody(
            elementClass, elementId, l, buffer, cgm);

      case DelimiterElement.endApplicationStructure:
        return EndApplicationStructure(elementClass, elementId, l, buffer, cgm);

      default:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Metafile Descriptor Elements >--//
  static Command _readMetafileDescriptorElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final MetafileDescriptorElement metafileDescriptorElement =
        MetafileDescriptorElement.getElement(elementId);
    switch (metafileDescriptorElement) {
      case MetafileDescriptorElement.metafileVersion:
        return MetafileVersion(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.metafileDescription:
        return MetafileDescription(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.vdcType:
        return VDCType(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.integerPrecision:
        return IntegerPrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.realPrecision:
        return RealPrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.indexPrecision:
        return IndexPrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.colorPrecision:
        return ColorPrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.colorIndexPrecision:
        return ColorIndexPrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.maximumColorIndex:
        return MaximumColorIndex(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.colorValueExtent:
        return ColorValueExtent(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.metafileElementList:
        return MetafileElementList(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.metafileDefaultsReplacement:
        return MetafileDefaultsReplacement(
            elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.fontList:
        return FontList(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.characterSetList:
        return CharacterSetList(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.characterCodingAnnouncer:
        return CharacterCodingAnnouncer(
            elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.namePrecision:
        return NamePrecision(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.maximumVdcExtent:
        return MaximumVDCExtent(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.segmentPriorityExtent:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.colorModel:
        return ColorModel(elementClass, elementId, l, buffer, cgm);

      case MetafileDescriptorElement.colourCalibration:
      case MetafileDescriptorElement.fontProperties:
      case MetafileDescriptorElement.glyphMapping:
      case MetafileDescriptorElement.symbolLibraryList:
      case MetafileDescriptorElement.pictureDirectory:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      default:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Picture Descriptor Elements >--//
  static Command _readPictureDescriptorElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final PictureDescriptorElement pictureDescriptorElement =
        PictureDescriptorElement.getElement(elementId);
    switch (pictureDescriptorElement) {
      case PictureDescriptorElement.scalingMode:
        return ScalingMode(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.colourSelectionMode:
        return ColorSelectionMode(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.lineWidthSpecificationMode:
        return LineWidthSpecificationMode(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.markerSizeSpecificationMode:
        return MarkerSizeSpecificationMode(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.edgeWidthSpecificationMode:
        return EdgeWidthSpecificationMode(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.vdcExtent:
        return VDCExtent(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.backgroundColour:
        return BackgroundColor(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.deviceViewport:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.deviceViewportSpecificationMode:
        return DeviceViewportSpecificationMode(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.deviceViewportMapping:
      case PictureDescriptorElement.lineRepresentation:
      case PictureDescriptorElement.markerRepresentation:
      case PictureDescriptorElement.textRepresentation:
      case PictureDescriptorElement.fillRepresentation:
      case PictureDescriptorElement.edgeRepresentation:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.interiorStyleSpecificationMode:
        return InteriorStyleSpecificationMode(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.lineAndEdgeTypeDefinition:
        return LineAndEdgeTypeDefinition(
            elementClass, elementId, l, buffer, cgm);

      case PictureDescriptorElement.hatchStyleDefinition:
      case PictureDescriptorElement.geometricPatternDefinition:
      case PictureDescriptorElement.applicationStructureDirectory:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      default:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Control Elements >--//
  static Command _readControlElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final ControlElement controlElement = ControlElement.getElement(elementId);
    switch (controlElement) {
      case ControlElement.vdcIntegerPrecision:
        return VDCIntegerPrecision(elementClass, elementId, l, buffer, cgm);

      case ControlElement.vdcRealPrecision:
        return VDCRealPrecision(elementClass, elementId, l, buffer, cgm);

      case ControlElement.clipRectangle:
        return ClipRectangle(elementClass, elementId, l, buffer, cgm);

      case ControlElement.clipIndicator:
        return ClipIndicator(elementClass, elementId, l, buffer, cgm);

      case ControlElement.unused0:
      case ControlElement.auxiliaryColour:
      case ControlElement.transparency:
      case ControlElement.lineClippingMode:
      case ControlElement.markerClippingMode:
      case ControlElement.edgeClippingMode:
      case ControlElement.newRegion:
      case ControlElement.savePrimitiveContext:
      case ControlElement.restorePrimitiveContext:
      case ControlElement.protectionRegionIndicator:
      case ControlElement.generalizedTextPathMode:
      case ControlElement.mitreLimit:
      case ControlElement.transparentCellColour:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      default:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Graphical Primitive Elements >--//
  static Command _readGraphicalPrimitiveElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    final GraphicalPrimitiveElement graphicalPrimitiveElement =
        GraphicalPrimitiveElement.getElement(elementId);
    switch (graphicalPrimitiveElement) {
      case GraphicalPrimitiveElement.polyline:
        return Polyline(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.disjointPolyline:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return DisjointPolyline(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.polymarker:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return Polymarker(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.text:
        return Text(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.restrictedText:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return RestrictedText(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.appendText:
        return AppendText(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.polygon:
        return Polygon(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.polygonSet:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return PolygonSet(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.cellArray:
        return CellArray(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.generalizedDrawingPrimitive:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.rectangle:
        return Rectangle(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circle:
        return Circle(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circularArc3Point:
        return CircularArc3Point(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circularArc3PointClose:
        return CircularArc3PointClose(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circularArcCentre:
        return CircularArcCenter(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circularArcCentreClose:
        return CircularArcCenterClose(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.ellipse:
        return Ellipse(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.ellipticalArc:
        return EllipticalArc(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.ellipticalArcClose:
        return EllipticalArcClose(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.circularArcCentreReversed:
      case GraphicalPrimitiveElement.connectingEdge:
      case GraphicalPrimitiveElement.hyperbolicArc:
      case GraphicalPrimitiveElement.parabolicArc:
      case GraphicalPrimitiveElement.nonUniformBSpline:
      case GraphicalPrimitiveElement.nonUniformRationalBSpline:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.polybezier:
        return PolyBezier(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.polysymbol:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return PolySymbol(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.bitonalTile:
        return BitonalTile(elementClass, elementId, l, buffer, cgm);

      case GraphicalPrimitiveElement.tile:
        return _unipmlemented(buffer, elementClass, elementId, l, cgm);
      // TODO: return Tile(elementClass, elementId, l, buffer, cgm);

      default:
        Command.unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Attribute Elements >--//
  static Command _readAttributeElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    switch (AttributeElement.getElement(elementId)) {
      case AttributeElement.lineBundleIndex: // 1
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineType: // 2
        return LineType(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineWidth: // 3
        return LineWidth(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineColor: // 4
        return LineColor(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.markerBundleIndex: // 5
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.markerType: // 6
        return MarkerType(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.markerSize: // 7
        return MarkerSize(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.markerColor: // 8
        return MarkerColor(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textBundleIndex: // 9:
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textFontIndex: // 10
        return TextFontIndex(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textPrecision: // 11
        return TextPrecision(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.characterExpansionFactor: // 12
        return CharacterExpansionFactor(
            elementClass, elementId, l, buffer, cgm);

      case AttributeElement.characterSpacing: // 13
        return CharacterSpacing(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textColor: // 14
        return TextColor(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.characterHeight: // 15
        return CharacterHeight(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.characterOrientation: // 16
        return CharacterOrientation(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textPath: // 17
        return TextPath(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.textAlignment: // 18
        return TextAlignment(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.characterSetIndex: // 19
        return CharacterSetIndex(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.alternateCharacterSetIndex: // 20
        return AlternateCharacterSetIndex(
            elementClass, elementId, l, buffer, cgm);

      case AttributeElement.fillBundleIndex: // 21
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.interiorStyle: // 22
        return InteriorStyle(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.fillColor: // 23
        return FillColor(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.hatchIndex: // 24
        return HatchIndex(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.patternIndex: // 25
      case AttributeElement.edgeBundleIndex: // 26
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeType: // 27
        return EdgeType(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeWidth: // 28
        return EdgeWidth(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeColor: // 29
        return EdgeColor(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeVisibility: // 30
        return EdgeVisibility(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.fillReferencePoint: // 31
      case AttributeElement.patternTable: // 32
      case AttributeElement.patternSize: // 33
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.colorTable: // 34
        return ColorTable(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.aspectSourceFlags: // 35
      case AttributeElement.pickIdentifier: // 36
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineCap: // 37
        return LineCap(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineJoin: // 38
        return LineJoin(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.lineTypeContinuation: // 39
      case AttributeElement.lineTypeInitialOffset: // 40
      case AttributeElement.textScoreType: // 41
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.restrictedTextType: // 42
        return RestrictedTextType(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.interpolatedInterior: // 43
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeCap: // 44
        return EdgeCap(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeJoin: // 45
        return EdgeJoin(elementClass, elementId, l, buffer, cgm);

      case AttributeElement.edgeTypeContinuation: // 46
      case AttributeElement.edgeTypeInitialOffset: // 47
      case AttributeElement.symbolLibraryIndex: // 48
      case AttributeElement.symbolColor: // 49
      case AttributeElement.symbolSize: // 50
      case AttributeElement.symbolOrientation: // 51
      default:
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read External Elements >--//
  static Command _readExternalElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    switch (ExternalElements.getElement(elementId)) {
      case ExternalElements.message:
        return Message(elementClass, elementId, l, buffer, cgm);

      case ExternalElements.applicationData:
        return ApplicationData(elementClass, elementId, l, buffer, cgm);

      default:
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Read Application Structure Descriptor Elements >--//
  static Command _readApplicationStructureDescriptorElements(
      ByteDataReader buffer, CGM cgm, int elementClass, int elementId, int l) {
    switch (ApplicationStructureDescriptorElement.getElement(elementId)) {
      case ApplicationStructureDescriptorElement.applicationStructureAttribute:
        return ApplicationStructureAttribute(
            elementClass, elementId, l, buffer, cgm);

      default:
        unsupported(elementClass, elementId, cgm);
        return Command(elementClass, elementId, l, buffer, cgm);
    }
  }

  //--< Bit manipulation >--//
  //-- String --//
  @protected
  makeFixedString() => makeString(); // TODO: Implement fixed string

  @protected
  String makeString() {
    final length = _getStringCount();
    final stringBuffer = Uint8List(length);
    for (var i = 0; i < length; i++) {
      stringBuffer[i] = makeByte();
    }

    return Encoding.getByName('ISO-8859-1')?.decode(stringBuffer) ??
        stringBuffer.toString();
  }

  int _getStringCount() {
    int length = _makeUnsignedInt8();
    if (length == 255) {
      length = _makeUnsignedInt16();
      if ((length & (1 << 16)) != 0) {
        length = (length << 16) | _makeUnsignedInt16();
      }
    }

    return length;
  }

  //-- Signed integers --//
  @protected
  int makeInt([int? precision]) {
    _skipBits();

    precision ??= cgm.integerPrecision;

    return switch (precision) {
      8 => _makeSignedInt8(),
      16 => _makeSignedInt16(),
      24 => _makeSignedInt24(),
      32 => _makeSignedInt32(),
      _ => _makeSignedInt16(),
    };
  }

  @protected
  int sizeOfInt() {
    final precision = cgm.integerPrecision;
    return precision ~/ 8;
  }

  @protected
  int makeIndex() {
    final precision = cgm.indexPrecision;
    return makeInt(precision);
  }

  @protected
  int makeName() {
    final precision = cgm.namePrecision;
    return makeInt(precision);
  }

  int _makeSignedInt8() {
    _skipBits();
    assert(currentArgument < arguments.length,
        'currentArgument=$currentArgument arguments.length=${arguments.length}');
    return arguments[currentArgument++];
  }

  int _makeSignedInt16() {
    _skipBits();
    assert(currentArgument + 1 < arguments.length);
    return (arguments[currentArgument++] << 8) + arguments[currentArgument++];
  }

  int _makeSignedInt24() {
    _skipBits();
    assert(currentArgument + 2 < arguments.length);
    return (arguments[currentArgument++] << 16) +
        (arguments[currentArgument++] << 8) +
        arguments[currentArgument++];
  }

  int _makeSignedInt32() {
    _skipBits();
    assert(currentArgument + 3 < arguments.length);
    return (arguments[currentArgument++] << 24) |
        (arguments[currentArgument++] << 16) |
        (arguments[currentArgument++] << 8) |
        arguments[currentArgument++];
  }

  //-- Unsigned integers --//
  @protected
  makeUInt([int? precision]) {
    precision ??= cgm.integerPrecision;

    return switch (precision) {
      1 => _makeUnsignedInt1(),
      2 => _makeUnsignedInt2(),
      4 => _makeUnsignedInt4(),
      8 => _makeUnsignedInt8(),
      16 => _makeUnsignedInt16(),
      24 => _makeUnsignedInt24(),
      32 => _makeUnsignedInt32(),
      _ => _makeUnsignedInt8(),
    };
  }

  int _makeUnsignedInt1() => _makeUIntBit(1);

  int _makeUnsignedInt2() => _makeUIntBit(2);

  int _makeUnsignedInt4() => _makeUIntBit(4);

  int _makeUnsignedInt8() {
    _skipBits();
    assert(currentArgument < arguments.length);
    return arguments[currentArgument++];
  }

  int _makeUnsignedInt16() {
    _skipBits();

    if (currentArgument + 1 < arguments.length) {
      return (arguments[currentArgument++] << 8) + arguments[currentArgument++];
    }

    // Some CGM files request a 16-bit integer, when they only have 8 bits left.
    if (currentArgument < arguments.length) {
      return arguments[currentArgument++];
    }

    assert(false,
        'currentArgument=$currentArgument arguments.length=${arguments.length}');
    return 0;
  }

  int _makeUnsignedInt24() {
    _skipBits();
    assert(currentArgument + 2 < arguments.length);
    return (arguments[currentArgument++] << 16) +
        (arguments[currentArgument++] << 8) +
        arguments[currentArgument++];
  }

  int _makeUnsignedInt32() {
    _skipBits();
    assert(currentArgument + 3 < arguments.length);
    return (arguments[currentArgument++] << 24) |
        (arguments[currentArgument++] << 16) |
        (arguments[currentArgument++] << 8) |
        arguments[currentArgument++];
  }

  int _makeUIntBit(int numberOfBits) {
    assert(currentArgument < arguments.length);

    final int bitsPosition = 8 - numberOfBits - _positionInArguments;
    final int mask = ((1 << numberOfBits) - 1) << bitsPosition;
    final int returned = (arguments[currentArgument] & mask) >> bitsPosition;
    _positionInArguments += numberOfBits;

    if (_positionInArguments % 8 == 0) {
      _positionInArguments = 0;
      currentArgument++;
    }

    return returned;
  }

  //-- Real numbers --//
  @protected
  double makeVdc() {
    if (cgm.vdcType == VDCTypeType.real) {
      final precision = cgm.vdcRealPrecision;
      return switch (precision) {
        VDCRealPrecisionType.fixedPoint32bit => _makeFixedPoint32(),
        VDCRealPrecisionType.fixedPoint64bit => _makeFixedPoint64(),
        VDCRealPrecisionType.floatingPoint32bit => makeFloatingPoint32(),
        VDCRealPrecisionType.floatingPoint64bit => _makeFloatingPoint64(),
      };
    }

    final precision = cgm.vdcIntegerPrecision;
    return switch (precision) {
      16 => _makeSignedInt16(),
      24 => _makeSignedInt24(),
      32 => _makeSignedInt32(),
      _ => _makeSignedInt16(),
    }
        .toDouble();
  }

  @protected
  int sizeOfVdc() {
    final vdcType = cgm.vdcType;
    if (vdcType == VDCTypeType.integer) {
      final precision = cgm.vdcIntegerPrecision;
      return precision ~/ 8;
    }

    if (vdcType == VDCTypeType.real) {
      final precision = cgm.vdcRealPrecision;
      return switch (precision) {
        VDCRealPrecisionType.fixedPoint32bit => _sizeOfFixedPoint32(),
        VDCRealPrecisionType.fixedPoint64bit => _sizeOfFixedPoint64(),
        VDCRealPrecisionType.floatingPoint32bit => _sizeOfFloatingPoint32(),
        VDCRealPrecisionType.floatingPoint64bit => _sizeOfFloatingPoint64(),
      };
    }

    return 1;
  }

  @protected
  double makeVc() {
    return switch (cgm.deviceViewportSpecificationMode) {
      DeviceViewportSpecificationType.millimetersWithScaleFactor => makeInt(),
      DeviceViewportSpecificationType.physicalDeviceCoordinates => makeInt(),
      DeviceViewportSpecificationType.fractionOfDrawingSurface => makeReal(),
    }
        .toDouble();
  }

  @protected
  double makeReal() {
    final precision = cgm.realPrecision;
    return switch (precision) {
      RealPrecisionType.fixed32 => _makeFixedPoint32(),
      RealPrecisionType.fixed64 => _makeFixedPoint64(),
      RealPrecisionType.floating32 => makeFloatingPoint32(),
      RealPrecisionType.floating64 => _makeFloatingPoint64(),
    };
  }

  //-- Fixed point --//
  @protected
  double makeFixedPoint() {
    final precision = cgm.realPrecision;
    return switch (precision) {
      RealPrecisionType.fixed32 => _makeFixedPoint32(),
      RealPrecisionType.fixed64 => _makeFixedPoint64(),
      _ => _makeFixedPoint32(),
    };
  }

  double _makeFixedPoint32() {
    int whole = _makeSignedInt16();
    int fraction = _makeUnsignedInt16();

    return whole + (fraction / (2 << 15));
  }

  int _sizeOfFixedPoint32() => 2 + 2;

  double _makeFixedPoint64() {
    int whole = _makeSignedInt32();
    int fraction = _makeUnsignedInt32();

    return whole + (fraction / (2 << 31));
  }

  int _sizeOfFixedPoint64() => 4 + 4;

  //-- Floating point --//
  @protected
  double makeFloatingPoint() {
    final precision = cgm.realPrecision;
    return switch (precision) {
      RealPrecisionType.floating32 => makeFloatingPoint32(),
      RealPrecisionType.floating64 => _makeFloatingPoint64(),
      _ => makeFloatingPoint32(),
    };
  }

  @protected
  double makeFloatingPoint32() {
    _skipBits();
    // We don't have a native way to convert bytes to float, so we use a hack.
    final buffer = Uint8List(4);
    for (var i = 0; i < 4; i++) {
      buffer[i] = makeByte();
    }

    return ByteData.sublistView(buffer).getFloat32(0);
  }

  int _sizeOfFloatingPoint32() => 2 * 2;

  double _makeFloatingPoint64() {
    _skipBits();
    // We don't have a native way to convert bytes to double, so we use a hack.
    final buffer = Uint8List(8);
    for (var i = 0; i < 8; i++) {
      buffer[i] = makeByte();
    }

    return ByteData.sublistView(buffer).getFloat64(0);
  }

  int _sizeOfFloatingPoint64() => 2 * 4;

  //-- Misc --//
  //-- Enum --//
  @protected
  int makeEnum() => _makeSignedInt16();

  @protected
  int sizeOfEnum() => 2;

  //-- Point --//
  @protected
  Vector2 makePoint() {
    final x = makeVdc();
    final y = makeVdc();
    return Vector2(x, y);
  }

  @protected
  int sizeOfPoint() => sizeOfVdc() * 2;

  //-- Colour --//
  @protected
  int makeColorIndex([int? precision]) =>
      makeUInt(precision ?? cgm.colorIndexPrecision);

  @protected
  Color makeDirectColor() {
    final int precision = cgm.colorPrecision;
    final ColorModelType colorModel = cgm.colorModel;

    switch (colorModel) {
      case ColorModelType.rgb:
        List<int> scaled = _scaleColorValueRGB(
          makeUInt(precision),
          makeUInt(precision),
          makeUInt(precision),
        );
        return Color.fromRGBO(scaled[0], scaled[1], scaled[2], 1);

      case ColorModelType.cmyk:
        List<double> components = [
          makeUInt(precision),
          makeUInt(precision),
          makeUInt(precision),
          makeUInt(precision),
        ];
        final red = (255 * (1 - components[0]) * (1 - components[3])).round();
        final green = (255 * (1 - components[1]) * (1 - components[3])).round();
        final blue = (255 * (1 - components[2]) * (1 - components[3])).round();
        return Color.fromRGBO(red, green, blue, 255);

      case ColorModelType.cielab:
      case ColorModelType.cieluv:
      case ColorModelType.rgbRelated:
        Command.unimplemented(cgm,
            message: 'Unsupported color model: $colorModel');
        makeUInt(precision);
        makeUInt(precision);
        makeUInt(precision);
        return const Color.fromRGBO(0, 255, 255, 255);
    }
  }

  @protected
  int sizeOfDirectColor() {
    final int precision = cgm.colorPrecision;
    final ColorModelType colorModel = cgm.colorModel;

    if (colorModel == ColorModelType.rgb) {
      return 3 * precision ~/ 8;
    }

    assert(colorModel != ColorModelType.rgb,
        'Unsupported color model: $colorModel');
    return 0;
  }

  List<int> _scaleColorValueRGB(int red, int green, int blue) {
    final List<int> min = cgm.minimumColorValueRGB;
    final List<int> max = cgm.maximumColorValueRGB;

    red = red.clamp(min[0], max[0]);
    green = green.clamp(min[0], max[0]);
    blue = blue.clamp(min[0], max[0]);

    assert(min[0] != max[0] && min[1] != max[1] && min[2] != max[2]);

    return [
      255 * (red - min[0]) ~/ (max[0] - min[0]),
      255 * (green - min[1]) ~/ (max[1] - min[1]),
      255 * (blue - min[2]) ~/ (max[2] - min[2]),
    ];
  }

  //-- SDR --//
  @protected
  StructuredDataRecord makeSDR() {
    StructuredDataRecord sdr = StructuredDataRecord();

    final int sdrLength = _getStringCount();
    final int startingPosition = currentArgument;

    while (currentArgument < (startingPosition + sdrLength)) {
      final StructuredDataType dataType = StructuredDataType.from(makeIndex());
      final List<Object> data = <Object>[];
      final int dataCount = makeInt();

      for (int i = 0; i < dataCount; i++) {
        switch (dataType) {
          case StructuredDataType.sdr:
            break;
          case StructuredDataType.ci:
            data.add(makeColorIndex());
            break;
          case StructuredDataType.cd:
            data.add(makeDirectColor());
            break;
          case StructuredDataType.n:
            data.add(makeName());
            break;
          case StructuredDataType.e:
            data.add(makeEnum());
            break;
          case StructuredDataType.i:
            data.add(makeInt());
            break;
          case StructuredDataType.reserved:
            // reserved
            break;
          case StructuredDataType.if8:
            data.add(_makeSignedInt8());
            break;
          case StructuredDataType.if16:
            data.add(_makeSignedInt16());
            break;
          case StructuredDataType.if32:
            data.add(_makeSignedInt32());
            break;
          case StructuredDataType.ix:
            data.add(makeIndex());
            break;
          case StructuredDataType.r:
            data.add(makeReal());
            break;
          case StructuredDataType.s:
            data.add(makeString());
            break;
          case StructuredDataType.sf:
            data.add(makeString());
            break;
          case StructuredDataType.vc:
            data.add(makeVc());
            break;
          case StructuredDataType.vdc:
            data.add(makeVdc());
            break;
          case StructuredDataType.cco:
            data.add(makeDirectColor());
            break;
          case StructuredDataType.ui8:
            data.add(_makeUnsignedInt8());
            break;
          case StructuredDataType.ui32:
            data.add(_makeUnsignedInt32());
            break;
          case StructuredDataType.bs:
            // bit stream? XXX how do we know how many bits to read?
            break;
          case StructuredDataType.cl:
            // color list? XXX how to read?
            break;
          case StructuredDataType.ui16:
            data.add(_makeUnsignedInt16());
            break;
        }
      }
      sdr.add(dataType, dataCount, data);
    }

    return sdr;
  }

  @protected
  void alignOnWord() {
    if (currentArgument >= arguments.length) {
      return;
    }

    if (currentArgument % 2 == 0 && _positionInArguments > 0) {
      _positionInArguments = 0;
      currentArgument += 2;
    } else if (currentArgument % 2 == 1) {
      _positionInArguments = 0;
      currentArgument++;
    }
  }

  @protected
  double makeSizeSpecification(SpecificationMode mode) {
    if (mode == SpecificationMode.absolute) {
      return makeVdc();
    }

    return makeReal();
  }

  @protected
  int makeByte() {
    _skipBits();
    assert(currentArgument < arguments.length);
    return arguments[currentArgument++];
  }

  void _skipBits() {
    if (_positionInArguments % 8 != 0) {
      _positionInArguments = 0;
      currentArgument++;
    }
  }

  void cleanupArguments() {
    arguments = List.empty();
  }

  @override
  String toString() =>
      'Command(class: $_elementClass, id: $_elementId, arguments: $arguments, elementName:'
      '$elementName)';

  static void unsupported(int elementClass, int elementId, CGM cgm) {
    // 0,0 is NO-OP
    if (elementClass == 0 && elementId == 0) return;

    cgm.logger
        .warning('Unsupported element: class: $elementClass, id: $elementId');
  }

  static void unimplemented(CGM cgm,
      {String? message, int? elementClass, int? elementId}) {
    final String element = elementClass != null && elementId != null
        ? 'class: $elementClass, id: $elementId'
        : '';
    cgm.logger.warning('Unimplemented element: $element $message');
  }
}
