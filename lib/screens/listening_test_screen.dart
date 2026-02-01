import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/models/listening_test_model.dart';

class ListeningTestScreen extends StatefulWidget {
  final ListeningTestModel test;

  const ListeningTestScreen({super.key, required this.test});

  @override
  State<ListeningTestScreen> createState() => _ListeningTestScreenState();
}

class _ListeningTestScreenState extends State<ListeningTestScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  List<int?> selectedAnswers = [];
  bool isSubmitted = false;
  double score = 0.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    selectedAnswers = List<int?>.filled(widget.test.questions.length, null);

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.test.audioUrl));
    }
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
          .collection('listening_results')
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

        // Update Listening score
        currentScores['Listening'] = score * 9.0; // Convert to 9-point scale

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
            // Audio Player
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          size: 64,
                          color: const Color(0xFF4F46E5),
                        ),
                        onPressed: _playPause,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(position)),
                        Text(_formatDuration(duration)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Questions
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.test.questions.length,
                itemBuilder: (context, index) {
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
                              color: const Color(0xFF4F46E5),
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
                          ...List.generate(question.options.length, (optIndex) {
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
                                    ? const Color(0xFF4F46E5).withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: showCorrect
                                      ? Colors.green
                                      : showIncorrect
                                      ? Colors.red
                                      : isSelected
                                      ? const Color(0xFF4F46E5)
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
                                activeColor: const Color(0xFF4F46E5),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
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
                      backgroundColor: const Color(0xFF4F46E5),
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
