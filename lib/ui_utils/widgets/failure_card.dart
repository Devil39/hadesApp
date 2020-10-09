import 'package:flutter/material.dart';

import '../colors.dart';
import 'submit_button.dart';

class FailureCard extends StatelessWidget {
  const FailureCard({
    this.onPressed,
  });

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
                'Task Failed',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.error,
                color: BColors.red,
                size: 48.0,
              ),
              SubmitButton(
                buttonText: 'Okay',
                backgroundColor: BColors.red,
                borderColor: BColors.red,
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
        'Task Failed',
      ),
      content: Text(
        'Please try again after some time',
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
