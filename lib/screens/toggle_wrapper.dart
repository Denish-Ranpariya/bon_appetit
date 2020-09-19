import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category/category_screen.dart';
import 'fooditem/food_items_screen.dart';

class ToggleWrapper extends StatefulWidget {
  @override
  _ToggleWrapperState createState() => _ToggleWrapperState();
}

class _ToggleWrapperState extends State<ToggleWrapper> {
  bool isCategory = true;

  void toggleFunction() {
    setState(() {
      isCategory = !isCategory;
    });
  }

  Future<bool> onPressedBack() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to close the app?'),
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

  @override
  Widget build(BuildContext context) {
    return isCategory
        ? WillPopScope(
            onWillPop: onPressedBack,
            child: CategoryScreen(
              toggleFunction: toggleFunction,
            ),
          )
        : StreamProvider<List<Category>>.value(
            value: DatabaseService(uid: Provider.of<FirebaseUser>(context).uid)
                .categories,
            child: WillPopScope(
                onWillPop: onPressedBack,
                child: FoodItemsScreen(
                  toggleFunction: toggleFunction,
                )));
  }
}
