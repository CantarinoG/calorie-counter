import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/screens/food_form_screen.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard(this.food, {super.key});

  void _onDelete(BuildContext context) {
    food.isDeleted = true;
    Provider.of<FoodProvider>(context, listen: false).updateObject(food);
  }

  void _onUpdate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodFormScreen(
          editedFood: food,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    food.name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _onUpdate(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _onDelete(context);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Cal: ${food.calories}"),
                  backgroundColor: Colors.orange[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Carb: ${food.carbs}"),
                  backgroundColor: Colors.lightGreen[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Prot: ${food.proteins}"),
                  backgroundColor: Colors.purple[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Fat: ${food.fats}"),
                  backgroundColor: Colors.red[200]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
