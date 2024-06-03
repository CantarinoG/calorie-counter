import 'package:flutter/material.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/providers/meal_provider.dart';
import 'package:macro_counter/providers/user_settings_provider.dart';
import 'package:macro_counter/utils/date_formatter.dart';
import 'package:macro_counter/widgets/meal_card.dart';
import 'package:macro_counter/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  DateTime selectedDate = DateTime.now();

  Map<String, double> getDailyTotal(
      FoodProvider provider, List<Meal> mealList) {
    double calorie = 0;
    double carb = 0;
    double protein = 0;
    double fat = 0;
    mealList.forEach((meal) {
      calorie += meal.quantity * provider.getObject(meal.foodId)!.calories;
      carb += meal.quantity * provider.getObject(meal.foodId)!.carbs;
      protein += meal.quantity * provider.getObject(meal.foodId)!.proteins;
      fat += meal.quantity * provider.getObject(meal.foodId)!.fats;
    });
    return {
      "calorie": calorie,
      "carb": carb,
      "protein": protein,
      "fat": fat,
    };
  }

  @override
  Widget build(BuildContext context) {
    DateFormatter formatter = DateFormatter();

    final settingsProvider = Provider.of<UserSettingsProvider>(context);

    List<Meal> mealList =
        Provider.of<MealProvider>(context).filterMealsByDay(selectedDate);

    final foodProvider = Provider.of<FoodProvider>(context);
    Map<String, double> consumedMacros = getDailyTotal(foodProvider, mealList);
    double consumedCalories = consumedMacros['calorie']!;
    double consumedCarbs = consumedMacros['carb']!;
    double consumendProteins = consumedMacros['protein']!;
    double consumedFats = consumedMacros['fat']!;

    void _showDatePicker() {
      showDatePicker(
              context: context,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now(),
              initialDate: selectedDate)
          .then(
        (value) {
          setState(
            () {
              selectedDate = value ?? selectedDate;
            },
          );
        },
      );
    }

    return FutureBuilder(
        future: settingsProvider.object,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            double calorieGoal = data!.calorieGoal;
            double carbGoal = data.carbGoal;
            double proteinGoal = data.proteinGoal;
            double fatGoal = data.fatGoal;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatter.formatDate(selectedDate),
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: _showDatePicker,
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                ),
                ProgressIndicatorWidget(
                  consumedCalories,
                  calorieGoal,
                  Colors.orange,
                  Colors.orange[200]!,
                  "Calories",
                ),
                ProgressIndicatorWidget(
                  consumedCarbs,
                  carbGoal,
                  Colors.lightGreen,
                  Colors.lightGreen[200]!,
                  "Carbs",
                ),
                ProgressIndicatorWidget(
                  consumendProteins,
                  proteinGoal,
                  Colors.purple,
                  Colors.purple[200]!,
                  "Protein",
                ),
                ProgressIndicatorWidget(
                  consumedFats,
                  fatGoal,
                  Colors.red,
                  Colors.red[200]!,
                  "Fats",
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: mealList.length,
                    itemBuilder: (context, index) {
                      return MealCard(mealList[index],
                          foodProvider.getObject(mealList[index].foodId));
                    },
                  ),
                ),
              ],
            );
          } else {
            return Text("Something Went Wrong...");
          }
        });
  }
}
