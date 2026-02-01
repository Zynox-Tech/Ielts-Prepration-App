import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import '../utils/roberta_tokenizer.dart';

class WritingModelTestController extends GetxController {
  final questionController = TextEditingController();
  final essayController = TextEditingController();

  final RxString result = ''.obs;
  final RxBool loading = false.obs;
  final RxString selectedTask = 'Task 2'.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedQuestion = 'Custom'.obs;
  final RxBool isCustomQuestion = true.obs;

  final List<String> questions = [
    'Some people believe that technology has made our lives more complicated, while others think it has made our lives easier. Discuss both views and give your own opinion.',
    'In many countries, the amount of crime is increasing. What do you think are the main causes of crime? How can we deal with those causes?',
    'Some people think that it is better to educate boys and girls in separate schools. Others, however, believe that boys and girls benefit more from attending mixed schools. Discuss both these views and give your own opinion.',
    'Custom',
  ];

  dynamic _session;
  final _tokenizer = RobertaTokenizer();

  @override
  void onInit() {
    super.onInit();
    _loadModel();
    // Default to first question
    updateQuestion(questions[0]);
  }

  @override
  void onClose() {
    // Session release is handled by the plugin or GC, but check if explicit release is needed
    // _session?.release();
    questionController.dispose();
    essayController.dispose();
    super.onClose();
  }

  void updateQuestion(String? newValue) {
    if (newValue == null) return;
    selectedQuestion.value = newValue;
    if (newValue == 'Custom') {
      isCustomQuestion.value = true;
      questionController.clear();
    } else {
      isCustomQuestion.value = false;
      questionController.text = newValue;
    }
  }

  Future<void> _loadModel() async {
    try {
      // Load tokenizer
      await _tokenizer.load();

      // Load model
      // flutter_onnxruntime loads directly from assets
      const assetFileName = 'assets/model/model_quantized.onnx';
      _session = await OnnxRuntime().createSessionFromAsset(assetFileName);
    } catch (e) {
      errorMessage.value = 'Failed to load model: $e';
      debugPrint('Error loading model: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> predict() async {
    if (_session == null) {
      if (errorMessage.isNotEmpty) {
        // Get.snackbar('Error', errorMessage.value);
      } else {
        // Get.snackbar('Error', 'Model not loaded yet');
      }
      return;
    }

    loading.value = true;

    try {
      final ids = _tokenizer.encode(essayController.text);
      final paddedIds = _tokenizer.pad(ids, 512);
      final maskData = List.filled(
        512,
        1,
      ); // Attention mask (1 for real tokens, 0 for padding)

      // Update mask: 0 for padding tokens
      for (int i = ids.length; i < 512; i++) {
        maskData[i] = 0;
      }

      // Create inputs
      // Note: Check model input names. Usually 'input_ids' and 'attention_mask'
      // flutter_onnxruntime uses OrtValue

      // Convert to Int64List for int64 tensor type
      final inputIdsValue = await OrtValue.fromList(
        Int64List.fromList(paddedIds),
        [1, 512],
      );
      final attentionMaskValue = await OrtValue.fromList(
        Int64List.fromList(maskData),
        [1, 512],
      );

      final inputs = {
        'input_ids': inputIdsValue,
        'attention_mask': attentionMaskValue,
      };

      final outputs = await _session!.run(inputs);

      if (outputs.isEmpty) throw Exception("No output from model");

      final outputValue = outputs.values.first;
      if (outputValue == null) throw Exception("Output value is null");

      // Convert output to list using asList() method
      final rawScores = await outputValue.asList();

      // Flatten if needed, or extract the first batch
      final List<double> scores;
      if (rawScores.isNotEmpty && rawScores[0] is List) {
        scores = (rawScores[0] as List).cast<double>();
      } else {
        scores = rawScores.cast<double>();
      }

      final labels = [
        'Task Response',
        'Coherence & Cohesion',
        'Lexical Resource',
        'Grammatical Range',
        'Overall',
      ];

      result.value = labels
          .asMap()
          .entries
          .map((e) {
            if (e.key < scores.length) {
              final band = (scores[e.key] * 2).round() / 2;
              print((scores[e.key] * 3.0).round());
              return '${e.value}: ${band.toStringAsFixed(1)}';
            }
            return '${e.value}: N/A';
          })
          .join('\n');
    } catch (e) {
      // Get.snackbar('Error', 'Prediction failed: $e');
      errorMessage.value = 'Prediction failed: $e';
      debugPrint('Prediction error: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> retryLoadModel() async {
    errorMessage.value = '';
    loading.value = true;
    await _loadModel();
  }

  void updateTaskType(String type) {
    selectedTask.value = type;
  }
}
