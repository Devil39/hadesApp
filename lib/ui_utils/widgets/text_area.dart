import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    @required this.title,
    @required this.hint,
    @required this.label,
    @required this.obscureText,
    @required this.controller,
    this.validator = null,
    this.inputType = TextInputType.text,
    this.suffixIcon = null,
  });

  final String title, hint, label;
  final bool obscureText;
  final Function validator;
  final TextInputType inputType;
  final TextEditingController controller;
  final IconButton suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: Dimens.formHeadingTextSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            style: TextStyle(
              color: BColors.black,
            ),
            keyboardType: inputType,
            validator: validator,
            decoration: InputDecoration(
              //border: OutlineInputBorder(
              //  borderRadius: BorderRadius.circular(10.0),
              //),
              border: InputBorder.none,
              filled: true,
              fillColor: BColors.backgroundBlue,
              hintStyle: TextStyle(
                fontSize: Dimens.formTextSize,
              ),
              labelStyle: TextStyle(
                fontSize: Dimens.formTextSize,
              ),
              suffixIcon: suffixIcon,
              //border: OutlineInputBorder(
              //  borderSide: BorderSide(
              //    color: Colors.blue,
              //  ),
              //),
              hintText: hint,
              labelText: label,
            ),
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}
