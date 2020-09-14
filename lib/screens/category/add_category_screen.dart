import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class AddCategory extends StatefulWidget {
  final bool isAdded;
  final Category category;

  AddCategory({this.isAdded, this.category});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String categoryName;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //categoryName = widget.category.categoryName;
    return Form(
      key: _formKey,
      child: Container(
          color: Color(0xff757575),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
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
                      widget.isAdded ? 'Edit Category' : 'Add Category',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue:
                          widget.isAdded ? widget.category.categoryName : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the name of category';
                        }
                        return null;
                      },
                      autofocus: true,
                      onChanged: (newText) {
                        setState(() {
                          categoryName = newText;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Category Name',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[600], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[600], width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        widget.isAdded ? 'Edit' : 'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      color: Colors.grey[600],
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(categoryName);
                          if (widget.isAdded) {
                            await DatabaseService(
                                    uid: Provider.of<FirebaseUser>(context,
                                            listen: false)
                                        .uid)
                                .insertCategoryData(
                                    widget.category.categoryId,
                                    categoryName ??
                                        widget.category.categoryName);
                          } else {
                            String id = randomAlphaNumeric(22);

                            await DatabaseService(
                                    uid: Provider.of<FirebaseUser>(context,
                                            listen: false)
                                        .uid)
                                .insertCategoryData(id, categoryName);
                          }

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
