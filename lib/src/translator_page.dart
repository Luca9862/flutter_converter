import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'binary_codec.dart';

enum Direction { textToBinary, binaryToText }

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final _input = TextEditingController();
  Direction _direction = Direction.textToBinary;

  @override
  void initState() {
    super.initState();
    _input.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  ({String output, String? error}) _translate() {
    try {
      final output = switch (_direction) {
        Direction.textToBinary => textToBinary(_input.text),
        Direction.binaryToText => binaryToText(_input.text),
      };
      return (output: output, error: null);
    } on BinaryFormatException catch (e) {
      return (output: '', error: e.message);
    }
  }

  // Swapping direction feeds the current result back as input, so the user
  // can check that a translation round-trips.
  void _changeDirection(Direction direction) {
    final result = _translate();
    setState(() {
      _direction = direction;
      if (result.error == null) _input.text = result.output;
    });
  }

  Future<void> _copy(String output) async {
    await Clipboard.setData(ClipboardData(text: output));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    final result = _translate();
    final isTextInput = _direction == Direction.textToBinary;

    return Scaffold(
      appBar: AppBar(title: const Text('Binary Translator')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<Direction>(
              segments: const [
                ButtonSegment(
                  value: Direction.textToBinary,
                  label: Text('Text → Binary'),
                ),
                ButtonSegment(
                  value: Direction.binaryToText,
                  label: Text('Binary → Text'),
                ),
              ],
              selected: {_direction},
              onSelectionChanged: (s) => _changeDirection(s.single),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('input'),
              controller: _input,
              minLines: 3,
              maxLines: 8,
              keyboardType:
                  isTextInput ? TextInputType.multiline : TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: isTextInput ? 'Text' : 'Binary (8-bit groups)',
                errorText: result.error,
                suffixIcon: _input.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.clear),
                        onPressed: _input.clear,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text(isTextInput ? 'Binary' : 'Text'),
                subtitle: SelectableText(
                  result.output.isEmpty ? '—' : result.output,
                  key: const Key('output'),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 16),
                ),
                trailing: IconButton(
                  tooltip: 'Copy',
                  icon: const Icon(Icons.copy),
                  onPressed:
                      result.output.isEmpty ? null : () => _copy(result.output),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
