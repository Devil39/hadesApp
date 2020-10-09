import 'package:flutter/material.dart';

import '../colors.dart';
import 'submit_button.dart';

class SuccessCard extends StatelessWidget {
  const SuccessCard({
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
                'Successful!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.done_outline,
                color: BColors.green,
                size: 48.0,
              ),
              SubmitButton(
                buttonText: 'Okay',
                backgroundColor: BColors.green,
                borderColor: BColors.green,
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
