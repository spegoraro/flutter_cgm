import 'package:cgm/cgm.dart';

class BeginApplicationStructure extends Command {
  late final String _applicationStructureIdentifier;
  late final String _applicationStructureType;
  late final bool _inheritanceFlag;

  String get applicationStructureIdentifier => _applicationStructureIdentifier;

  BeginApplicationStructure(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _applicationStructureIdentifier = makeString();
    _applicationStructureType = makeString();
    _inheritanceFlag = makeEnum() >= 1;
  }

  @override
  void paint(CGMDisplay display) {
    display.newApplicationStructure(this);
  }

  @override
  String toString() {
    return '[UNSUPPORTED] BeginApplicationStructure -> { Application Structure Identifier: $_applicationStructureIdentifier, Application Structure Type: $_applicationStructureType, Inheritance Flag: $_inheritanceFlag }';
  }
}
