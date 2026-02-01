import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/controllers/writing_test_controller.dart';

class ScoringScreen extends StatelessWidget {
  const ScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WritingModelTestController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('IELTS Writing Scorer'), elevation: 0),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Model',
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.errorMessage.value,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: controller.retryLoadModel,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Task Type Selection
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.assignment, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Task Type:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'Task 1', label: Text('Task 1')),
                          ButtonSegment(value: 'Task 2', label: Text('Task 2')),
                        ],
                        selected: {controller.selectedTask.value},
                        onSelectionChanged: (Set<String> selected) {
                          controller.updateTaskType(selected.first);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Question Section
              Text(
                'Writing Question',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                color: isDark ? Colors.grey[850] : Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedQuestion.value,
                          isExpanded: true,
                          hint: const Text('Select a question'),
                          items: controller.questions.map((String question) {
                            return DropdownMenuItem<String>(
                              value: question,
                              child: Text(
                                question,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: controller.updateQuestion,
                        ),
                      ),
                      if (controller.isCustomQuestion.value) ...[
                        const Divider(height: 24),
                        TextField(
                          controller: controller.questionController,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your custom question here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: isDark ? Colors.grey[800] : Colors.white,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Essay Section
              Row(
                children: [
                  Text(
                    'Your Essay',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: controller.essayController,
                    builder: (context, TextEditingValue value, __) {
                      return Text(
                        '${value.text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length} words',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller.essayController,
                    maxLines: 12,
                    decoration: InputDecoration(
                      hintText:
                          'Write your essay here...\n\nMinimum 250 words for Task 2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[850] : Colors.grey[50],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Score Button
              ElevatedButton.icon(
                onPressed: controller.loading.value ? null : controller.predict,
                icon: controller.loading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.assessment),
                label: Text(
                  controller.loading.value
                      ? 'Analyzing Essay...'
                      : 'Score My Essay',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Results Section
              if (controller.result.value.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your IELTS Scores',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 4,
                      color: isDark ? Colors.grey[850] : Colors.green[50],
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: Colors.amber[700],
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Band Scores',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Text(
                              controller.result.value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
