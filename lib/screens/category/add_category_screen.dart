import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/services/connectivity_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Form(
      key: _formKey,
      child: Container(
        color: Color(0xff757575),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: kBottomSheetOuterBoxDecoration,
          child: Container(
            decoration: kBottomSheetInnerBoxDecoration,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.isAdded ? 'Edit Category' : 'Add Category',
                    style: kScreenHeadingTextStyle,
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
                    decoration: kInputTextBoxDecoration.copyWith(
                      hintText: 'Category Name',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  BottomButton(
                    buttonText: widget.isAdded ? 'Edit' : 'Add',
                    onPressed: () async {
                      bool result =
                          await ConnectivityService.getConnectivityStatus();

                      if (_formKey.currentState.validate()) {
                        print(categoryName);
                        if (result) {
                          if (widget.isAdded) {
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser.uid)
                                .editFoodItemCategory(
                                    widget.category.categoryName, categoryName);
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser.uid)
                                .insertCategoryData(
                                    widget.category.categoryId,
                                    categoryName ??
                                        widget.category.categoryName);
                            ToastClass.buildShowToast('Changes saved');
                          } else {
                            String id = randomAlphaNumeric(22);

                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser.uid)
                                .insertCategoryData(id, categoryName);
                            ToastClass.buildShowToast(
                                'Category added successfully');
                          }
                        } else {
                          ToastClass.buildShowToast('No internet connection');
                        }

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
