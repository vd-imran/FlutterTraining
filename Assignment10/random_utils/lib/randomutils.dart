library randomutils;

import 'dart:math';

Random _random = Random();

/// Provides useful utility functions.
class Utils {
  /// Generates a random integer that represents a Hex color.
  static int randomColor() {
    var hex = "0xFF";
    for (int i = 0; i < 3; i++) {
      hex += _random.nextInt(255).toRadixString(16).padLeft(2, '0');
    }
    return int.parse(hex);
  }

  /// Generates a random string of provided or random length.
  static String randomString({int length}) {
    var codeUnits =
        List.generate(length ?? _random.nextInt(pow(2, 10)), (index) {
      return _random.nextInt(33) + 89;
    });

    return String.fromCharCodes(codeUnits);
  }

  /// Cleans up provided string by removing extra whitespace.
  static String condenseWhiteSpace(String str) {
    return str.replaceAll(RegExp(r"\s+"), " ").trim();
  }

  /// Removes all whitespace from provided string.
  static String removeWhiteSpace(String str) {
    return str.replaceAll(RegExp(r"\s+"), "");
  }

  /// Returns true for for all strings that are empty, null or only whitespace.
  static bool isWhiteSpaceOrEmptyOrNull(String str) {
    return removeWhiteSpace(str ?? "").isEmpty;
  }

  /// Extracts decimal numbers from the provided string.
  static String removeNonDigits(String str) {
    return str.replaceAll(RegExp(r"\D"), "");
  }
}
