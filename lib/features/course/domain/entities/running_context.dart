class RecommendationWeights {
  final double distance;
  final double difficulty;
  final double goal;
  final double popularity;

  const RecommendationWeights({
    required this.distance,
    required this.difficulty,
    required this.goal,
    required this.popularity,
  });
}

enum RunningContext {
  defaultMode(
    RecommendationWeights(distance: 0.3, difficulty: 0.3, goal: 0.2, popularity: 0.2),
  ),
  quick(
    RecommendationWeights(distance: 0.5, difficulty: 0.2, goal: 0.1, popularity: 0.2),
  ),
  training(
    RecommendationWeights(distance: 0.2, difficulty: 0.4, goal: 0.3, popularity: 0.1),
  ),
  explore(
    RecommendationWeights(distance: 0.3, difficulty: 0.2, goal: 0.1, popularity: 0.4),
  );

  final RecommendationWeights weights;

  const RunningContext(this.weights);
}
