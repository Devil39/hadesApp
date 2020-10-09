import 'package:flutter/material.dart';

import '../../../ui_utils/colors.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/heading.dart';
import '../../../ui_utils/widgets/photo_card.dart';

class AttendanceOptionListPage extends StatefulWidget {
  @override
  _AttendanceOptionListPageState createState() => _AttendanceOptionListPageState();
}

class _AttendanceOptionListPageState extends State<AttendanceOptionListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: BColors.blue,
              ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: 'WomenTechies',
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Heading(headingText: 'Attendance'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  PhotoCard(
                    tileTitle: 'Manual Attendance',
                    tileImage:'images/orgPng.png' ,
                  ),
                  PhotoCard(
                    tileTitle: 'QR based Attendance',
                    tileImage:'images/orgPng.png' ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
