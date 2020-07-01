import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String text;
  final TextInputType textInputType;
  final Color textFieldColor;
  final bool obscureText, autoFocus;
  final double verticalMargin;
  final double horizontalMargin;
  final TextStyle textStyle, hintStyle, labelStyle;
  var validateFunction;
  var onSaved;
  final int maxLength;
  final Key key;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

  //passing props in the Constructor.
  InputFormField(
      {this.key,
      this.hintText,
      this.labelText,
      this.obscureText,
      this.autoFocus,
      this.textInputType,
      this.textFieldColor,
      this.verticalMargin = 0.0,
      this.horizontalMargin = 0.0,
      this.textStyle,
      this.validateFunction,
      this.onSaved,
      this.hintStyle,
      this.labelStyle,
      this.text,
      this.maxLength,
      this.controller,
      this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
      child: TextFormField(
        style: textStyle,
        key: key,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: validateFunction,
        onSaved: onSaved,
        autofocus: autoFocus,
        initialValue: text,
        maxLength: maxLength,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLengthEnforced: true,
        controller: controller,
        decoration: new InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: labelText,
            labelStyle: labelStyle ?? textStyle,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
                width: 0.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
    );
  }
}
