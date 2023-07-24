import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BinaryScreen extends StatefulWidget {
  const BinaryScreen({super.key});

  @override
  State<BinaryScreen> createState() => _BinaryScreen();
}

class _BinaryScreen extends State<BinaryScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String toBinary(int n) {
    if (n == 0) {
      return '00000000';
    }
    String binary = '';
    while (n > 0) {
      binary = (n % 2).toString() + binary;
      n ~/= 2;
    }
    // Aggiungi zeri iniziali (padding) fino a raggiungere 8 bit
    while (binary.length < 8) {
      binary = '0$binary';
    }
    return binary;
  }

  stringToBinary(String s) {
    String binary = '';
    for (int i = 0; i < s.length; i++) {
      int charValue = s.codeUnitAt(i); // Ottieni il valore ASCII del carattere
      binary += "${toBinary(charValue)} ";
    }
    return binary;
  }

  void copyToClipboard() {
    String binaryText = stringToBinary(myController.text);
    Clipboard.setData(ClipboardData(text: binaryText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Testo copiato negli appunti!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binary convert'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: TextField(
                  controller: myController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insert',
                  ),
                )
            ),
            const SizedBox(height: 16),
            SelectableText(
              'Result: ${stringToBinary(myController.text)}', // Chiamiamo stringToBinary direttamente qui
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => copyToClipboard(),
              child: const Text('Copia'),
            ),
          ]
      ),
      //bottomNavigationBar: const MyBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Nessun bisogno di resettare la variabile binary qui
          });
        },
        child: const Icon(
          Icons.arrow_right,
          size: 32,
        ),
      ),
    );
  }
}