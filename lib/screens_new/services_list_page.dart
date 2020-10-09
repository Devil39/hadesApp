import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../ui_utils/colors.dart';
import '../ui_utils/widgets/app_bar.dart';
import '../ui_utils/widgets/heading.dart';
import '../ui_utils/widgets/photo_card.dart';
import '../utils/router.gr.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _ServiceListPageState createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: Container(),
        title: widget.currEvent.name,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Heading(headingText: 'Services'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator.pushNamed(
                        Routes.mailingOptionsListPage,
                        arguments: MailingOptionsListPageArguments(
                          currEvent: widget.currEvent,
                        ),
                      );
                    },
                    child: PhotoCard(
                      tileTitle: 'Mailing Service',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Send mail to everyone',
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.mail,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator.pushNamed(
                        Routes.exportOptionListPage,
                        arguments: ExportOptionListPageArguments(
                          currEvent: widget.currEvent,
                        ),
                      );
                    },
                    child: PhotoCard(
                      tileTitle: 'Export Details',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Enter the specific people',
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.edit,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
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
