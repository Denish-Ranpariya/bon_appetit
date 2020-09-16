import 'package:bon_appetit/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ABC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddFoodItem();
  }
}

class AddFoodItem extends StatefulWidget {
  final List<Category> categories;
  AddFoodItem({this.categories});
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String categoryName;
  final _formKey = GlobalKey<FormState>();
  String _value;
  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height,
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Add Food Item',
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the name of food item';
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
                        hintText: 'Name',
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
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the price of food item';
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
                        hintText: 'Price',
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
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: _value,
                      hint: Text('Select Category'),
                      items: widget.categories.map((Category value) {
                        return new DropdownMenuItem<String>(
                          value: value.categoryName,
                          child: Text(value.categoryName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the description of food item';
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
                        hintText: 'Description',
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
                      height: 20,
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(categoryName);

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
