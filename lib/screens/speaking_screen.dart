import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

const String GEMINI_API_KEY = 'AIzaSyCsW57g5BA_3nrsiaIJKnSMhQ131s0LY58';

final List<String> ieltsTopics = [
  "Describe a memorable holiday you have had.",
  "Talk about a book you recently read.",
  "Describe a person who has influenced you.",
  "Discuss a challenge you faced and how you overcame it.",
  "Talk about your favorite hobby.",
  "Describe a piece of art you like.",
  "Talk about a goal you want to achieve.",
  "Describe a traditional meal from your country.",
];

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<SpeakingScreen> {
  // Audio recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _audioPath;
  bool isRecording = false;
  bool isTranscribing = false;

  // Timing
  DateTime? startTime;
  Duration recordingDuration = Duration.zero;
  Timer? _timer;

  // Results
  List<Map<String, dynamic>> pastResults = [];
  Map<String, dynamic>? latestResult;
  String? selectedTopic;

  @override
  void initState() {
    super.initState();
    _loadPastResults();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _loadPastResults() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList("speaking_results") ?? [];
    setState(() {
      pastResults = saved
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
      if (pastResults.isNotEmpty) latestResult = pastResults.first;
    });
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<void> _startRecording() async {
    if (selectedTopic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a topic first')),
      );
      return;
    }

    await _requestPermissions();

    if (await _audioRecorder.hasPermission()) {
      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/speaking_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );

      setState(() {
        isRecording = true;
        _audioPath = path;
        startTime = DateTime.now();
        recordingDuration = Duration.zero;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isRecording) {
          setState(() {
            recordingDuration = Duration(seconds: timer.tick);
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission required')),
      );
    }
  }

  Future<void> _stopRecording() async {
    if (!isRecording) return;

    _timer?.cancel();
    _timer = null;

    final path = await _audioRecorder.stop();

    setState(() {
      isRecording = false;
    });

    if (path != null) {
      setState(() => isTranscribing = true);

      try {
        // Analyze audio directly with Gemini
        await _analyzeAudioWithGemini(path);
      } catch (e) {
        print('Analysis error: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to analyze audio: $e')));
        setState(() => isTranscribing = false);
      } finally {
        // Clean up audio file
        try {
          File(path).deleteSync();
        } catch (e) {
          print('Failed to delete audio file: $e');
        }
      }
    }
  }

  Future<void> _analyzeAudioWithGemini(String audioPath) async {
    final file = File(audioPath);
    if (!file.existsSync()) {
      throw Exception('Audio file not found');
    }

    final audioBytes = await file.readAsBytes();
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: GEMINI_API_KEY,
    );

    final prompt =
        '''
You are an IELTS Speaking examiner. Analyze the attached audio recording for the topic: "$selectedTopic".

Return a VALID JSON object with the following fields:
{
  "transcript": "The exact transcription of what was said.",
  "band": "The estimated IELTS band score (0-9.0).",
  "fluency_score": "A score from 0-100 for fluency.",
  "pronunciation_score": "A score from 0-100 for pronunciation.",
  "grammar_score": "A score from 0-100 for grammatical range and accuracy.",
  "vocabulary_score": "A score from 0-100 for lexical resource.",
  "feedback": "A concise paragraph giving feedback on strengths and weaknesses.",
  "corrected_text": "A corrected version of the transcript with better grammar and vocabulary.",
  "grammar_errors": [
    {"original": "mistake", "correction": "correction", "explanation": "why it is wrong"}
  ]
}
''';

    final content = [
      Content.multi([TextPart(prompt), DataPart('audio/m4a', audioBytes)]),
    ];

    final response = await model.generateContent(content);
    final text = response.text;

    if (text == null) throw Exception("Empty response from Gemini");

    final jsonResult = _extractJson(text);
    if (jsonResult == null) throw Exception("Failed to parse JSON response");

    setState(() => isTranscribing = false);

    // Navigate to results
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsScreen(
          result: jsonResult,
          topic: selectedTopic!,
          onSave: _saveResult,
        ),
      ),
    );
  }

  Map<String, dynamic>? _extractJson(String input) {
    try {
      final start = input.indexOf("{");
      final end = input.lastIndexOf("}");
      if (start != -1 && end != -1) {
        final jsonStr = input.substring(start, end + 1);
        return jsonDecode(jsonStr) as Map<String, dynamic>;
      }
    } catch (e) {
      print("JSON Parse Error: $e");
    }
    return null;
  }

  Future<void> _saveResult(Map<String, dynamic> result) async {
    final user = FirebaseAuth.instance.currentUser;

    // Save locally first
    final prefs = await SharedPreferences.getInstance();
    final resultToSave = {
      ...result,
      'date': DateTime.now().toIso8601String(),
      'topic': selectedTopic,
    };

    pastResults.insert(0, resultToSave);
    latestResult = resultToSave;
    await prefs.setStringList(
      "speaking_results",
      pastResults.map((e) => jsonEncode(e)).toList(),
    );
    setState(() {});

    if (user == null) return;

    try {
      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('speaking_results')
          .add({...resultToSave, 'timestamp': FieldValue.serverTimestamp()});

      // Update aggregate stats
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userDoc);
        if (!snapshot.exists) return;

        final data = snapshot.data() as Map<String, dynamic>;
        final currentScores = Map<String, dynamic>.from(data['scores'] ?? {});

        double newBand = double.tryParse(result['band'].toString()) ?? 0.0;
        currentScores['Speaking'] = newBand;

        transaction.update(userDoc, {'scores': currentScores});
      });
    } catch (e) {
      print("Error saving result to Firestore: $e");
    }
  }

  void _selectTopic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Select a Topic",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ieltsTopics.length,
            itemBuilder: (context, index) {
              final topic = ieltsTopics[index];
              return ListTile(
                title: Text(topic, style: GoogleFonts.poppins()),
                onTap: () {
                  setState(() {
                    selectedTopic = topic;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "IELTS Speaking",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: isTranscribing
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    "Analyzing your speech...",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopicCard(isDark, textColor),
                  const SizedBox(height: 32),
                  _buildRecordingArea(isDark, textColor),
                  const SizedBox(height: 32),
                  if (latestResult != null)
                    _buildLastResultCard(isDark, textColor),
                ],
              ),
            ),
    );
  }

  Widget _buildTopicCard(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Current Topic",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: textColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            selectedTopic ?? "No topic selected",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _selectTopic,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Change Topic",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingArea(bool isDark, Color textColor) {
    return Column(
      children: [
        GestureDetector(
          onTap: isRecording ? _stopRecording : _startRecording,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: isRecording
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF4F46E5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:
                      (isRecording
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF4F46E5))
                          .withOpacity(0.4),
                  blurRadius: isRecording ? 40 : 20,
                  spreadRadius: isRecording ? 10 : 0,
                ),
              ],
            ),
            child: Icon(
              isRecording ? Icons.stop_rounded : Icons.mic_rounded,
              size: 56,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          isRecording ? "Recording..." : "Tap to Record",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        if (isRecording) ...[
          const SizedBox(height: 8),
          Text(
            "${recordingDuration.inMinutes}:${(recordingDuration.inSeconds % 60).toString().padLeft(2, '0')}",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFFEF4444),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLastResultCard(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last Result",
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Band ${latestResult!['band']}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4F46E5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            latestResult!['transcript'] ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: textColor.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////RESULT SCREEN/////////////////////////
class ResultsScreen extends StatefulWidget {
  final Map<String, dynamic> result;
  final String topic;
  final Function(Map<String, dynamic>) onSave;

  const ResultsScreen({
    super.key,
    required this.result,
    required this.topic,
    required this.onSave,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late FlutterTts _flutterTts;
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    // Save result on load
    widget.onSave(widget.result);
  }

  void _initTts() {
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("en-US");
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setCompletionHandler(() {
      setState(() => isSpeaking = false);
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _speakFeedback() async {
    if (isSpeaking) {
      await _flutterTts.stop();
      setState(() => isSpeaking = false);
    } else {
      setState(() => isSpeaking = true);
      await _flutterTts.speak(widget.result['feedback'] ?? "");
    }
  }

  Future<void> _speak(String text) async {
    if (isSpeaking) {
      await _flutterTts.stop();
      setState(() => isSpeaking = false);
    } else {
      setState(() => isSpeaking = true);
      await _flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis Result",
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
            _buildScoreCard(isDark, textColor),
            const SizedBox(height: 24),
            _buildMetricsGrid(isDark, textColor),
            const SizedBox(height: 24),
            _buildExpandableSection(
              context,
              "Transcript",
              widget.result['transcript'] ?? "",
              Icons.record_voice_over,
              isDark,
              textColor,
            ),
            const SizedBox(height: 16),
            _buildExpandableSection(
              context,
              "Corrected Version",
              widget.result['corrected_text'] ?? "",
              Icons.auto_fix_high,
              isDark,
              textColor,
            ),
            const SizedBox(height: 16),
            _buildFeedbackSection(isDark, textColor),
            if (widget.result['grammar_errors'] != null &&
                (widget.result['grammar_errors'] as List).isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildGrammarErrorsSection(isDark, textColor),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _speakFeedback,
        icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
        label: Text(isSpeaking ? "Stop" : "Listen Feedback"),
        backgroundColor: const Color(0xFF4F46E5),
      ),
    );
  }

  Widget _buildScoreCard(bool isDark, Color textColor) {
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
            "Speaking Band Score",
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
              "${widget.result['band']}",
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

  Widget _buildMetricsGrid(bool isDark, Color textColor) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricItem(
            "Fluency",
            "${widget.result['fluency_score']}",
            Icons.speed,
            Colors.blue,
            isDark,
            textColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricItem(
            "Pronunciation",
            "${widget.result['pronunciation_score']}",
            Icons.record_voice_over,
            Colors.orange,
            isDark,
            textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricItem(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDark,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
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
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isSpeaking ? Icons.stop_circle : Icons.play_circle,
                color: const Color(0xFF4F46E5),
              ),
              onPressed: () => _speak(content),
              tooltip: isSpeaking ? 'Stop' : 'Listen',
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

  Widget _buildFeedbackSection(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7D2FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Color(0xFF4F46E5), size: 20),
              const SizedBox(width: 8),
              Text(
                "Examiner Feedback",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF312E81),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.result['feedback'] ?? "",
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF312E81),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrammarErrorsSection(bool isDark, Color textColor) {
    final errors = widget.result['grammar_errors'] as List;
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
                Icons.error_outline,
                size: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Grammar Improvements",
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
              children: errors.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_right, color: Colors.red),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e['original'] ?? "",
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              e['correction'] ?? "",
                              style: GoogleFonts.poppins(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (e['explanation'] != null)
                              Text(
                                e['explanation'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: textColor.withOpacity(0.6),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
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
