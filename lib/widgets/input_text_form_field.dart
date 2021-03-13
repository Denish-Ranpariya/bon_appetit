import 'package:bon_appetit/shared/constants.dart';
import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String initialValue;
  final Function onChanged;
  final String hintText;
  final String validatorText;
  final bool autoFocus;
  final int maxLine;

  InputTextFormField(
      {this.initialValue,
      this.onChanged,
      this.hintText,
      this.validatorText,
      this.autoFocus = false,
      this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      initialValue: initialValue,
      validator: (value) {
        if (value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      autofocus: autoFocus,
      onChanged: onChanged,
      decoration: kInputTextBoxDecoration.copyWith(hintText: hintText),
    );
  }
}
