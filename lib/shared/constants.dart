import 'package:flutter/material.dart';

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kUpperBoxDecoration = BoxDecoration(
  color: Color(0xFFc9e3db),
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25.0),
    bottomRight: Radius.circular(25.0),
  ),
);

const kScreenHeadingTextStyle = TextStyle(
  color: Color(0xFF616161),
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const kTileTextStyle = TextStyle(
  color: Color(0xFF424242),
  fontWeight: FontWeight.w400,
  fontSize: 18.0,
);

const kBottomSheetOuterBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(15.0),
    topLeft: Radius.circular(15.0),
  ),
);

const kBottomSheetInnerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30.0),
    topLeft: Radius.circular(30.0),
  ),
);

const kInputTextBoxDecoration = InputDecoration(
//hintText: 'Category Name',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff757575), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff757575), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
