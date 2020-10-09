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

class ExportOptionListPage extends StatefulWidget {
  const ExportOptionListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _ExportOptionListPageState createState() => _ExportOptionListPageState();
}

class _ExportOptionListPageState extends State<ExportOptionListPage> {
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
            Heading(headingText: 'Export Service'),
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
                      tileTitle: 'JSON',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Get the export in the form of a json pdf',
                      bgColor: selectedCardIndex == 0
                          ? BColors.activeCardColor
                          : null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.code,
                          color: BColors.blue,
                          size: 39.0,
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
                      tileTitle: 'CSV',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: 'Get the export in the form of a csv',
                      bgColor: selectedCardIndex == 1
                          ? BColors.activeCardColor
                          : null,
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
                                  Routes.exportPage,
                                  arguments: ExportPageArguments(
                                    currEvent: widget.currEvent,
                                    mode: ExportScreenMode.JSON,
                                  ),
                                );
                              } else if (selectedCardIndex == 1) {
                                ExtendedNavigator.rootNavigator.pushNamed(
                                  Routes.exportPage,
                                  arguments: ExportPageArguments(
                                    currEvent: widget.currEvent,
                                    mode: ExportScreenMode.CSV,
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
