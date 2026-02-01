import 'dart:convert';
import 'package:flutter/services.dart';

class RobertaTokenizer {
  Map<String, int> vocab = {};
  Map<int, String> decoder = {};
  Map<String, int> merges = {};

  // Special tokens
  static const String padToken = '<pad>';
  static const String unkToken = '<unk>';
  static const String bosToken = '<s>';
  static const String eosToken = '</s>';
  static const String maskToken = '<mask>';

  bool isLoaded = false;

  Future<void> load() async {
    try {
      // Load vocab
      final vocabString = await rootBundle.loadString(
        'assets/model/vocab.json',
      );
      final Map<String, dynamic> vocabJson = json.decode(vocabString);
      vocab = vocabJson.map((key, value) => MapEntry(key, value as int));
      decoder = vocab.map((key, value) => MapEntry(value, key));

      // Load merges
      final mergesString = await rootBundle.loadString(
        'assets/model/merges.txt',
      );
      final lines = const LineSplitter().convert(mergesString);

      // Skip version line if present
      final startIdx = lines.isNotEmpty && lines[0].startsWith('#') ? 1 : 0;

      for (var i = startIdx; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;
        // Merges are typically "token1 token2"
        // We'll store them as "token1 token2" -> rank (index)
        merges[line] = i - startIdx;
      }

      isLoaded = true;
    } catch (e) {
      print('Error loading tokenizer: $e');
      rethrow;
    }
  }

  List<int> encode(String text) {
    if (!isLoaded) {
      throw Exception('Tokenizer not loaded. Call load() first.');
    }

    // 1. Basic pre-tokenization (byte-level BPE simulation)
    // RoBERTa uses byte-level BPE. For simplicity in Dart without a full BPE lib,
    // we'll approximate the whitespace handling which is the most critical part.
    // In RoBERTa, spaces are replaced by Ġ (U+0120)

    // Add space prefix if it's the start of the sentence (RoBERTa usually treats start as having space unless it's special)
    // But standard RoBERTa tokenizers often don't add Ġ to the very first word if it doesn't have a space.
    // However, for consistency with python tokenizers, let's assume input text.

    // A simple approximation for RoBERTa tokenization:
    // 1. Replace spaces with Ġ
    // 2. Split by space (which are now Ġ) - wait, no.
    // RoBERTa treats the whole string as a sequence of bytes, then merges.

    // Let's implement a simplified BPE algorithm.

    // Step 1: Byte Encoder (Mapping characters to bytes/unicode safe chars)
    // For English text, we can mostly assume standard chars, but spaces -> Ġ

    String processedText = text.trim();
    if (processedText.isEmpty) return [];

    // Replace spaces with Ġ. Note: RoBERTa usually puts Ġ at the start of words.
    // Example: "Hello world" -> "Hello" "Ġworld"

    List<String> words = processedText.split(RegExp(r'\s+'));
    List<String> bpeTokens = [];

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (i > 0) {
        word = 'Ġ$word';
      }

      // Now apply BPE to this word
      bpeTokens.addAll(_bpe(word));
    }

    // Convert to IDs
    List<int> ids = [];
    ids.add(vocab[bosToken]!); // Start token

    for (var token in bpeTokens) {
      ids.add(vocab[token] ?? vocab[unkToken]!);
    }

    ids.add(vocab[eosToken]!); // End token

    return ids;
  }

  List<String> _bpe(String token) {
    // Split into characters
    List<String> word = token.split('');

    // Iteratively merge pairs
    while (word.length > 1) {
      int minRank = 999999999;
      int minIdx = -1;
      String? bestPair;

      // Find the best pair to merge
      for (int i = 0; i < word.length - 1; i++) {
        String pair = '${word[i]} ${word[i + 1]}';
        if (merges.containsKey(pair)) {
          int rank = merges[pair]!;
          if (rank < minRank) {
            minRank = rank;
            minIdx = i;
            bestPair = pair;
          }
        }
      }

      if (minIdx == -1) {
        break; // No more merges possible
      }

      // Merge
      String first = word[minIdx];
      String second = word[minIdx + 1];
      String merged = first + second;

      // Replace [minIdx, minIdx+1] with [merged]
      word.removeAt(minIdx + 1);
      word[minIdx] = merged;
    }

    return word;
  }

  List<int> pad(List<int> ids, int maxLength) {
    if (ids.length >= maxLength) {
      return ids.sublist(0, maxLength);
    }
    List<int> padded = List.from(ids);
    while (padded.length < maxLength) {
      padded.add(vocab[padToken]!);
    }
    return padded;
  }
}
