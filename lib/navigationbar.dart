import 'package:convertitore/binaryscreen.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BinaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (_selectedIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BinaryScreen()),
          );
          if(_selectedIndex==0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.onetwothree),
          label: 'Meters',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.computer),
          label: 'Binary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
