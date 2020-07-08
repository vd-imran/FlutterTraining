library randomutils;

import 'dart:math';

Random _random = new Random();

/// A Calculator.
class Utils {
  static int randomColor() {
    var hex = "0xFF";
    for (int i = 0; i < 3; i++) {
      hex += _random.nextInt(255).toRadixString(16).padLeft(2, '0');
    }
    return int.parse(hex);
  }

  static String randomString({int length}) {
    var codeUnits =
        new List.generate(length ?? _random.nextInt(pow(2, 10)), (index) {
      return _random.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }
}
