import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Add Category',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    autofocus: true,
                    onChanged: (newText) {
                      categoryName = newText;
                    },
                    decoration: InputDecoration(
                      hintText: 'Category Name',
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600], width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    color: Colors.grey[600],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}