class UserProgress {
  int totalPoints;
  Map<String, double> moduleScores;
  List<String> badges;

  UserProgress({this.totalPoints = 0, required this.moduleScores, required this.badges});
}
