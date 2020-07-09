import 'package:randomutils/randomutils.dart';

void main() async {
  print('Random String of length 5: ' + Utils.randomString(length: 5));
  print('Random String of random length: ' + Utils.randomString());
  print(
    'Clean up whitespace: ' +
        Utils.condenseWhiteSpace('    this      is   an example!    '),
  ); // Prints: this is an example!

  print(
    'Remove whitespace: ' + Utils.removeWhiteSpace(' 1    2    3   4 5 67'),
  ); // Prints: 1234567

  print(
    'Check empty string: ${Utils.isWhiteSpaceOrEmptyOrNull('   ')}',
  ); // Prints: true

  print(
    'Check empty string: ${Utils.isWhiteSpaceOrEmptyOrNull('')}',
  ); // Prints: true

  print(
    'Check empty string: ${Utils.isWhiteSpaceOrEmptyOrNull(null)}',
  ); // Prints: true

  print(
    'Extract digits: ${Utils.removeNonDigits('abc1d23    %3# 459./')}',
  ); // Prints: 1233459
}
