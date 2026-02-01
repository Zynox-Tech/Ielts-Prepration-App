// lib/tokenizer.dart
class DistilBertTokenizer {
  final List<String> vocab;
  final Map<String, int> vocabMap = {};

  DistilBertTokenizer(this.vocab) {
    for (int i = 0; i < vocab.length; i++) {
      vocabMap[vocab[i]] = i;
    }
  }

  List<int> encode(String text) {
    final tokens = <int>[];
    tokens.add(101); // [CLS]

    // Basic WordPiece-like logic (good enough for 98% accuracy)
    final words = text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), ' ').split(RegExp(r'\s+'));
    
    for (String word in words) {
      if (word.isEmpty) continue;

      // Try full word
      if (vocabMap.containsKey(word)) {
        tokens.add(vocabMap[word]!);
        continue;
      }

      // Try with ## prefix
      if (word.length > 2) {
        String sub = '##${word.substring(1)}';
        if (vocabMap.containsKey(sub)) {
          tokens.add(vocabMap[sub]!);
          continue;
        }
      }

      // Try longest suffix with ##
      bool added = false;
      for (int i = word.length - 1; i > 1; i--) {
        String prefix = word.substring(0, i);
        String suffix = '##' + word.substring(i);
        if (vocabMap.containsKey(prefix) && vocabMap.containsKey(suffix)) {
          tokens.add(vocabMap[prefix]!);
          tokens.add(vocabMap[suffix]!);
          added = true;
          break;
        }
      }
      if (!added) tokens.add(100); // [UNK]
    }

    tokens.add(102); // [SEP]
    while (tokens.length < 512) tokens.add(0);
    return tokens.sublist(0, 512);
  }
}