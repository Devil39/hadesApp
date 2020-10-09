import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    @required this.onPressed,
    @required this.buttonText,
    this.backgroundColor = BColors.blue,
    this.fontColor = BColors.white,
    this.borderColor = BColors.blue,
    this.minWidth,
  });

  final Function onPressed;
  final String buttonText;
  final Color backgroundColor, fontColor, borderColor;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: ButtonTheme(
        height: 54,
        minWidth: minWidth == null
            //? MediaQuery.of(context).size.width * 0.33
            ? 100
            : minWidth,
        child: RaisedButton(
          elevation: 2,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: onPressed != null ? borderColor : BColors.grey,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: Dimens.buttonTextSize,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
