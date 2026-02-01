import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/models/reading_test_model.dart';

class ReadingTestScreen extends StatefulWidget {
  final ReadingTestModel test;

  const ReadingTestScreen({super.key, required this.test});

  @override
  State<ReadingTestScreen> createState() => _ReadingTestScreenState();
}

class _ReadingTestScreenState extends State<ReadingTestScreen> {
  List<int?> selectedAnswers = [];
  bool isSubmitted = false;
  double score = 0.0;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(widget.test.questions.length, null);
  }

  void _submitTest() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.test.questions.length; i++) {
      if (selectedAnswers[i] == widget.test.questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    score = correctAnswers / widget.test.questions.length;

    setState(() {
      isSubmitted = true;
    });

    _saveResult();
  }

  Future<void> _saveResult() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Save individual result
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('reading_results')
          .add({
            'testId': widget.test.id,
            'score': score,
            'timestamp': FieldValue.serverTimestamp(),
          });

      // Update aggregate stats
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userDoc);
        if (!snapshot.exists) return;

        final data = snapshot.data() as Map<String, dynamic>;
        final currentScores = Map<String, dynamic>.from(data['scores'] ?? {});

        // Update Reading score
        currentScores['Reading'] = score * 9.0; // Convert to 9-point scale

        // Calculate total points
        double total = 0;
        int count = 0;
        currentScores.forEach((key, value) {
          if (value is num && value > 0) {
            total += value;
            count++;
          }
        });
        double totalPoints = count > 0 ? total / count : 0;

        transaction.update(userDoc, {
          'scores': currentScores,
          'totalPoints': totalPoints,
        });
      });
    } catch (e) {
      print("Error saving result: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.test.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Passage Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Passage
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reading Passage',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF97316),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.test.passage,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              height: 1.6,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Questions
                  Text(
                    'Questions',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...List.generate(widget.test.questions.length, (index) {
                    final question = widget.test.questions[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question ${index + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFF97316),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              question.question,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...List.generate(question.options.length, (
                              optIndex,
                            ) {
                              final isSelected =
                                  selectedAnswers[index] == optIndex;
                              final isCorrect =
                                  question.correctAnswerIndex == optIndex;
                              final showCorrect = isSubmitted && isCorrect;
                              final showIncorrect =
                                  isSubmitted && isSelected && !isCorrect;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: showCorrect
                                      ? Colors.green.withOpacity(0.1)
                                      : showIncorrect
                                      ? Colors.red.withOpacity(0.1)
                                      : isSelected
                                      ? const Color(0xFFF97316).withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: showCorrect
                                        ? Colors.green
                                        : showIncorrect
                                        ? Colors.red
                                        : isSelected
                                        ? const Color(0xFFF97316)
                                        : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                ),
                                child: RadioListTile<int>(
                                  value: optIndex,
                                  groupValue: selectedAnswers[index],
                                  onChanged: isSubmitted
                                      ? null
                                      : (value) {
                                          setState(() {
                                            selectedAnswers[index] = value;
                                          });
                                        },
                                  title: Text(question.options[optIndex]),
                                  activeColor: const Color(0xFFF97316),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Submit Button
            if (!isSubmitted)
              Container(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: selectedAnswers.every((answer) => answer != null)
                        ? _submitTest
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Submit Test',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

            // Results
            if (isSubmitted)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF10B981), width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(score * 100).toInt()}%',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Band: ${(score * 9).toStringAsFixed(1)}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
