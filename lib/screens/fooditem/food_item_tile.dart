import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
import 'package:bon_appetit/screens/fooditem/add_food_item.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem foodItem;

  FoodItemTile({this.foodItem});
  @override
  Widget build(BuildContext context) {
    final categories =
        Provider.of<List<Category>>(context, listen: false) ?? [];
    Future<bool> showAlertBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to delete this item?'),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
    }

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                foodItem.foodItemName ?? '',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.teal[400],
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddFoodItem(
                    isAdded: true,
                    foodItem: foodItem,
                    categories: categories,
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.teal[400],
              ),
              onPressed: () async {
                bool result = await showAlertBox();
                if (result) {
                  await DatabaseService(
                          uid: Provider.of<FirebaseUser>(context, listen: false)
                              .uid)
                      .deleteFoodItem(foodItem.foodItemId);
                }
              },
            )
          ],
        ),
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Price : ₹" + foodItem.foodItemPrice ?? '',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Description : " + foodItem.foodItemDescription ?? '',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
