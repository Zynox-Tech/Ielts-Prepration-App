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

class ListeningTestModel {
  final String id;
  final String title;
  final String audioUrl;
  final List<QuestionModel> questions;
  final int duration; // in seconds
  final String difficulty;
  bool isCompleted;
  double score;

  ListeningTestModel({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.questions,
    required this.duration,
    this.difficulty = 'Medium',
    this.isCompleted = false,
    this.score = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'audioUrl': audioUrl,
      'questions': questions.map((q) => q.toMap()).toList(),
      'duration': duration,
      'difficulty': difficulty,
      'isCompleted': isCompleted,
      'score': score,
    };
  }

  factory ListeningTestModel.fromMap(Map<String, dynamic> map) {
    return ListeningTestModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      audioUrl: map['audioUrl'] ?? '',
      questions: (map['questions'] as List)
          .map((q) => QuestionModel.fromMap(q))
          .toList(),
      duration: map['duration'] ?? 0,
      difficulty: map['difficulty'] ?? 'Medium',
      isCompleted: map['isCompleted'] ?? false,
      score: map['score']?.toDouble() ?? 0.0,
    );
  }
}
