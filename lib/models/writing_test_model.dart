import 'package:ielts/models/test_result_model.dart';

class WritingTestModel {
  String id;
  String pictureUrl;
  String statement;
  TestResultModel pictureTest;
  TestResultModel statementTest;
  double totalBand;
  bool isTestDone;
  String? sampleTask1;
  String? sampleTask2;

  WritingTestModel({
    required this.id,
    required this.pictureUrl,
    required this.statement,
    required this.pictureTest,
    required this.statementTest,
    required this.totalBand,
    required this.isTestDone,
    this.sampleTask1,
    this.sampleTask2,
  });

  /// Factory to create from Map
  factory WritingTestModel.fromMap(Map<String, dynamic> map) {
    return WritingTestModel(
      id: map['id']?.toString() ?? '',
      pictureUrl: map['pictureUrl']?.toString() ?? '',
      statement: map['statement']?.toString() ?? '',
      pictureTest: map['pictureTest'] != null
          ? TestResultModel.fromMap(map['pictureTest'])
          : TestResultModel(
              correctWordsLength: 0,
              incorrectWordsLength: 0,
              grammarErrorsLength: 0,
              band: '',
              misSpelling: {},
              feedback: '',
              essay: '',
              wordCount: 0,
            ),
      statementTest: map['statementTest'] != null
          ? TestResultModel.fromMap(map['statementTest'])
          : TestResultModel(
              correctWordsLength: 0,
              incorrectWordsLength: 0,
              grammarErrorsLength: 0,
              band: '',
              misSpelling: {},
              feedback: '',
              essay: '',
              wordCount: 0,
            ),
      totalBand: double.tryParse(map['totalBand']?.toString() ?? '0.0') ?? 0.0,
      isTestDone:
          map['isTestDone'] == true || map['isTestDone']?.toString() == 'true',
      sampleTask1: map['sampleTask1']?.toString(),
      sampleTask2: map['sampleTask2']?.toString(),
    );
  }

  /// Convert back to Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "pictureUrl": pictureUrl,
      "statement": statement,
      "pictureTest": pictureTest.toMap(),
      "statementTest": statementTest.toMap(),
      "totalBand": totalBand,
      "isTestDone": isTestDone,
      "sampleTask1": sampleTask1,
      "sampleTask2": sampleTask2,
    };
  }
}
