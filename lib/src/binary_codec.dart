import 'dart:convert';

/// Thrown when a binary string cannot be decoded back to text.
class BinaryFormatException implements Exception {
  const BinaryFormatException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Encodes [text] as space-separated 8-bit groups, one per UTF-8 byte.
///
/// UTF-8 (rather than UTF-16 code units) keeps every group exactly one byte
/// wide, so accented letters and emoji round-trip through [binaryToText].
String textToBinary(String text) {
  return utf8
      .encode(text)
      .map((byte) => byte.toRadixString(2).padLeft(8, '0'))
      .join(' ');
}

/// Decodes the output of [textToBinary] back to text.
///
/// Throws [BinaryFormatException] when [binary] is not valid input.
String binaryToText(String binary) {
  // TODO(human): parse the 8-bit groups into bytes and decode them as UTF-8.
  throw UnimplementedError();
}
