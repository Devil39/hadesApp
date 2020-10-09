import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../models/organization.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/dimens.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/photo_card.dart';
import '../../utils/router.gr.dart';

class JoinOrgListPage extends StatefulWidget {
  const JoinOrgListPage({this.from = 'login'});

  final String from;

  @override
  _JoinOrgListPageState createState() => _JoinOrgListPageState();
}

class _JoinOrgListPageState extends State<JoinOrgListPage> {
  @override
  initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  bool loading = true, search = false;

  List<Organization> _orgs = null;
  List<Organization> filteredOrgs = [];

  List<TargetFocus> targets = List();

  GlobalKey _searchBar = GlobalKey();
  GlobalKey _createButton = GlobalKey();

  void _initializePage(MainModel model) async {
    Future.delayed(const Duration(milliseconds: 180), () async {
      String token = await model.getToken();
      final result = await model.getAllOrg(token);
      List<Organization> orgs =
          Requests.fromJson(result, key: "orgs").requested;
      setState(() {
        loading = false;
        _orgs = orgs;
      });
      bool showTutorial = await model.showJoinCreateOrgTutorial();
      if (showTutorial) {
        _initTutorial();
      }
    });
  }

  void _initTutorial() {
    targets.add(makeTarget(
      key: _searchBar,
      align: AlignContent.bottom,
      title: 'Search organizations',
      desc: 'Search for any organization fuzzily!',
      shapeLightFocus: ShapeLightFocus.RRect,
    ));
    targets.add(makeTarget(
      key: _createButton,
      align: AlignContent.top,
      title: 'Create a new organization',
      desc: 'New to Hades or did not find your organization, let\'s make one!',
      shapeLightFocus: ShapeLightFocus.Circle,
    ));
    showTutorial(targets: targets);
  }

  void showTutorial({@required List<TargetFocus> targets}) {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: BColors.grey,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      textStyleSkip: TextStyle(color: Colors.white),
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Container(
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 27.0),
          child: FloatingActionButton(
            onPressed: () {
              ExtendedNavigator.rootNavigator.popAndPushNamed(
                Routes.createOrgPage,
                arguments: CreateOrgPageArguments(
                  from: widget.from,
                ),
              );
            },
            backgroundColor: BColors.blue,
            child: Tooltip(
              message: "Create Organization",
              child: Icon(
                Icons.add,
                color: BColors.white,
                size: Dimens.floatingActionButtonIconSize,
                key: _createButton,
              ),
            ),
          ),
        ),
        appBar: Header(
          title: 'HADES',
          leading: widget.from == 'home'
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: BColors.blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : Container(),
          actionsList: [
            IconButton(
              onPressed: () {
                if (widget.from == 'home') {
                  ExtendedNavigator.rootNavigator.pop();
                }
                ExtendedNavigator.rootNavigator.pushReplacementNamed(
                  Routes.getOrganizationPage,
                );
                //widget.from == 'home'
                //    ? ExtendedNavigator.rootNavigator.pushReplacementNamed(
                //        Routes.joinOrgListPage,
                //        arguments: JoinOrgListPageArguments(
                //          from: 'home',
                //        ),
                //      )
                //    : ExtendedNavigator.rootNavigator.pushReplacementNamed(
                //        Routes.joinOrgListPage,
                //      );
              },
              icon: Icon(
                Icons.refresh,
                color: BColors.blue,
              ),
            ),
            widget.from != 'home'
                ? IconButton(
                    onPressed: () {
                      model.resetUserInfo();
                      ExtendedNavigator.rootNavigator
                          .popAndPushNamed(Routes.loginPage);
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: BColors.blue,
                    ),
                  )
                : Container(),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 27.0,
                  vertical: 12.0,
                ),
                child: Text(
                  'Organizations',
                  style: TextStyle(
                    fontSize: Dimens.headingTextSize,
                    color: BColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  margin: EdgeInsets.only(bottom: 27.0),
                  child: Material(
                    elevation: 6.0,
                    shadowColor: BColors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    child: TextField(
                      key: _searchBar,
                      onChanged: (searchText) {
                        _searchOrgs(searchText);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 5.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: BColors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _orgs == null
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : _orgs.length == 0 || (search && filteredOrgs.length == 0)
                        ? Container(
                            child: Center(
                              child: Text(
                                search
                                    ? "No matching organizations!"
                                    : "No organizations to be shown!",
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _orgs != null
                                ? search
                                    ? filteredOrgs.length
                                    : _orgs.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return PhotoCard(
                                tileTitle: search
                                    ? filteredOrgs[index].fullName
                                    : _orgs[index].fullName,
                                tileImage: 'images/orgPng.png',
                                icon: Container(
                                  width: 50.0,
                                  height: 69.0,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: BColors.blue,
                                            size: 27.0,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: BColors.blue,
                                            size: 27.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                tileTrailing: null,
                                onPressed: () {
                                  ExtendedNavigator.rootNavigator.pushNamed(
                                    Routes.orgDetailPage,
                                    arguments: JoinOrgDetailPageArguments(
                                      org: search
                                          ? filteredOrgs[index]
                                          : _orgs[index],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      );
    });
  }

  TargetFocus makeTarget({
    GlobalKey key,
    AlignContent align,
    String title,
    String desc,
    ShapeLightFocus shapeLightFocus,
  }) {
    return TargetFocus(
      identify: "Target $key",
      keyTarget: key,
      contents: [
        ContentTarget(
            align: align,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BColors.black,
                      fontSize: 24.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      desc,
                      style: TextStyle(
                        color: BColors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: shapeLightFocus,
    );
  }

  void _searchOrgs(String searchText) {
    filteredOrgs = [];
    if (searchText != "") {
      setState(() {
        search = true;
      });
      searchText = searchText.trim();
      for (int i = 0; i < _orgs.length; i++) {
        //if(_orgs[i].fullName.toLowerCase().contains(searchText.toLowerCase())) {
        //  filteredOrgs.add(_orgs[i]);
        //  continue;
        //}
        //if(_orgs[i].website.toLowerCase().contains(searchText.toLowerCase())) {
        //  filteredOrgs.add(_orgs[i]);
        //  continue;
        //}
        //if(_orgs[i].description.toLowerCase().contains(searchText.toLowerCase())) {
        //  filteredOrgs.add(_orgs[i]);
        //  continue;
        //}
        //if(_orgs[i].location.toLowerCase().contains(searchText.toLowerCase())) {
        //  filteredOrgs.add(_orgs[i]);
        //  continue;
        //}
        if ((_orgs[i].fullName.toLowerCase() +
                _orgs[i].website.toLowerCase() +
                _orgs[i].location.toLowerCase() +
                _orgs[i].description.toLowerCase())
            .contains(searchText.toLowerCase())) {
          filteredOrgs.add(_orgs[i]);
        }
      }
    } else {
      setState(() {
        search = false;
      });
    }
  }
}
