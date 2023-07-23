import 'package:flutter/material.dart';

import 'navigationbar.dart';

class BinaryScreen extends StatefulWidget {
  const BinaryScreen({super.key});

  @override
  State<BinaryScreen> createState() => _BinaryScreen();
}

class _BinaryScreen extends State<BinaryScreen> {

  String binary = '';

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  toBinary(int n){
    if (n == 0) {
      return '0';
    }
    while (n > 0) {
      binary = (n % 2).toString() + binary;
      n ~/= 2;
    }
    return binary;
  }

  String stringToBinary(String s) {
    String binary = '';
    for (int i = 0; i < s.length; i++) {
      binary += toBinary(s.codeUnitAt(i)) + ' ';
    }
    return binary;
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
          Text(
            'Result: $binary',
            style: const TextStyle(fontSize: 24),
          ),
        ]
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            binary = '';
            stringToBinary(myController.text);
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