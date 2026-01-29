class XpCalculator {
  int calculateRunXp({required double distanceKm}) {
    return (distanceKm * 10).round();
  }

  int get firstCourseBonus => 20;
}
