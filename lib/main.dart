import 'package:flutter/material.dart';

import 'src/translator_page.dart';

void main() {
  runApp(const BinaryTranslatorApp());
}

class BinaryTranslatorApp extends StatelessWidget {
  const BinaryTranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Colors.indigo;
    return MaterialApp(
      title: 'Binary Translator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: seed),
      darkTheme: ThemeData(colorSchemeSeed: seed, brightness: Brightness.dark),
      home: const TranslatorPage(),
    );
  }
}
