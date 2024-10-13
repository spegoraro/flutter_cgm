enum StructuredDataType {
  sdr(1),
  ci(2),
  cd(3),
  n(4),
  e(5),
  i(6),
  reserved(7),
  if8(8),
  if16(9),
  if32(10),
  ix(11),
  r(12),
  s(13),
  sf(14),
  vc(15),
  vdc(16),
  cco(17),
  ui8(18),
  ui32(19),
  bs(20),
  cl(21),
  ui16(22);

  final int value;

  const StructuredDataType(this.value);

  static StructuredDataType from(int index) {
    return values.firstWhere((e) => e.value == index);
  }
}

class StructuredDataRecord {
  final List<Member> _members;
  List<Member> get members => _members;

  StructuredDataRecord() : _members = <Member>[];

  void add(StructuredDataType type, int count, List<Object> data) => _members.add(Member(type, count, data));

  @override
  String toString() {
    return 'StructuredDataRecord -> { members: [ '
        '${_members.map((e) => 'type: ${e.type.name}, count: ${e.count}, data: ${e.data}')} ] }';
  }
}

class Member {
  final StructuredDataType _type;
  final int _count;
  final List<Object> _data;

  Member(this._type, this._count, this._data);

  StructuredDataType get type => _type;
  int get count => _count;
  List<Object> get data => _data;
}
