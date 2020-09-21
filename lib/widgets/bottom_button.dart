import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  BottomButton({this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        color: Color(0xff5ab190),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
