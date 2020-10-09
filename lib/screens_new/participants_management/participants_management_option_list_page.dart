import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/event.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/heading.dart';
import '../../ui_utils/widgets/photo_card.dart';
import '../../utils/router.gr.dart';

class ParticipantsManagementOptionListPage extends StatefulWidget {
  const ParticipantsManagementOptionListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _ParticipantsManagementOptionListPageState createState() =>
      _ParticipantsManagementOptionListPageState();
}

class _ParticipantsManagementOptionListPageState
    extends State<ParticipantsManagementOptionListPage> {
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
            Heading(headingText: 'Participants'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator.pushNamed(
                        Routes.attendancePage,
                        arguments: AttendancePageArguments(
                          currEvent: widget.currEvent,
                        ),
                      );
                    },
                    child: PhotoCard(
                      tileTitle: 'Attendance',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.center_focus_weak,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator.pushNamed(
                        Routes.participantCRUDOptionListPage,
                        arguments: ParticipantCRUDOptionListPageArguments(
                          currEvent: widget.currEvent,
                        ),
                      );
                    },
                    child: PhotoCard(
                      tileTitle: 'Participant Management',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.person,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator.pushNamed(
                        Routes.couponsOptionListPage,
                        arguments: CouponsOptionListPageArguments(
                          currEvent: widget.currEvent,
                        ),
                      );
                    },
                    child: PhotoCard(
                      tileTitle: 'Coupons',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.star,
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
