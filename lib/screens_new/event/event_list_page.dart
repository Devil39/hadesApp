import 'package:flutter/material.dart';

import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/heading.dart';
import '../../ui_utils/widgets/photo_card.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: BColors.blue,
          ),
        ),
        title: '',
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(headingText: 'Developers Student Club'),
            Expanded(
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return PhotoCard(
                    tileTitle: 'WomenTechies',
                    tileImage: 'images/orgPng.png',
                    tileSubtitle: 'Lorem Ipsum lorem lorem something something',
                    tileTrailing: Container(
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
