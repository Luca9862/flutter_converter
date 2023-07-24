import 'package:convertitore/navigationbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int numero = 0;

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  int mToCm(int nMetri) {
    numero = nMetri * 100;
    return numero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextField(
              controller: myController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Insert',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Result: $numero',
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
      //bottomNavigationBar: const MyBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mToCm(int.parse(myController.text));
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