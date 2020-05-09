import 'dart:io';
import 'dart:math';

void main() {
  final file = File('file.txt');

  file.readAsString().then((String contents) {
    TextStats textStats = TextStats(contents);

    print('The following words have the highest word frequency per line:');

    textStats.lines.forEach((lineStats) {
      print(
          '${lineStats.mostFrequentWords} (appears in line ${lineStats.lineNo})');
    });
  }).catchError((e) {
    print(e);
  });
}

// Classes

class TextStats {
  List<LineStats> lines = [];
  int _maxFrequency;

  TextStats(String text) {
    _calculateStats(text);
  }

  // Helper

  void _calculateStats(String text) {
    int lineNo = 0;
    text.split('\n').forEach((line) {
      lines.add(LineStats(line: line, lineNo: ++lineNo));
    });

    _maxFrequency = lines.map((l) {
      return l.maxFrequency;
    }).reduce(max);

    lines.removeWhere((item) {
      return item.maxFrequency != _maxFrequency;
    });
  }
}

class LineStats {
  List<String> mostFrequentWords;
  int maxFrequency;
  int lineNo;

  LineStats({String line, int lineNo}) {
    _calculateStats(line);
    this.lineNo = lineNo;
  }

  // Helpers

  void _calculateStats(String line) {
    final wordsMap = _calculateWordFrequency(line);
    final maxFreq = wordsMap.values.reduce(max);

    wordsMap.removeWhere((key, value) {
      return value != maxFreq;
    });

    mostFrequentWords = List.from(wordsMap.keys);
    maxFrequency = maxFreq;
  }

  Map<String, int> _calculateWordFrequency(String line) {
    Map<String, int> map = Map();

    line.toLowerCase().split(' ').forEach((word) {
      (map[word] == null) ? map[word] = 1 : map[word] += 1;
    });

    return map;
  }
}
