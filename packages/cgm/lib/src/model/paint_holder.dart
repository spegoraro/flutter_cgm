import 'package:cgm/cgm.dart';

class CGMPaintHolder {
  FillColor? _fillColor;
  EdgeColor? _edgeColor;
  EdgeWidth? _edgeWidth;
  LineColor? _lineColor;
  LineWidth? _lineWidth;
  String _apsId = '';

  final List<ApplicationStructureAttribute> _attributes = [];

  FillColor? get fillColor => _fillColor;
  EdgeColor? get edgeColor => _edgeColor;
  EdgeWidth? get edgeWidth => _edgeWidth;
  LineColor? get lineColor => _lineColor;
  LineWidth? get lineWidth => _lineWidth;
  String get apsId => _apsId;

  String getName() {
    for (final attribute in _attributes) {
      final attributeType = attribute.applicationStructureAttributeType;
      if (attributeType == "name") {
        final members = attribute.structuredDataRecord.members;
        if (members.length == 1 &&
            members.first.count > 0 &&
            members.first.data.isNotEmpty &&
            members.first.data.first is String) {
          return members.first.data.first as String;
        }
      }
    }

    return '';
  }

  ApplicationStructureAttribute? getRegionAttribute() {
    for (final attribute in _attributes) {
      final attributeType = attribute.applicationStructureAttributeType;
      if (attributeType == "region") {
        return attribute;
      }
    }
    return null;
  }

  ApplicationStructureAttribute? getViewContextAttribute() {
    for (final attribute in _attributes) {
      final attributeType = attribute.applicationStructureAttributeType;
      if (attributeType == "viewcontext") {
        return attribute;
      }
    }
    return null;
  }

  void addAttribute(ApplicationStructureAttribute attribute) {
    _attributes.add(attribute);
  }

  //<- Setters ->//
  void setFillColor(FillColor fillColor) {
    _fillColor = fillColor;
  }

  void setEdgeColor(EdgeColor edgeColor) {
    _edgeColor = edgeColor;
  }

  void setEdgeWidth(EdgeWidth edgeWidth) {
    _edgeWidth = edgeWidth;
  }

  void setLineColor(LineColor lineColor) {
    _lineColor = lineColor;
  }

  void setLineWidth(LineWidth lineWidth) {
    _lineWidth = lineWidth;
  }

  void setApsId(String apsId) {
    _apsId = apsId;
  }
}
