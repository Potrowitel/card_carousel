class ScrollAnimModel {
  int currentCard;
  double currentScale;
  double currentMargin;
  double previousScale;
  double previousMargin;
  ScrollDirection direction;
  int percent;

  ScrollAnimModel({
    required this.currentCard,
    required this.currentScale,
    required this.previousScale,
    required this.previousMargin,
    required this.currentMargin,
    required this.direction,
    required this.percent,
  });
}
