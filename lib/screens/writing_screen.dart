import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ielts/models/test_result_model.dart';
import 'package:ielts/models/writing_test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String GEMINI_API_KEY = 'AIzaSyCsW57g5BA_3nrsiaIJKnSMhQ131s0LY58';

// ignore: must_be_immutable
class WritingScreen extends StatefulWidget {
  final WritingTestModel test;
  final int level; // 1 for Task 1 (Picture), 2 for Task 2 (Essay)

  const WritingScreen({super.key, required this.test, required this.level});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final TextEditingController essayController = TextEditingController();
  int liveWordCount = 0;
  final _gemini = GenerativeModel(
    model: "gemini-2.5-flash",
    apiKey: GEMINI_API_KEY,
  );

  bool loading = false;
  late int level;
  int correctTextLength = 0;
  int incorrectTextLength = 0;
  int numberOfGrammarErrors = 0;

  String band = "";
  String feedback = "";
  Map<String, dynamic> misspellings = {};

  @override
  void initState() {
    super.initState();
    level = widget.level;
  }

  final String pictureUrl =
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80";

  final String essayTitle =
      "Some people believe that unpaid community service should be a compulsory part of high school programmes. To what extent do you agree or disagree?";

  Future<void> analyzeEssay() async {
    final essay = essayController.text.trim();
    if (essay.isEmpty) return;

    int minWords = 0;
    if (level == 1)
      minWords = 150;
    else if (level == 2)
      minWords = 250;

    final wordCount = essay.split(RegExp(r"\s+")).length;
    if (wordCount < minWords) {
      setState(() {
        band = "";
        feedback = "Please write at least $minWords words. Current: $wordCount";
      });
      return;
    }

    setState(() => loading = true);

    String prompt;
    if (level == 1) {
      prompt =
          '''
You are an IELTS examiner. The candidate is writing about the following picture:
${widget.test.pictureUrl}

Essay:
"$essay"

Return ONLY valid JSON:
{
  "correct_words_length": "Length of correct words",
  "incorrect_words_length": "Length of incorrect words",
  "grammar_errors_length": "Number of grammar errors",
  "band": "",
  "mis_spelling": "key-value pair of misspelled words as Key  and value as 'Corrected Spellings' of the Key, Like
  'mis_spelling': {
  'teh':'the','goof':'good'} ",
  "feedback": "Short feedback including grammar, spelling, and suggestions."
}

Note: Focus on task achievement, coherence, and vocabulary for picture description and do not mention the picture itself and also avoid generic statements and return the feedback in a structured format and keep short words.
''';
    } else {
      prompt =
          '''
You are an IELTS examiner. The candidate is writing an essay on the following topic:
${widget.test.statement}

Essay:
"$essay"

Return ONLY valid JSON:
{
  "correct_words_length": "Length of correct words",
  "incorrect_words_length": "Length of incorrect words",
  "grammar_errors_length": "Number of grammar errors",
  "grammar_errors": [
    {"original": "...", "suggestion": "...", "message": "...", "word_index": 0}
  ],
  "band": "",
  "mis_spelling": "key-value pair of misspelled words as Key  and value as 'Corrected Spellings' of the Key, Like
  'mis_spelling': {
  'teh':'the','goof':'good'} ",
  "feedback": "Short feedback including grammar, spelling, and suggestions."
}
Note: Focus on task achievement, coherence, and vocabulary for essay writing and avoid generic statements and return the feedback in a structured format and keep short words.
''';
    }

    try {
      final response = await _gemini.generateContent([Content.text(prompt)]);
      final text = response.text ?? "";
      final map = _extractJson(text);

      if (map != null) {
        print("::::::: PARSED MAP $map");

        // Save result to Firestore
        await _saveResult(map);

        final prefs = await SharedPreferences.getInstance();
        if (level == 1) {
          prefs.setString(
            "${widget.test.id}_picture",
            jsonEncode(
              TestResultModel.fromMap(
                map,
                essay: essay,
                wordCount: wordCount,
              ).toMap(),
            ),
          );
        } else {
          prefs.setString(
            "${widget.test.id}_essay",
            jsonEncode(
              TestResultModel.fromMap(
                map,
                essay: essay,
                wordCount: wordCount,
              ).toMap(),
            ),
          );
        }

        setState(() {
          correctTextLength =
              int.tryParse(map['correct_words_length'].toString()) ?? 0;
          incorrectTextLength =
              int.tryParse(map['incorrect_words_length'].toString()) ?? 0;
          numberOfGrammarErrors =
              int.tryParse(map['grammar_errors_length'].toString()) ?? 0;
          band = map['band']?.toString() ?? "";
          feedback = map['feedback']?.toString() ?? "";
          misspellings = Map<String, dynamic>.from(map['mis_spelling'] ?? {});
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        feedback = "Error analyzing essay. Please try again.";
      });
    } finally {
      setState(() => loading = false);
    }
  }

  Map<String, dynamic>? _extractJson(String text) {
    try {
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');
      if (startIndex != -1 && endIndex != -1) {
        final jsonString = text.substring(startIndex, endIndex + 1);
        return jsonDecode(jsonString);
      }
    } catch (e) {
      print("JSON Parse Error: $e");
    }
    return null;
  }

  Future<void> _saveResult(Map<String, dynamic> result) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Save individual result
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('writing_results')
          .add({
            ...result,
            'testId': widget.test.id,
            'taskType': level == 1 ? 'picture' : 'essay',
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
        final currentBadges = List<String>.from(data['badges'] ?? []);

        double newBand = double.tryParse(result['band'].toString()) ?? 0.0;
        currentScores['Writing'] = newBand;

        // Badges
        if (newBand >= 7 && !currentBadges.contains("Writing Pro")) {
          currentBadges.add("Writing Pro");
        }
        if (newBand >= 6 && !currentBadges.contains("Writing Achiever")) {
          currentBadges.add("Writing Achiever");
        }

        // Calculate total points (average of all modules)
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
          'badges': currentBadges,
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
    final textColor = isDark
        ? Colors.white
        : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Writing Practice",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Card
            _buildTaskCard(isDark, textColor),
            const SizedBox(height: 24),

            // Essay Input
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Essay",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "$liveWordCount words",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF4F46E5),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  TextField(
                    controller: essayController,
                    maxLines: 12,
                    onChanged: (val) {
                      setState(() {
                        liveWordCount = val.trim().isEmpty
                            ? 0
                            : val.trim().split(RegExp(r"\s+")).length;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Start writing here...",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      contentPadding: const EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Analyze Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: loading ? null : analyzeEssay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.analytics_outlined),
                          const SizedBox(width: 8),
                          Text(
                            "Analyze Essay",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 32),

            // Results Section
            if (band.isNotEmpty) ...[
              Text(
                "Analysis Results",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.assignment_outlined,
                      color: Color(0xFF4F46E5),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Writing Task ${level == 1 ? '1' : '2'}",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: _showSampleAnswer,
                icon: const Icon(Icons.lightbulb_outline, size: 18),
                label: const Text("Sample"),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            level == 1 ? "Describe the image below" : widget.test.statement,
            style: GoogleFonts.poppins(
              fontSize: 16,
              height: 1.5,
              color: const Color(0xFF4B5563),
            ),
          ),
          if (level == 1) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.test.pictureUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: Colors.grey[100],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showSampleAnswer() {
    final sample = level == 1
        ? widget.test.sampleTask1
        : widget.test.sampleTask2;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Sample Answer",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    sample ?? "No sample answer available.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Band Score",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    band,
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  color: Color(0xFF4F46E5),
                  size: 32,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Text(
            "Task 2: Essay Writing",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(
                0xFF1F2937,
              ), // Assuming textColor is this value or similar
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feedback,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF4B5563),
            ),
          ),
          if (misspellings.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              "Spelling Corrections",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: misspellings.entries.map((e) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${e.key} ",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFDC2626),
                            decoration: TextDecoration.lineThrough,
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: "→ ${e.value}",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF16A34A),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

