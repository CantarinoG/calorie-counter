import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:macro_counter/providers/meal_provider.dart';
import 'package:macro_counter/screens/meal_form_screen.dart';
import 'package:macro_counter/utils/date_formatter.dart';
import 'package:provider/provider.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final Food? food;
  final DateFormatter formatter = DateFormatter();
  MealCard(this.meal, this.food, {super.key});

  void _onUpdate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealFormScreen(
          editedMeal: meal,
        ),
      ),
    );
  }

  void _onDelete(BuildContext context) {
    Provider.of<MealProvider>(context, listen: false).deleteObject(meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                child: Text(formatter.formatTime(meal.datetime))),
            Row(
              children: [
                Text("x ${meal.quantity}"),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    food!.name,
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
                  label: Text("Cal: ${food!.calories * meal.quantity}"),
                  backgroundColor: Colors.orange[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Carb: ${food!.carbs * meal.quantity}"),
                  backgroundColor: Colors.lightGreen[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Prot: ${food!.proteins * meal.quantity}"),
                  backgroundColor: Colors.purple[200]!,
                ),
                Chip(
                  labelPadding: EdgeInsets.all(0),
                  label: Text("Fat: ${food!.fats * meal.quantity}"),
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
