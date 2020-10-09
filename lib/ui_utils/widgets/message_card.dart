import 'package:flutter/material.dart';

import '../colors.dart';
import 'submit_button.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    this.title,
    @required this.message,
    this.onPressed,
  });
  //: assert(title!=''), assert(message!='');

  final String message, title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.31,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.message,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.error_outline,
                color: BColors.blue,
                size: 48.0,
              ),
              SubmitButton(
                buttonText: 'Okay',
                backgroundColor: BColors.blue,
                fontColor: BColors.white,
                onPressed: onPressed != null
                    ? onPressed
                    : () {
                        Navigator.pop(context);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
    return AlertDialog(
      title: Text(
        this.title,
      ),
      content: Text(
        this.message,
      ),
      actions: [
        FlatButton(
          onPressed: onPressed != null
              ? onPressed
              : () {
                  Navigator.pop(context);
                },
          child: Text('Okay'),
        ),
      ],
    );
    */
