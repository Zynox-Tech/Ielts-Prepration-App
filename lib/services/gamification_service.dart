class GamificationService {
  static int calculatePoints(double score) {
    return (score * 100).toInt();
  }

  static List<String> awardBadges(int points) {
    final badges = <String>[];
    if (points >= 500) badges.add("Grammar Master");
    if (points >= 1000) badges.add("Fluent Speaker");
    return badges;
  }
}
