import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_category_screen.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  CategoryTile({this.category});

  @override
  Widget build(BuildContext context) {
    Future<bool> showAlertBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to delete this category?'),
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
      child: ListTile(
        title: Text(
          category.categoryName ?? '',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
          ),
        ),
        trailing: Wrap(
          //mainAxisAlignment: MainAxisAlignment.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.teal[400],
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddCategory(
                    isAdded: true,
                    category: category,
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

                if (result ?? false) {
                  await DatabaseService(
                          uid: Provider.of<FirebaseUser>(context, listen: false)
                              .uid)
                      .deleteFoodItemCategory(category.categoryName);
                  await DatabaseService(
                          uid: Provider.of<FirebaseUser>(context, listen: false)
                              .uid)
                      .deleteCategory(category.categoryId);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
