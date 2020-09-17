import 'package:bon_appetit/models/food_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_item_tile.dart';

class FoodItemList extends StatefulWidget {
  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  @override
  Widget build(BuildContext context) {
    final foodItems = Provider.of<List<FoodItem>>(context) ?? [];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return FoodItemTile(foodItem: foodItems[index]);
      },
    );
  }
}
