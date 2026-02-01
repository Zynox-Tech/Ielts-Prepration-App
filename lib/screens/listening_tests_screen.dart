import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/constants/listening_test_data.dart';
import 'package:ielts/models/listening_test_model.dart';
import 'package:ielts/screens/listening_test_screen.dart';

class ListeningTestsScreen extends StatefulWidget {
  const ListeningTestsScreen({super.key});

  @override
  State<ListeningTestsScreen> createState() => _ListeningTestsScreenState();
}

class _ListeningTestsScreenState extends State<ListeningTestsScreen> {
  final List<ListeningTestModel> tests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTests();
  }

  Future<void> _loadTests() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Fetch results from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('listening_results')
        .get();

    final results = snapshot.docs.map((doc) => doc.data()).toList();

    // Define sample tests
    final sampleTests = ListeningTestData.tests;

    tests.clear();
    for (var test in sampleTests) {
      final resultMap = results.firstWhereOrNull((r) => r['testId'] == test.id);

      if (resultMap != null) {
        test.isCompleted = true;
        test.score = resultMap['score']?.toDouble() ?? 0.0;
      }

      tests.add(test);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allTests = ListeningTestData.tests;

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
            'Listening Tests',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: const Color(0xFF4F46E5),
            labelColor: const Color(0xFF4F46E5),
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
    List<ListeningTestModel> tests,
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
          final isCompleted = test.isCompleted;
          final score = test.score;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ListeningTestScreen(test: test),
                  ),
                ).then((_) => _loadTests());
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.headphones,
                            color: Color(0xFF4F46E5),
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
                                    '${test.questions.length} questions • ${(test.duration / 60).toInt()} min',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
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
                        if (isCompleted) ...[
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
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
