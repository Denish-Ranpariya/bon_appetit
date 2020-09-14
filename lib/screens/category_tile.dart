import 'package:bon_appetit/models/category.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  CategoryTile({this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        title: Text(
          category.categoryName,
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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.teal[400],
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
