import 'package:binary_translator/src/binary_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('textToBinary', () {
    test('encodes ASCII as 8-bit groups', () {
      expect(textToBinary('Hi'), '01001000 01101001');
    });

    test('encodes non-ASCII as multiple UTF-8 bytes', () {
      expect(textToBinary('è'), '11000011 10101000');
    });

    test('returns empty string for empty input', () {
      expect(textToBinary(''), '');
    });
  });

  group('binaryToText', () {
    test('decodes 8-bit groups', () {
      expect(binaryToText('01001000 01101001'), 'Hi');
    });

    test('round-trips accents and emoji', () {
      const text = 'Forza Viola 💜 è così';
      expect(binaryToText(textToBinary(text)), text);
    });

    test('tolerates extra whitespace and newlines', () {
      expect(binaryToText('  01001000\n 01101001  '), 'Hi');
    });

    test('returns empty string for blank input', () {
      expect(binaryToText('   '), '');
    });

    test('rejects characters other than 0 and 1', () {
      expect(() => binaryToText('0100100a'),
          throwsA(isA<BinaryFormatException>()));
    });

    test('rejects groups that are not 8 bits long', () {
      expect(
          () => binaryToText('0100100'), throwsA(isA<BinaryFormatException>()));
    });

    test('rejects byte sequences that are not valid UTF-8', () {
      expect(() => binaryToText('11000011'),
          throwsA(isA<BinaryFormatException>()));
    });
  });
}
