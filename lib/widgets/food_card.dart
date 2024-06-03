import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard(this.food, {super.key});

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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
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
