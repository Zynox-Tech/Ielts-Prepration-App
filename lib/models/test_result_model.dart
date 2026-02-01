class TestResultModel {
  final int correctWordsLength;
  final int incorrectWordsLength;
  final int grammarErrorsLength;
  final String band;
  final Map<String, String> misSpelling;
  final String feedback;
  final String essay;
  final int wordCount;

  TestResultModel({
    required this.correctWordsLength,
    required this.incorrectWordsLength,
    required this.grammarErrorsLength,
    required this.band,
    required this.misSpelling,
    required this.feedback,
    required this.essay,
    required this.wordCount,
  });

  /// Factory constructor to parse from JSON/Map
  factory TestResultModel.fromMap(Map<String, dynamic> map,{String? essay, int? wordCount}) {
    return TestResultModel(
      correctWordsLength: int.tryParse(map["correct_words_length"].toString()) ?? 0,
      incorrectWordsLength: int.tryParse(map["incorrect_words_length"].toString()) ?? 0,
      grammarErrorsLength: int.tryParse(map["grammar_errors_length"].toString()) ?? 0,
      band: map["band"]?.toString() ?? "",
      misSpelling: Map<String, String>.from(map["mis_spelling"] ?? {}),
      feedback: map["feedback"]?.toString() ?? "",
      essay: essay??(map["essay"]?.toString() ?? ""),
      wordCount: wordCount ?? ((int.tryParse((map["word_count"]??"0").toString())) ?? 0),
    );
  }

  /// Convert back to Map
  Map<String, dynamic> toMap() {
    return {
      "correct_words_length": correctWordsLength,
      "incorrect_words_length": incorrectWordsLength,
      "grammar_errors_length": grammarErrorsLength,
      "band": band,
      "mis_spelling": misSpelling,
      "feedback": feedback,
      "essay": essay,
      "word_count": wordCount,
    };
  }
}
