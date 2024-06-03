import 'package:flutter/material.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/widgets/food_card.dart';
import 'package:provider/provider.dart';

class FoodsScreen extends StatelessWidget {
  const FoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodProvider foodProvider = Provider.of<FoodProvider>(context);
    List<Food> foodList = foodProvider.objects;

    return ListView.builder(
      itemBuilder: (context, index) => foodList[index].isDeleted
          ? Container(
              width: 0,
              height: 0,
            )
          : FoodCard(foodList[index]),
      itemCount: foodList.length,
    );
  }
}
