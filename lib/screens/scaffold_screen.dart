import 'package:flutter/material.dart';
import 'package:macro_counter/screens/foods_screen.dart';
import 'package:macro_counter/screens/meals_screen.dart';
import 'package:macro_counter/screens/settings_screen.dart';

class ScaffoldScreen extends StatefulWidget {
  const ScaffoldScreen({super.key});

  @override
  State<ScaffoldScreen> createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> screens = [
    {
      "title": "Meals",
      "screen": MealsScreen(),
    },
    {
      "title": "Foods",
      "screen": FoodsScreen(),
    },
    {
      "title": "Settings",
      "screen": SettingsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[selectedIndex]["title"]),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return screens[selectedIndex]["screen"];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
