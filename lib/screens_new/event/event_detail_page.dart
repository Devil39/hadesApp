import 'package:flutter/material.dart';

import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/submit_button.dart';

class EventDetailPage extends StatefulWidget {
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'WomenTechies',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: BColors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSize: 21.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 108.0,
            height: 108.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/orgPng.png'),
              ),
            ),
          ),
          Container(
            color: BColors.white,
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Details about the event'),
              ],
            ),
          ),
          SubmitButton(
            buttonText: 'Create',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
