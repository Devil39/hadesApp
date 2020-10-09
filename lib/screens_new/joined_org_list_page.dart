import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:badges/badges.dart';

import '../models/event.dart';
import '../models/organization.dart';
import '../models/scoped_models/mainModel.dart';
import '../ui_utils/colors.dart';
import '../ui_utils/widgets/app_bar.dart';
import '../ui_utils/widgets/confirmation_card.dart';
import '../ui_utils/widgets/failure_card.dart';
import '../ui_utils/widgets/heading.dart';
import '../ui_utils/widgets/photo_card.dart';
import '../utils/router.gr.dart';

class JoinedOrgListPage extends StatelessWidget {
  JoinedOrgListPage({
    @required this.currOrg,
    @required this.orgs,
    @required this.currEvent,
    @required this.currEventChange,
    @required this.events,
    @required this.scaffoldKey,
    @required this.token,
    @required this.orgToken,
    @required this.joinReqs,
  });

  final Organization currOrg;
  final List<Organization> orgs;
  final Event currEvent;
  final List<Event> events;
  final Function currEventChange;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String token, orgToken;
  final int joinReqs;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: Header(
            title: 'HADES',
            leading: Container(),
            actionsList: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 6.0, right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Badge(
                    //padding: EdgeInsets.all,
                    badgeColor: BColors.cardBackground,
                    badgeContent: Text(
                      joinReqs.toString(),
                      style: TextStyle(
                        color: BColors.black,
                        fontSize: 21.0,
                      ),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: BColors.blue,
                      size: 36.0,
                    ),
                  ),
                ),
              ),
              //IconButton(
              //  icon: Icon(
              //    Icons.notifications,
              //    color: BColors.blue,
              //  ),
              //  onPressed: () {
              //    scaffoldKey.currentState.openEndDrawer();
              //  },
              //),
            ],
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Heading(headingText: 'Organizations'),
                Container(
                  child: orgs.length == 0
                      ? Center(
                          child: Text("No organizations to be shown"),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orgs.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (currOrg.org_id == orgs[index].org_id) {
                              return GestureDetector(
                                onTap: () {},
                                child: PhotoCard(
                                  tileTitle: orgs[index].fullName,
                                  tileImage: 'images/orgPng.png',
                                  tileTrailing: null,
                                  bgColor: BColors.activeCardColor,
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                ExtendedNavigator.rootNavigator.popAndPushNamed(
                                  Routes.intermediateOrgLogin,
                                  arguments: IntermediateLoginPageArguments(
                                    orgId: orgs[index].org_id,
                                    token: token,
                                  ),
                                );
                              },
                              child: PhotoCard(
                                tileTitle: orgs[index].fullName,
                                tileImage: 'images/orgPng.png',
                                tileTrailing: null,
                              ),
                            );
                          },
                        ),
                ),
                Heading(headingText: 'Events'),
                Container(
                  child: events.length == 0
                      ? Center(
                          child: Text("No events to be shown"),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: events.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (currEvent.eventId == events[index].eventId) {
                              return GestureDetector(
                                onLongPress: () {
                                  print(events[index].name);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => ConfirmationCard(
                                      content:
                                          'Are you sure you want to delete the event',
                                      onPressed: () {
                                        print(
                                            'Deleting event: ${events[index].eventId}');
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                child: PhotoCard(
                                  tileTitle: events[index].name,
                                  tileImage: 'images/orgPng.png',
                                  tileTrailing: null,
                                  bgColor: BColors.activeCardColor,
                                ),
                              );
                            }
                            return GestureDetector(
                              onLongPress: () {
                                print(events[index].name);
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => ConfirmationCard(
                                    content:
                                        'Are you sure you want to delete the event',
                                    onPressed: () {
                                      print(
                                          'Deleting event: ${events[index].eventId}');
                                      _deleteEvent(
                                          model, events[index], context);
                                    },
                                  ),
                                );
                              },
                              onTap: () => currEventChange(events[index]),
                              child: PhotoCard(
                                tileTitle: events[index].name,
                                tileImage: 'images/orgPng.png',
                                tileTrailing: null,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteEvent(
    MainModel model,
    Event event,
    BuildContext context,
  ) async {
    var response = await model.deleteEvent(event.eventId, orgToken);
    if (response['code'] == 200) {
      Navigator.pop(context);
      ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.homePage);
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(),
      );
    }
  }
}
