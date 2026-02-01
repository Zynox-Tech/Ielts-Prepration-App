import 'package:flutter/material.dart';

class QuizzesScreen extends StatefulWidget {
  @override
  _QuizzesScreenState createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final questions = [
    {
      "q": "What is the synonym of 'big'?",
      "options": ["Small", "Large", "Tiny", "Short"],
      "answer": "Large"
    },
    {
      "q": "Choose the correct verb: He ____ to school.",
      "options": ["go", "goes", "gone", "going"],
      "answer": "goes"
    }
  ];

  int current = 0;
  int score = 0;

  void answer(String selected) {
    if (selected == questions[current]['answer']) score += 10;
    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Quiz Completed"),
                content: Text("Your Score: $score"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];
    return Scaffold(
      appBar: AppBar(title: Text("Quizzes Module")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q${current + 1}: ${q['q']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ...((q['options'] as List<String>).map((opt) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                      onPressed: () => answer(opt), child: Text(opt)),
                )))
          ],
        ),
      ),
    );
  }
}
