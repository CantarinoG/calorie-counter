import 'package:flutter/material.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/providers/meal_provider.dart';
import 'package:macro_counter/screens/food_form_screen.dart';
import 'package:macro_counter/screens/foods_screen.dart';
import 'package:macro_counter/screens/meal_form_screen.dart';
import 'package:macro_counter/screens/meals_screen.dart';
import 'package:macro_counter/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class ScaffoldScreen extends StatefulWidget {
  bool fetchedData = false;
  ScaffoldScreen({super.key});

  @override
  State<ScaffoldScreen> createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> screens = [
    {
      "title": "Meals",
      "screen": MealsScreen(),
      "fabAction": (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealFormScreen(),
          ),
        );
      },
    },
    {
      "title": "Foods",
      "screen": FoodsScreen(),
      "fabAction": (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodFormScreen(),
          ),
        );
      },
    },
    {
      "title": "Settings",
      "screen": SettingsScreen(),
      "fabAction": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    MealProvider mealProvider = Provider.of<MealProvider>(context);
    FoodProvider foodProvider = Provider.of<FoodProvider>(context);

    if (!widget.fetchedData) {
      widget.fetchedData = true;
      mealProvider.loadObjects();
      foodProvider.loadObjects();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(screens[selectedIndex]["title"]),
        backgroundColor: Colors.lightBlue[100],
      ),
      floatingActionButton: (screens[selectedIndex]["fabAction"] == null)
          ? null
          : FloatingActionButton(
              onPressed: () {
                screens[selectedIndex]["fabAction"](context);
              },
              child: const Icon(Icons.add),
            ),
      body: screens[selectedIndex]["screen"] as Widget,
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
