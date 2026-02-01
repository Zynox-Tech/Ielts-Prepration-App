import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/models/test_result_model.dart';
import 'package:ielts/models/writing_test_model.dart';
import 'package:ielts/screens/writing_result_screen.dart';
import 'package:ielts/screens/writing_screen.dart';

class WritingTestController extends GetxController {
  var tests = <WritingTestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTests();
  }

  Future<void> loadTests() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Fetch results from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('writing_results')
        .get();

    final results = snapshot.docs.map((doc) => doc.data()).toList();

    // Define fixed 6 tests
    final List<Map<String, String>> testData = [
      {
        "id": "test1",
        "pictureUrl":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80",
        "statement":
            "Some people believe that unpaid community service should be a compulsory part of high school programmes. To what extent do you agree or disagree?",
        "sampleTask1":
            "The image depicts a serene landscape with a calm lake reflecting the surrounding mountains and trees. The composition suggests a peaceful environment, possibly in a national park. The lighting indicates it is either early morning or late afternoon, casting soft shadows and highlighting the textures of the natural elements.",
        "sampleTask2":
            "The debate over whether unpaid community service should be mandatory for high school students is a contentious one. Proponents argue that it instills a sense of civic duty and provides valuable life skills. Opponents, however, believe it adds unnecessary pressure to an already demanding academic schedule. In my opinion, while the benefits are significant, it should remain optional to respect students' individual circumstances.",
      },
      {
        "id": "test2",
        "pictureUrl":
            "https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d?auto=format&fit=crop&w=400&q=80",
        "statement":
            "In many countries, the gap between rich and poor people is widening. What problems can this cause and what measures could be taken to reduce it?",
        "sampleTask1":
            "The photograph shows a bustling city street, likely in a developing country. The contrast between modern high-rise buildings in the background and older, more dilapidated structures in the foreground highlights the economic disparities present in urban environments. The street is crowded with people and vehicles, suggesting a high population density.",
        "sampleTask2":
            "The widening gap between the rich and the poor is a pressing issue in many nations. This disparity can lead to social unrest, increased crime rates, and a lack of access to essential services for the underprivileged. To mitigate these problems, governments could implement progressive taxation systems, invest in quality education for all, and create job opportunities in underdeveloped regions.",
      },
      {
        "id": "test3",
        "pictureUrl":
            "https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=400&q=80",
        "statement":
            "Some people think that the best way to improve road safety is to increase the minimum legal age for driving cars or riding motorbikes. To what extent do you agree or disagree?",
        "sampleTask1":
            "This image captures a laptop on a wooden desk, symbolizing modern work or study environments. The focus is on the keyboard and screen, suggesting productivity and digital connectivity. The blurred background emphasizes the subject, indicating a distraction-free setting suitable for concentration.",
        "sampleTask2":
            "Improving road safety is a critical goal for any society. While raising the minimum driving age could potentially reduce accidents involving young, inexperienced drivers, I believe it is not the only or best solution. Comprehensive driver education, stricter enforcement of traffic laws, and improved road infrastructure are equally, if not more, effective measures.",
      },
      {
        "id": "test4",
        "pictureUrl":
            "https://images.unsplash.com/photo-1473187983305-f615310e7daa?auto=format&fit=crop&w=400&q=80",
        "statement":
            "In the future, it seems it will be more difficult to live on Earth. Some people think that more money should be spent on researching other planets to live on. Do you agree or disagree?",
        "sampleTask1":
            "The picture illustrates a scenic view of a coastline at sunset. The warm colors of the sky blend with the cool tones of the ocean, creating a harmonious and visually appealing scene. The silhouette of the land against the bright horizon adds depth and interest to the composition.",
        "sampleTask2":
            "As Earth faces increasing environmental challenges, the idea of colonizing other planets gains traction. However, I disagree that more money should be diverted to space research at the expense of solving problems on Earth. Investing in sustainable technologies and conservation efforts here is a more immediate and practical priority than seeking a new home in space.",
      },
      {
        "id": "test5",
        "pictureUrl":
            "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=400&q=80",
        "statement":
            "Some people think it is better to build new houses in existing cities rather than building new towns in rural areas. Do the advantages outweigh the disadvantages?",
        "sampleTask1":
            "The image shows a lone hiker walking through a dense forest. The tall trees and dappled sunlight create a sense of isolation and adventure. The path ahead is unclear, symbolizing the journey into the unknown and the beauty of exploring nature.",
        "sampleTask2":
            "Urban expansion is a significant challenge for planners. Building new houses within existing cities maximizes the use of established infrastructure but can lead to overcrowding. Conversely, developing new towns in rural areas preserves urban green spaces but requires massive investment in new services. On balance, I believe the advantages of densifying existing cities outweigh the disadvantages, provided it is managed sustainably.",
      },
      {
        "id": "test6",
        "pictureUrl":
            "https://images.unsplash.com/photo-1508780709619-79562169bc64?auto=format&fit=crop&w=400&q=80",
        "statement":
            "Many people believe that it is important to protect the environment, but they make no effort to do so. Why is this and what can be done about it?",
        "sampleTask1":
            "The photo displays a modern architectural structure with glass facades reflecting the sky. The geometric lines and clean surfaces represent contemporary design principles. The building stands out against the blue sky, suggesting innovation and progress in urban development.",
        "sampleTask2":
            "Despite widespread awareness of environmental issues, individual action often lags behind. This disconnect is frequently due to a feeling of insignificance or the inconvenience of sustainable practices. To bridge this gap, education campaigns should emphasize the collective impact of small actions, and governments should incentivize eco-friendly behaviors to make them more accessible and appealing.",
      },
    ];

    List<WritingTestModel> dummyTests = testData.map((data) {
      return WritingTestModel(
        id: data["id"]!,
        pictureUrl: data["pictureUrl"]!,
        statement: data["statement"]!,
        pictureTest: TestResultModel(
          correctWordsLength: 0,
          incorrectWordsLength: 0,
          grammarErrorsLength: 0,
          band: "",
          misSpelling: {},
          feedback: "",
          essay: '',
          wordCount: 0,
        ),
        statementTest: TestResultModel(
          correctWordsLength: 0,
          incorrectWordsLength: 0,
          grammarErrorsLength: 0,
          band: "",
          misSpelling: {},
          feedback: "",
          essay: '',
          wordCount: 0,
        ),
        totalBand: 0.0,
        sampleTask1: data["sampleTask1"],
        sampleTask2: data["sampleTask2"],
        isTestDone: false,
      );
    }).toList();

    tests.clear();

    for (var test in dummyTests) {
      final pictureResultMap = results.firstWhereOrNull(
        (r) => r['testId'] == test.id && r['taskType'] == 'picture',
      );
      final essayResultMap = results.firstWhereOrNull(
        (r) => r['testId'] == test.id && r['taskType'] == 'essay',
      );

      TestResultModel pictureTest = pictureResultMap != null
          ? TestResultModel.fromMap(pictureResultMap)
          : TestResultModel(
              correctWordsLength: 0,
              incorrectWordsLength: 0,
              grammarErrorsLength: 0,
              band: "",
              misSpelling: {},
              feedback: "",
              essay: '',
              wordCount: 0,
            );

      TestResultModel statementTest = essayResultMap != null
          ? TestResultModel.fromMap(essayResultMap)
          : TestResultModel(
              correctWordsLength: 0,
              incorrectWordsLength: 0,
              grammarErrorsLength: 0,
              band: "",
              misSpelling: {},
              feedback: "",
              essay: '',
              wordCount: 0,
            );

      bool isDone = pictureResultMap != null && essayResultMap != null;

      final totalBand =
          ((double.tryParse(pictureTest.band) ?? 0.0) +
              (double.tryParse(statementTest.band) ?? 0.0)) /
          2;

      tests.add(
        WritingTestModel(
          id: test.id,
          pictureUrl: test.pictureUrl,
          statement: test.statement,
          pictureTest: pictureTest,
          statementTest: statementTest,
          totalBand: totalBand,
          isTestDone: isDone,
          sampleTask1: test.sampleTask1,
          sampleTask2: test.sampleTask2,
        ),
      );
    }
  }
}

// ---- Screen ----
class WritingTestsScreen extends StatelessWidget {
  final WritingTestController controller = Get.put(WritingTestController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? Colors.white
        : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(title: Text("Writing Tests"), elevation: 0),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.tests.length,
              itemBuilder: (context, index) {
                final test = controller.tests[index];
                return Card(
                  elevation: isDark ? 0 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 18),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                test.pictureUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Test ${index + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    test.statement,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  if (test.pictureTest.band.isEmpty) {
                                    Get.to(
                                      () => WritingScreen(test: test, level: 1),
                                    );
                                  } else {
                                    // Show results for Task 1? Or allow retake?
                                    // For now, let's just go to results screen if done, or maybe just allow viewing result
                                    // But the current WritingResultsScreen shows both.
                                    // Let's just open WritingScreen for now, maybe it should show results if done.
                                    // Actually, the previous logic was: if isTestDone -> Results, else -> WritingScreen.
                                    // But now we have granular status.
                                    // Let's open WritingScreen, and inside WritingScreen we might want to handle "already done" state?
                                    // Or just let them practice again?
                                    // The requirement says "evaluation of that", implying practice.
                                    // Let's allow them to open WritingScreen.
                                    Get.to(
                                      () => WritingScreen(test: test, level: 1),
                                    );
                                  }
                                },
                                icon: Icon(
                                  test.pictureTest.band.isNotEmpty
                                      ? Icons.check_circle
                                      : Icons.edit,
                                  size: 16,
                                  color: test.pictureTest.band.isNotEmpty
                                      ? Colors.green
                                      : Colors.indigo,
                                ),
                                label: Text(
                                  test.pictureTest.band.isNotEmpty
                                      ? "Task 1 Done"
                                      : "Start Task 1",
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      test.pictureTest.band.isNotEmpty
                                      ? Colors.green
                                      : Colors.indigo,
                                  side: BorderSide(
                                    color: test.pictureTest.band.isNotEmpty
                                        ? Colors.green
                                        : Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Get.to(
                                    () => WritingScreen(test: test, level: 2),
                                  );
                                },
                                icon: Icon(
                                  test.statementTest.band.isNotEmpty
                                      ? Icons.check_circle
                                      : Icons.edit,
                                  size: 16,
                                  color: test.statementTest.band.isNotEmpty
                                      ? Colors.green
                                      : Colors.indigo,
                                ),
                                label: Text(
                                  test.statementTest.band.isNotEmpty
                                      ? "Task 2 Done"
                                      : "Start Task 2",
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      test.statementTest.band.isNotEmpty
                                      ? Colors.green
                                      : Colors.indigo,
                                  side: BorderSide(
                                    color: test.statementTest.band.isNotEmpty
                                        ? Colors.green
                                        : Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (test.isTestDone)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () => WritingResultsScreen(test: test),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("View Full Report"),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
