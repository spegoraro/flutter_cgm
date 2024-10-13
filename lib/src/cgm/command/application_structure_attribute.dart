import 'package:flutter_cgm/src/cgm/cgm.dart';

class ApplicationStructureAttribute extends Command {
  late final String applicationStructureAttributeType;
  late final StructuredDataRecord structuredDataRecord;

  ApplicationStructureAttribute(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    applicationStructureAttributeType = makeString();
    structuredDataRecord = makeSDR();
  }

  @override
  String toString() =>
      'ApplicationStructureAttribute(applicationStructureAttributeType: $applicationStructureAttributeType, structuredDataRecord: $structuredDataRecord)';
}
