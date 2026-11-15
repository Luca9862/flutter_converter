import 'package:binary_translator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('translates text to binary as the user types', (tester) async {
    await tester.pumpWidget(const BinaryTranslatorApp());

    await tester.enterText(find.byKey(const Key('input')), 'A');
    await tester.pump();

    expect(find.text('01000001'), findsOneWidget);
  });

  testWidgets('switching direction feeds the result back as input',
      (tester) async {
    await tester.pumpWidget(const BinaryTranslatorApp());

    await tester.enterText(find.byKey(const Key('input')), 'A');
    await tester.tap(find.text('Binary → Text'));
    await tester.pump();

    final input = tester.widget<TextField>(find.byKey(const Key('input')));
    expect(input.controller!.text, '01000001');
  });
}
