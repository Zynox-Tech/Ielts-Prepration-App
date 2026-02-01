import 'package:flutter/material.dart';

class ReadingScreen extends StatelessWidget {
  final passages = [
    {"text": "Passage 1: Lorem ipsum...", "difficulty": 1},
    {"text": "Passage 2: Advanced reading...", "difficulty": 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adaptive Reading")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: passages.length,
        itemBuilder: (ctx, i) {
          final p = passages[i];
          return Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Difficulty: ${p['difficulty']}"),
                  SizedBox(height: 8),
                  Text(p['text'] as String),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
