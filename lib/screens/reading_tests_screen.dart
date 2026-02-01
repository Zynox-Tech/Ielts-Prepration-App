import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/constants/reading_test_data.dart';
import 'package:ielts/models/reading_test_model.dart';
import 'package:ielts/screens/reading_test_screen.dart';

class ReadingTestsScreen extends StatefulWidget {
  const ReadingTestsScreen({super.key});

  @override
  State<ReadingTestsScreen> createState() => _ReadingTestsScreenState();
}

class _ReadingTestsScreenState extends State<ReadingTestsScreen> {
  bool isLoading = true;
  Map<String, dynamic> completedTests = {};

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('reading_results')
          .get();

      Map<String, dynamic> results = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final testId = data['testId'];
        final score = data['score'];
        if (!results.containsKey(testId) || score > (results[testId] ?? 0)) {
          results[testId] = score;
        }
      }

      setState(() {
        completedTests = results;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading results: \$e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allTests = ReadingTestData.tests;

    final easyTests = allTests
        .where((test) => test.difficulty == 'Easy')
        .toList();
    final mediumTests = allTests
        .where((test) => test.difficulty == 'Medium')
        .toList();
    final hardTests = allTests
        .where((test) => test.difficulty == 'Hard')
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reading Tests',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: const Color(0xFFF97316),
            labelColor: const Color(0xFFF97316),
            tabs: const [
              Tab(text: 'Easy'),
              Tab(text: 'Medium'),
              Tab(text: 'Hard'),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildTestList(context, easyTests, isDark),
                  _buildTestList(context, mediumTests, isDark),
                  _buildTestList(context, hardTests, isDark),
                ],
              ),
      ),
    );
  }

  Widget _buildTestList(
    BuildContext context,
    List<ReadingTestModel> tests,
    bool isDark,
  ) {
    final textColor = isDark
        ? Colors.white
        : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    if (tests.isEmpty) {
      return Center(
        child: Text(
          'No tests available in this category.',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final test = tests[index];
          final isCompleted = completedTests.containsKey(test.id);
          final score = completedTests[test.id];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: isDark ? 0 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingTestScreen(test: test),
                  ),
                );
                _loadResults();
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF7C2D12)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.book,
                            color: Color(0xFFF97316),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${test.questions.length} questions',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: textColor.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(
                                        test.difficulty,
                                        isDark,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      test.difficulty,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: _getDifficultyColor(
                                          test.difficulty,
                                          isDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${(score * 100).toInt()}%',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getDifficultyColor(String difficulty, bool isDark) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
