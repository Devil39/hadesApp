import 'package:flutter/material.dart';

class ConfirmationCard extends StatelessWidget {
  const ConfirmationCard({
    this.onPressed,
    @required this.content,
  });

  final Function onPressed;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Alert',
      ),
      content: Text(content),
      actions: [
        FlatButton(
          onPressed: onPressed != null
              ? onPressed
              : () {
                  Navigator.pop(context);
                },
          child: Text('Yes'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
