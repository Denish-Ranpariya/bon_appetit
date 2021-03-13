import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
import 'package:bon_appetit/screens/fooditem/add_food_item.dart';
import 'package:bon_appetit/services/connectivity_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/alert_dialog_box.dart';
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
        builder: (context) => AlertDialogBox(
          textMessage: 'Do you really want to delete this item?',
        ),
      );
    }

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ExpansionTile(
        title: Row(
          children: [
            // CircleAvatar(
            //   radius: 6.0,
            //   backgroundColor:
            //       foodItem.foodItemType == 'nonveg' ? Colors.red : Colors.green,
            // ),
            CircleAvatar(
              radius: 32,
              backgroundColor:
              foodItem.foodItemType == 'nonveg' ? Colors.red : Colors.green,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage:
                foodItem.foodItemImageUrl == '' ? AssetImage('images/default.jpeg') : NetworkImage(foodItem.foodItemImageUrl),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                foodItem.foodItemName ?? '',
                style: kTileTextStyle,
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
                bool conResult =
                    await ConnectivityService.getConnectivityStatus();
                bool result = await showAlertBox();
                if (conResult) {
                  if (result ?? false) {
                    await DatabaseService(
                            uid: FirebaseAuth.instance.currentUser.uid)
                        .deleteFoodItem(foodItem.foodItemId);
                    ToastClass.buildShowToast('Item deleted');
                  }
                } else {
                  ToastClass.buildShowToast('No internet connection');
                }
              },
            ),
          ],
        ),
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Price : ₹" + foodItem.foodItemPrice ?? '',
              style: kTileTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Description : " + foodItem.foodItemDescription ?? '',
              style: kTileTextStyle,
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
