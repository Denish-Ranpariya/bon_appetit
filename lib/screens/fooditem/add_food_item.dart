import 'dart:io';
import 'package:bon_appetit/models/category.dart';
import 'package:bon_appetit/models/food_item.dart';
import 'package:bon_appetit/services/connectivity_service.dart';
import 'package:bon_appetit/services/database_service.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:bon_appetit/shared/toast.dart';
import 'package:bon_appetit/widgets/bottom_button.dart';
import 'package:bon_appetit/widgets/input_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:path/path.dart' as path;

import '../../shared/loading.dart';

class AddFoodItem extends StatefulWidget {
  final List<Category> categories;
  final FoodItem foodItem;
  final isAdded;
  AddFoodItem({this.categories, this.foodItem, this.isAdded});
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String foodItemName;
  String foodItemPrice;
  String foodItemCategory;
  String foodItemDescription;
  String radioValue; //Initial definition of radio button value
  String foodItemType;
  String foodItemImageUrl;
  bool isLoading = false;
  bool isImageUpload = false;

  @override
  void initState() {
    super.initState();
    if (widget.isAdded)
      radioValue = widget.foodItem.foodItemType;
    else
      radioValue = 'veg';
  }

  void radioButtonChanges(String value) {
    setState(() {
      radioValue = value;
      switch (value) {
        case 'veg':
          foodItemType = value;
          break;
        case 'nonveg':
          foodItemType = value;
          break;
        default:
          foodItemType = null;
      }
    });
  }

  File _file;

  String fileName = '';

  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Form(
            key: _formKey,
            child: Container(
                color: Color(0xff757575),
                child: Container(
                  decoration: kBottomSheetOuterBoxDecoration,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: kBottomSheetInnerBoxDecoration,
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.isAdded
                                  ? 'Edit Food Item'
                                  : 'Add Food Item',
                              style: kScreenHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            isImageUpload
                                ? CircularProgressIndicator()
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: widget.isAdded
                                        ? widget.foodItem.foodItemImageUrl != ''
                                            ? _file != null
                                                ? FileImage(_file)
                                                : NetworkImage(widget
                                                    .foodItem.foodItemImageUrl)
                                            : _file != null
                                                ? FileImage(_file)
                                                : AssetImage(
                                                    'images/default.jpeg')
                                        : _file != null
                                            ? FileImage(_file)
                                            : AssetImage('images/default.jpeg'),
                                  ),
                            TextButton(
                              onPressed: () async {
                                final pickedImage = await picker.getImage(
                                    source: ImageSource.gallery);
                                if (pickedImage == null) {
                                  return;
                                }
                                setState(() {
                                  _file = File(pickedImage.path);
                                });
                              },
                              child: Text('Choose Image'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InputTextFormField(
                              autoFocus: true,
                              initialValue: widget.isAdded
                                  ? widget.foodItem.foodItemName
                                  : null,
                              onChanged: (newText) {
                                setState(() {
                                  foodItemName = newText;
                                });
                              },
                              hintText: 'Name',
                              validatorText:
                                  'Please enter the name of food item',
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InputTextFormField(
                              initialValue: widget.isAdded
                                  ? widget.foodItem.foodItemPrice
                                  : null,
                              onChanged: (newText) {
                                setState(() {
                                  foodItemPrice = newText;
                                });
                              },
                              hintText: 'Price',
                              validatorText:
                                  'Please enter the price of food item',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null)
                                    return 'Please Select a category';
                                  else
                                    return null;
                                },
                                value: widget.isAdded
                                    ? widget.foodItem.foodItemCategory
                                    : foodItemCategory,
                                isExpanded: true,
                                hint: Text('Select Category'),
                                items: widget.categories.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value.categoryName,
                                    child: Text(value.categoryName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    foodItemCategory = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputTextFormField(
                              maxLine: 3,
                              initialValue: widget.isAdded
                                  ? widget.foodItem.foodItemDescription
                                  : null,
                              onChanged: (newText) {
                                setState(() {
                                  foodItemDescription = newText;
                                });
                              },
                              hintText: 'Description',
                              validatorText:
                                  'Please enter the description of food item',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 'veg',
                                  groupValue: radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                                Text(
                                  "Veg.",
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Radio(
                                  value: 'nonveg',
                                  groupValue: radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                                Text(
                                  "Non-Veg.",
                                ),
                              ],
                            ),
                            BottomButton(
                              buttonText: widget.isAdded ? 'Edit' : 'Add',
                              onPressed: () async {
                                bool result = await ConnectivityService
                                    .getConnectivityStatus();
                                setState(() {
                                  isImageUpload = true;
                                });
                                if (_file != null && await _file.exists()) {
                                  fileName = path.basename(_file.path);
                                  foodItemImageUrl = await DatabaseService
                                      .uploadImageToFirebaseStorage(
                                          fileName, _file);
                                }
                                if (_formKey.currentState.validate()) {
                                  if (result) {
                                    if (widget.isAdded) {
                                      await DatabaseService(
                                              uid: FirebaseAuth
                                                  .instance.currentUser.uid)
                                          .insertFoodItemData(
                                              widget.foodItem.foodItemId,
                                              foodItemName ??
                                                  widget.foodItem.foodItemName,
                                              foodItemPrice ??
                                                  widget.foodItem.foodItemPrice,
                                              foodItemCategory ??
                                                  widget.foodItem
                                                      .foodItemCategory,
                                              foodItemDescription ??
                                                  widget.foodItem
                                                      .foodItemDescription,
                                              foodItemType ??
                                                  widget.foodItem.foodItemType,
                                              foodItemImageUrl ??
                                                  widget.foodItem
                                                      .foodItemImageUrl);
                                      ToastClass.buildShowToast(
                                          'Changes saved');
                                    } else {
                                      String id = randomAlphaNumeric(22);
                                      await DatabaseService(
                                              uid: FirebaseAuth
                                                  .instance.currentUser.uid)
                                          .insertFoodItemData(
                                              id,
                                              foodItemName,
                                              foodItemPrice,
                                              foodItemCategory,
                                              foodItemDescription,
                                              foodItemType ?? 'veg',
                                              foodItemImageUrl ?? '');
                                      ToastClass.buildShowToast(
                                          'Item added successfully');
                                    }
                                    setState(() {
                                      isImageUpload = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    ToastClass.buildShowToast(
                                        'No internet connection');
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
  }
}
