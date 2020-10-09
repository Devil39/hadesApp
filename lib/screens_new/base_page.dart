import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../models/event.dart';
import '../models/organization.dart';
import '../models/scoped_models/mainModel.dart';
import '../ui_utils/colors.dart';
import '../ui_utils/widgets/failure_card.dart';
import '../utils/router.gr.dart';
import 'joined_org_list_page.dart';
import 'notification_page.dart';
import 'participants_management/participants_management_option_list_page.dart';
import 'services_list_page.dart';
import 'settings_page.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _currPageIndex = PageController(initialPage: 0);
  int currPage = 0;

  String token, orgToken, userEmail = '';

  Organization currOrg;
  List<Organization> _orgs = [];

  bool loading = true;

  List<dynamic> joinReqs = [];

  Event currEvent;
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
  }

  void _initializePage(MainModel model) async {
    await _getToken(model);
    await _getAllUserOrgs(model);
    await _getOrgToken(model);
    await _getAllEvents(model);
    await _getAllJoinReqs(model);
    userEmail = await model.getUserEmail();
    setState(() {
      loading = false;
    });
  }

  void currEventChange(Event newEvent) {
    setState(() {
      currEvent = newEvent;
    });
  }

  void removeReqAtIndex(int index) {
    setState(() {
      joinReqs.removeAt(index);
    });
  }

  Future<void> _getAllEvents(MainModel model) async {
    var response = await model.getEventList(orgToken);
    if (response["code"] == 200) {
      final data = response;
      try {
        List<Event> events = new List<Event>();
        for (int i = 0; i < data["events"].length; i++) {
          events.add(Event.fromJson(data["events"][i]));
        }
        setState(() {
          currEvent = events[0];
          _events = events;
        });
      } catch (err) {
        //showDialog(
        //  context: context,
        //  barrierDismissible: true,
        //  builder: (context) => SuccessCard(),
        //);
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(
          onPressed: () {
            Navigator.pop(context);
            ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.loginPage);
          },
        ),
      );
    }
  }

  Future<void> _getAllJoinReqs(MainModel model) async {
    var a = await model.getAllReqOfOrg(
      orgToken,
      currOrg.org_id,
      currOrg.website,
    );
    setState(() {
      joinReqs = a['join_reqs'];
    });
  }

  void _getOrgToken(MainModel model) async {
    String _token = await model.getOrgToken();
    setState(() {
      orgToken = _token;
    });
  }

  Future<String> _getToken(MainModel model) async {
    String _token = await model.getToken();
    setState(() {
      token = _token;
    });
    return token;
  }

  Future<void> _getAllUserOrgs(MainModel model) async {
    var a = model.getOrgList(token);
    var org_id = await model.getCurrentOrgId();
    var response;
    await a.then((res) {
      response = res;
    });
    if (response["code"] == 200) {
      List<Organization> orgs =
          Requests.fromJson(response, key: "organizations").requested;
      setState(() {
        _orgs = orgs;
        if (_orgs.length != 0) {
          currOrg = orgs[0];
        }
      });
      for (int i = 0; i < orgs.length; i++) {
        if (orgs[i].org_id == org_id) {
          setState(() {
            currOrg = orgs[i];
          });
          break;
        }
      }
      await model.orgLogIn(token, currOrg.org_id);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(
          onPressed: () {
            Navigator.pop(context);
            ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.loginPage);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NotificationPage(
        currOrg: currOrg,
        orgToken: orgToken,
        joinReqs: joinReqs,
        removeReqAtIndex: removeReqAtIndex,
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
      body: loading
          ? Center(
              child: Container(
                child: const CircularProgressIndicator(),
              ),
            )
          : PageView(
              controller: _currPageIndex,
              onPageChanged: (_) {},
              children: [
                JoinedOrgListPage(
                  currOrg: currOrg,
                  orgs: _orgs,
                  currEvent: currEvent,
                  currEventChange: currEventChange,
                  events: _events,
                  scaffoldKey: scaffoldKey,
                  token: token,
                  orgToken: orgToken,
                  joinReqs: joinReqs.length,
                ),
                ServiceListPage(
                  currEvent: currEvent != null
                      ? currEvent
                      : Event(
                          budget: "dummy",
                          eventId: -1,
                          orgId: -1,
                          venue: "dummy",
                          days: -1,
                          category: "dummy",
                          description: "dummy",
                          name: "dummy",
                        ),
                ),
                ParticipantsManagementOptionListPage(
                  currEvent: currEvent != null
                      ? currEvent
                      : Event(
                          budget: "dummy",
                          eventId: -1,
                          orgId: -1,
                          venue: "dummy",
                          days: -1,
                          category: "dummy",
                          description: "dummy",
                          name: "dummy",
                        ),
                ),
                SettingsPage(
                  currEvent: currEvent != null
                      ? currEvent
                      : Event(
                          budget: "dummy",
                          eventId: -1,
                          orgId: -1,
                          venue: "dummy",
                          days: -1,
                          category: "dummy",
                          description: "dummy",
                          name: "dummy",
                        ),
                  userEmail: userEmail == '' ? 'user@email.com' : userEmail,
                ),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Material(
            //elevation: 9.0,
            //shadowColor: BColors.black,
            child: Container(
              color: BColors.backgroundBlue,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: BottomAppBar(
                //color: Colors.lightBlueAccent,
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currPage = 0;
                            _currPageIndex.jumpToPage(0);
                          });
                        },
                        icon: Icon(
                          Icons.apps,
                          color:
                              currPage == 0 ? BColors.lightBlue : BColors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: currEvent == null
                            ? () {
                                Toast.show(
                                  "Please create an event to continue",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                );
                                return null;
                              }
                            : () {
                                setState(() {
                                  currPage = 1;
                                  _currPageIndex.jumpToPage(1);
                                });
                              },
                        icon: Icon(
                          Icons.star,
                          color:
                              currPage == 1 ? BColors.lightBlue : BColors.grey,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      IconButton(
                        onPressed: currEvent == null
                            ? () {
                                Toast.show(
                                  "Please create an event to continue",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                );
                                return null;
                              }
                            : () {
                                setState(() {
                                  currPage = 2;
                                  _currPageIndex.jumpToPage(2);
                                });
                              },
                        icon: Icon(
                          Icons.person,
                          color:
                              currPage == 2 ? BColors.lightBlue : BColors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currPage = 3;
                            _currPageIndex.jumpToPage(3);
                          });
                        },
                        icon: Icon(
                          Icons.settings,
                          color:
                              currPage == 3 ? BColors.lightBlue : BColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: Container(
              // margin: EdgeInsets.only(
              //     left: MediaQuery.of(context).size.width * 0.425),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: currPage != 0 && currPage != 3
                    ? () {
                        return null;
                      }
                    : () {
                        ExtendedNavigator.rootNavigator.popAndPushNamed(
                          Routes.createEventPage,
                          arguments: CreateEventPageArguments(
                            org: currOrg,
                          ),
                        );
                      },
                fillColor: currPage != 0 && currPage != 3
                    ? BColors.grey
                    : BColors.blue,
                child: Icon(
                  Icons.add,
                  size: 39.0,
                  color: BColors.white,
                ),
                shape: CircleBorder(),
                constraints: BoxConstraints(
                  minWidth: 64.0,
                  minHeight: 64.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
