import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/models/writing_test_model.dart';
import 'package:ielts/models/test_result_model.dart';

class WritingResultsScreen extends StatelessWidget {
  final WritingTestModel test;
  const WritingResultsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${test.id.toUpperCase()} Results",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTotalScoreCard(context, isDark, textColor),
            const SizedBox(height: 24),
            if (test.isTestDone) ...[
              _buildTaskResultCard(
                context,
                "Task 1: Picture Description",
                test.pictureTest,
                test.pictureUrl,
                isDark,
                textColor,
                isImage: true,
              ),
              const SizedBox(height: 24),
              _buildTaskResultCard(
                context,
                "Task 2: Essay Writing",
                test.statementTest,
                test.statement,
                isDark,
                textColor,
                isImage: false,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTotalScoreCard(
    BuildContext context,
    bool isDark,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF312E81), const Color(0xFF4338CA)]
              : [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Overall Band Score",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Text(
              test.totalBand.toStringAsFixed(1),
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "/ 9.0",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskResultCard(
    BuildContext context,
    String title,
    TestResultModel result,
    String contentUrlOrText,
    bool isDark,
    Color textColor, {
    required bool isImage,
  }) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Band ${result.band}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (isImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      contentUrlOrText,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey.shade900
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      contentUrlOrText,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: textColor.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                _buildStatGrid(result, isDark, textColor),
                const SizedBox(height: 20),
                _buildExpandableSection(
                  context,
                  "Your Essay",
                  result.essay,
                  Icons.edit_note,
                  isDark,
                  textColor,
                ),
                const SizedBox(height: 12),
                _buildExpandableSection(
                  context,
                  "Feedback",
                  result.feedback,
                  Icons.feedback_outlined,
                  isDark,
                  textColor,
                ),
                if (result.misSpelling.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildMisspellingsSection(
                    context,
                    result.misSpelling,
                    isDark,
                    textColor,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid(TestResultModel result, bool isDark, Color textColor) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            "Words",
            "${result.wordCount}",
            Icons.text_fields,
            Colors.blue,
            isDark,
            textColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            "Grammar",
            "${result.grammarErrorsLength}",
            Icons.error_outline,
            Colors.orange,
            isDark,
            textColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            "Spelling",
            "${result.misSpelling.length}",
            Icons.spellcheck,
            Colors.red,
            isDark,
            textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDark,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    bool isDark,
    Color textColor,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: textColor),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              content,
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: textColor.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMisspellingsSection(
    BuildContext context,
    Map<String, dynamic> misspellings,
    bool isDark,
    Color textColor,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.highlight_off,
                size: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Misspellings",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: misspellings.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(color: Colors.red)),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: textColor.withOpacity(0.8),
                            ),
                            children: [
                              TextSpan(
                                text: "${e.key} ",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red,
                                ),
                              ),
                              const TextSpan(text: " → "),
                              TextSpan(
                                text: "${e.value}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
