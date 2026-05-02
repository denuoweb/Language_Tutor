enum ReviewGrade {
  again('Again'),
  hard('Hard'),
  good('Good'),
  easy('Easy');

  const ReviewGrade(this.label);

  final String label;

  static ReviewGrade fromLabel(String value) {
    return ReviewGrade.values.firstWhere(
      (grade) => grade.label == value,
      orElse: () => ReviewGrade.good,
    );
  }
}
