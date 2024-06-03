import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/providers/id_provider_dt.dart';
import 'package:macro_counter/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealFormScreen extends StatelessWidget {
  Meal? editedMeal;
  MealFormScreen({this.editedMeal, super.key});

  void _onSubmit(BuildContext context, meal) async {
    final MealProvider provider =
        Provider.of<MealProvider>(context, listen: false);
    if (editedMeal == null) {
      //Adding
      await provider.addObject(meal);
    } else {
      //Updating
      await provider.updateObject(meal);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    int uniqueId = editedMeal?.id ??
        Provider.of<IdProviderDt>(context, listen: false).generate();
    DateTime datetime = editedMeal?.datetime ?? DateTime.now();
    double quantity = editedMeal?.quantity ?? 1;
    int foodId = editedMeal?.foodId ?? 0;

    List<Food> foodList = Provider.of<FoodProvider>(context).objects;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Meal"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  DropdownButton<int>(
                    hint: Text("Meal"),
                    isExpanded: true,
                    items: foodList.map((Food food) {
                      return DropdownMenuItem(
                        value: food.id,
                        child: Text(food.name),
                      );
                    }).toList(),
                    onChanged: (int? id) {
                      if (id != null) {
                        foodId = id;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    initialValue: quantity.toString(),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    onChanged: (value) {
                      quantity = double.parse(value);
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Meal newMeal = Meal(uniqueId, datetime, quantity, foodId);
                      _onSubmit(context, newMeal);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Confirmar"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/providers/id_provider_dt.dart';
import 'package:provider/provider.dart';

class FoodFormScreen extends StatelessWidget {
  Food? editedFood;
  FoodFormScreen({super.key, this.editedFood});

  void _onSubmit(BuildContext context, Food food) async {
    final FoodProvider provider =
        Provider.of<FoodProvider>(context, listen: false);
    if (editedFood == null) {
      //Adding
      await provider.addObject(food);
    } else {
      //Updating
      await provider.updateObject(food);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    int uniqueId = editedFood?.id ??
        Provider.of<IdProviderDt>(context, listen: false).generate();
    String name = editedFood?.name ?? "";
    double calories = editedFood?.calories ?? 0;
    double carbs = editedFood?.carbs ?? 0;
    double proteins = editedFood?.proteins ?? 0;
    double fats = editedFood?.fats ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Food"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Food Name'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    initialValue: calories.toString(),
                    decoration: const InputDecoration(labelText: 'Calories'),
                    onChanged: (value) {
                      calories = double.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    initialValue: carbs.toString(),
                    decoration: const InputDecoration(labelText: 'Carbs'),
                    onChanged: (value) {
                      carbs = double.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    initialValue: proteins.toString(),
                    decoration: const InputDecoration(labelText: 'Proteins'),
                    onChanged: (value) {
                      proteins = double.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    initialValue: fats.toString(),
                    decoration: const InputDecoration(labelText: 'Fats'),
                    onChanged: (value) {
                      fats = double.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Food newFood =
                          Food(uniqueId, name, calories, carbs, proteins, fats);
                      _onSubmit(context, newFood);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Confirmar"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 */