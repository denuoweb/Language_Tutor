enum JlptLevel {
  n5('N5'),
  n4('N4'),
  n3('N3'),
  n2('N2'),
  n1('N1');

  const JlptLevel(this.label);

  final String label;

  static JlptLevel fromLabel(String value) {
    return JlptLevel.values.firstWhere(
      (level) => level.label == value,
      orElse: () => JlptLevel.n5,
    );
  }
}
