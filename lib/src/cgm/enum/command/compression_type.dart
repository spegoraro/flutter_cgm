enum CompressionType {
  nullBackground(0),
  nullForeground(1),
  t6(2),
  t4_1(3),
  t4_2(4),
  bitmap(5),
  runLength(6),
  baselineJpeg(7, 'jpeg'),
  lzw(8),
  png(9, 'png');

  final int identifier;
  final String? format;

  const CompressionType(this.identifier, [this.format]);

  static CompressionType from(int identifier) {
    return CompressionType.values.firstWhere((element) => element.identifier == identifier);
  }
}
