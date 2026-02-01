class ReadingTestModel {
  final String id;
  final String title;
  final String passage;
  final List<QuestionModel> questions;
  final String difficulty;
  bool isCompleted;
  double score;

  ReadingTestModel({
    required this.id,
    required this.title,
    required this.passage,
    required this.questions,
    this.difficulty = 'Medium',
    this.isCompleted = false,
    this.score = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'passage': passage,
      'questions': questions.map((q) => q.toMap()).toList(),
      'difficulty': difficulty,
      'isCompleted': isCompleted,
      'score': score,
    };
  }

  factory ReadingTestModel.fromMap(Map<String, dynamic> map) {
    return ReadingTestModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      passage: map['passage'] ?? '',
      questions: (map['questions'] as List)
          .map((q) => QuestionModel.fromMap(q))
          .toList(),
      difficulty: map['difficulty'] ?? 'Medium',
      isCompleted: map['isCompleted'] ?? false,
      score: map['score']?.toDouble() ?? 0.0,
    );
  }
}

class QuestionModel {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String questionType; // 'multiple_choice', 'true_false'

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.questionType = 'multiple_choice',
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'questionType': questionType,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswerIndex: map['correctAnswerIndex'] ?? 0,
      questionType: map['questionType'] ?? 'multiple_choice',
    );
  }
}
