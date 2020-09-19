import 'package:bon_appetit/models/food_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../models/food_item.dart';
import 'food_item_tile.dart';

class FoodItemList extends StatefulWidget {
  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  @override
  Widget build(BuildContext context) {
    final foodItems = Provider.of<List<FoodItem>>(context) ?? [];
    foodItems.sort((a, b) => a.foodItemCategory.compareTo(b.foodItemCategory));
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        if (index == 0 ||
            foodItems[index].foodItemCategory !=
                foodItems[index - 1].foodItemCategory) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 25),
                alignment: Alignment.centerLeft,
                // color: Colors.teal[700],
                // width: MediaQuery.of(context).size.width,
                child: Text(
                  foodItems[index].foodItemCategory,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.teal[200],
                indent: 25,
                endIndent: 25,
              ),
              FoodItemTile(foodItem: foodItems[index])
            ],
          );
        } else {
          return FoodItemTile(foodItem: foodItems[index]);
        }
      },
    );
  }
}
