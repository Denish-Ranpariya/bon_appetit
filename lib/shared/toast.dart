import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastClass {
  static Future<bool> buildShowToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFF616161),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
