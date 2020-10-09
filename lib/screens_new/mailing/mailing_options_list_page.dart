import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/event.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/heading.dart';
import '../../ui_utils/widgets/photo_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../utils/enums.dart';
import '../../utils/router.gr.dart';

class MailingOptionsListPage extends StatefulWidget {
  const MailingOptionsListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _MailingOptionsListPageState createState() => _MailingOptionsListPageState();
}

class _MailingOptionsListPageState extends State<MailingOptionsListPage> {
  int selectedCardIndex = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: BColors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: widget.currEvent.name,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Heading(headingText: 'Mailing Service'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCardIndex = 0;
                      });
                    },
                    child: PhotoCard(
                      tileTitle: 'All',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Send mail to everyone',
                      bgColor: selectedCardIndex == 0
                          ? BColors.activeCardColor
                          : null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: BColors.blue,
                                  size: 25.0,
                                ),
                                Icon(
                                  Icons.person,
                                  color: BColors.blue,
                                  size: 25.0,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: BColors.blue,
                                  size: 25.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCardIndex = 1;
                      });
                    },
                    child: PhotoCard(
                      tileTitle: 'Specific',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Enter the specific people',
                      bgColor: selectedCardIndex == 1
                          ? BColors.activeCardColor
                          : null,
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
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.24),
                    child: SubmitButton(
                      onPressed: selectedCardIndex == null
                          ? null
                          : () {
                              if (selectedCardIndex == 0) {
                                ExtendedNavigator.rootNavigator.pushNamed(
                                  Routes.mailPage,
                                  arguments: MailPageArguments(
                                    currEvent: widget.currEvent,
                                    mode: MailingScreenMode.All,
                                  ),
                                );
                              } else if (selectedCardIndex == 1) {
                                ExtendedNavigator.rootNavigator.pushNamed(
                                  Routes.mailPage,
                                  arguments: MailPageArguments(
                                    currEvent: widget.currEvent,
                                    mode: MailingScreenMode.Specific,
                                  ),
                                );
                              }
                            },
                      buttonText: "Next",
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
