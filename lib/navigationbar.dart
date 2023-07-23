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

  void onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: onItemTap,
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
