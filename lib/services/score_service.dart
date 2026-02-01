class ScoreService {
  static double calculateWPM(int words, double durationSec) {
    return durationSec > 0 ? (words / durationSec) * 60 : 0;
  }
}
