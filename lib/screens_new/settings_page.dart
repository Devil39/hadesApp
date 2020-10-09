import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/event.dart';
import '../models/scoped_models/mainModel.dart';
import '../ui_utils/colors.dart';
import '../ui_utils/dimens.dart';
import '../ui_utils/widgets/app_bar.dart';
import '../ui_utils/widgets/heading.dart';
import '../ui_utils/widgets/photo_card.dart';
import '../utils/router.gr.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    @required this.currEvent,
    @required this.userEmail,
  });

  final Event currEvent;
  final String userEmail;

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: Header(
          leading: Container(),
          title: widget.currEvent.name,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Heading(headingText: 'Settings Page'),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 27.0,
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Current User:  ',
                        style: TextStyle(
                          fontSize: Dimens.smallHeadingTextSize,
                          color: BColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.userEmail,
                            style: TextStyle(
                              fontSize: Dimens.smallerHeadingTextSize,
                              color: BColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        ExtendedNavigator.rootNavigator.pushNamed(
                          Routes.joinOrgListPage,
                          arguments: JoinOrgListPageArguments(
                            from: 'home',
                          ),
                        );
                      },
                      child: PhotoCard(
                        tileTitle: 'Create/Join Organization',
                        tileImage: 'images/orgPng.png',
                        tileSubtitle: '',
                        tileTrailing: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: BColors.blue,
                            ),
                            onPressed: () {
                              ExtendedNavigator.rootNavigator.pushNamed(
                                Routes.joinOrgListPage,
                                arguments: JoinOrgListPageArguments(
                                  from: 'home',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.resetUserInfo();
                        ExtendedNavigator.rootNavigator
                            .popAndPushNamed(Routes.loginPage);
                      },
                      child: PhotoCard(
                        tileTitle: 'Logout',
                        tileImage: 'images/orgPng.png',
                        tileSubtitle: '',
                        tileTrailing: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: BColors.blue,
                            ),
                            onPressed: () {
                              model.resetUserInfo();
                              ExtendedNavigator.rootNavigator
                                  .popAndPushNamed(Routes.loginPage);
                            },
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
    });
  }
}
