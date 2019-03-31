import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String text;
  final TextInputType textInputType;
  final Color textFieldColor;
  final bool obscureText, autoFocus;
  final double bottomMargin;
  final TextStyle textStyle, hintStyle;
  var validateFunction;
  var onSaved;
  final int maxLength;
  final Key key;
  final int maxLines;
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
        this.bottomMargin,
        this.textStyle,
        this.validateFunction,
        this.onSaved,
        this.hintStyle,
        this.text,
        this.maxLength,
        this.controller,
        this.textCapitalization,
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: TextFormField(
        style: textStyle,
        key: key,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        validator: validateFunction,
        onSaved: onSaved ?? () => {},
        autofocus: autoFocus ?? false,
        initialValue: text,
        maxLength: maxLength,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLengthEnforced: true,
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: new InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: labelText,
            labelStyle: textStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
    );
  }
}
