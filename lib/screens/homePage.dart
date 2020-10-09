//Organization Index

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:hades_app/screens/getOrganizationPage.dart';
import 'package:http/http.dart' as http;
// import 'package:permission/permission.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:random_pk/random_pk.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/util.dart';
import 'package:hades_app/screens/intermediateOrgLogin.dart';
import 'package:hades_app/models/readApi1.dart';
import '../models/readApi.dart';
import '../util.dart' as prefix0;
import '../models/global.dart';
import '../screens/login.dart';
import '../notificationScreen.dart';
import '../cards/eventCard.dart';
import '../models/get_Organization.dart';
import '../userDataMangment.dart';
import '../screens/createEventPage.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  final ThemeBloc themeBloc;

  HomePage({Key key, this.themeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState(
      themeBloc: themeBloc,
    );
  }
}

enum PermissionName {
  // iOS
  Internet,
  Storage
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  String orgName = '';
  bool _load = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  // Future<bool> _onWillPop() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => new AlertDialog(
  //       title: new Text('Are you sure?'),
  //       content: new Text('Do you want to exit an App'),
  //       actions: <Widget>[
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: new Text('No'),
  //         ),
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: new Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   ) ?? false;
  // }

  final ThemeBloc themeBloc;

  _HomePageState({Key key, this.themeBloc});

  // List<Organization> orgList;
  List<dynamic> orgList=[];

  SharedPreferencesTest s = new SharedPreferencesTest();

  String token = '';
  String orgToken = '';
  String _result;

  int _radioValue = 0;
  int orgIndex = 0;
  int orgId = 0;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    // Future<List<Organization>> org=s.getOrgList();
    // org.then((res){
    //   setState(() {
    //     orgIndex=0;
    //    orgList=res;
    //    orgName=res[orgIndex].name;
    //    print(orgName);
    //   });
    // });
    // Future<String> tok = s.getToken();
    // tok.then((res) {
    //   setState(() {
    //     token = res;
    //   });
    // });

    _getFunctions(model);
  }

  void _getFunctions(MainModel model) {
    _getOrgList(model);
    _getToken();
    _getOrgToken();
  }

  void _getOrgList(MainModel model) async {
    // Future<List<Organization>> org=s.getOrgList();
    // org.then((res){
    //   setState(() {
    //     orgIndex=0;
    //    orgList=res;
    //    orgName=res[orgIndex].name;
    //    print(orgName);
    //   });
    // });
    // print("Getting Lists!");
    var org = model.getStoredOrgList();
    var org_id_future = model.getCurrentOrgId();

    // print("Org_ID: $org_id_future");
    var org_id;
    await org_id_future.then((res) {
      // print("Something!");
      // print(res);
      org_id = res;
    });
    // orgIndex=0;
    //    org.then((res){
    //     // print("<__>");
    //     // print(res);
    //     setState(() {
    //       orgIndex=0;
    //       orgList=res;
    //       // print("OrgList: ");
    //       // print(orgList.length);
    //       orgName=res[orgIndex].name;
    //       orgId=res[orgIndex].orgId;
    //     });
    //   });
    if (org_id == null) {
      orgIndex = 0;
      org.then((res) {
        // print("<__>");
        // print(res);
        if (res != null) {
          setState(() {
            // orgIndex=0;
            orgList = res;
            // print("OrgList: ");
            // print(orgList.length);
            orgName = res[orgIndex].name;
            orgId = res[orgIndex].orgId;
          });
        }
      });
    } else {
      org.then((res) {
        // print("<__>");
        // print(res);
        setState(() {
          // orgIndex=0;
          orgList = res;
          for (int i = 0; i < orgList.length; i++) {
            if (orgList[i].orgId == org_id) {
              orgIndex = i;
              break;
            }
          }
          // print("OrgList: ");
          // print(orgList.length);
          orgName = res[orgIndex].name;
          orgId = res[orgIndex].orgId;
          // print("<__>");
          // print(res[orgIndex].name);
        });
      });
    }
    // print("orgIndex: $orgIndex");
  }

  void _getToken() async {
    MainModel model = ScopedModel.of(context);
    String _token = await model.getToken();
    setState(() {
      token = _token;
    });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          themeBloc.selectedTheme.add(_buildLightTheme());
          break;
        case 1:
          themeBloc.selectedTheme.add(_buildDarkTheme());
          break;
      }
    });
  }

  bool _enabled = false;
  Map<String, dynamic> body = {
    "query": {"key": "clubName", "value": "WTM", "organization": "WTM"}
  };

  void _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    // print("Getting Token in homePage!");
    String _orgToken = await model.getOrgToken(context: context);
    // print("Token:");
    // print(_token);
    setState(() {
      orgToken = _orgToken;
    });
  }

  Future fetchPosts(http.Client client) async {
    // if (token != '') {
    if (orgToken != '') {
      // var response = await http.post(
      //     URL_READEVENT, headers: {"Authorization": "$token"},
      //     body: json.encode(body));
      MainModel model = ScopedModel.of(context);
      var response;
      var a = model.getEventList(orgToken);
      // var b=model.getOrgDataById(orgId);
      await a.then((res) {
        // print(res);
        response = res;
      });
      if (response["code"] == 200) {
        // final data = json.decode(response.body);
        final data = response;

        // if (data["err"] == null) {
        //   if (data["rs"] != null) {
        //     print(data['rs'][0]);
        //     List<RS> products = new List<RS>();
        //     for (int i = 0; i < data['rs'].length; i++) {
        //       products.add(new RS.fromJson(data['rs'][i]));
        //       print(data['rs'][i]);
        //     }
        //     // print(products[0].clubName);
        //     // print(products[0].fromDate);
        //     return products;
        //   }
        //   else {
        //     // print("dwgvdkwejgv");
        //     return "No Data to be Fetched";
        //   }
        // }
        try {
          List<RS1> events = new List<RS1>();
          // print(data["events"]);
          // print(data["events"][0]);
          for (int i = 0; i < data["events"].length; i++) {
            // print(RS1.fromJson(data["events"][i]));
            events.add(RS1.fromJson(data["events"][i]));
          }
          return events;
        } catch (err) {
          // print("dwg");
          print("Error, while processing events: $err");
          return "No Data to be Fetched";
        }
      } else {
        // print("dkwejgv");
        return "No Data to be Fetched";
      }
      // print(response.body.toString());
      // print(response.statusCode);
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   if (data["err"] == null) {
      //     if (data["rs"] != null) {
      //       print(data['rs'][0]);
      //       List<RS> products = new List<RS>();
      //       for (int i = 0; i < data['rs'].length; i++) {
      //         products.add(new RS.fromJson(data['rs'][i]));
      //         print(data['rs'][i]);
      //       }
      //       print(products[0].clubName);
      //       print(products[0].fromDate);
      //       return products;
      //     }
      //     else {
      //       print("dwgvdkwejgv");
      //       return "No Data to be Fetched";
      //     }
      //   }

      //   else {
      //     return "No Data to be Fetched";
      //   }
      // }
      // else {
      //   return "No Data to be Fetched";
      // }
    }
  }

  bool remove = true;

  Widget buildBody(MainModel model) {
    Widget loadingIndicator = _load
        ? Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: RadialGradient(
                  stops: [0.1, 10],
                  colors: [
                    Colors.grey[200],
                    Colors.grey[400],
                  ],
                ),
              ),
              child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Center(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Center(
                        child: Text(
                          "Logging In...",
                          style: introText,
                        ),
                      ),
                    ],
                  )))),
            )))
        : new Container();
    return Stack(
      children: <Widget>[
        Container(
          color: prefix0.backgroundColor,
          child: FutureBuilder(
              future: fetchPosts(http.Client()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.data ==
                    'Server under Maintainence. Sorry, for Inconvinence.') {
                  // print(snapshot.data);
                  return Center(
                      child: Container(
                          child: Text(
                    snapshot.data,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  )));
                } else if (snapshot.data == "No Data to be Fetched") {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Hades',
                          textAlign: TextAlign.center,
                        ),
                        centerTitle: true,
                        elevation: 0.0,
                        // backgroundColor: Colors.grey[50],
                      ),
                      drawer: Drawer(
                          child: ListView(children: <Widget>[
                        Container(
                          // Column(
                            height: double.parse((90 * orgList.length).toString()),
                            // height: 0,
                                // MediaQuery.of(context).size.height*0.7,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.black
                            //   )
                            // ),
                            child: Container(
                              child: Text("Something"),
                            ),
                                ),

//                              Container(
//                                child:
//                                Row(
//                                  children: <Widget>[
//                                    Flexible(child: Container(
//                                      padding: EdgeInsets.only(
//                                          left: 16, right: 150),
//                                      child: Text("Light Theme"),), flex: 5,),
//                                    Flexible(child: Radio(
//
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ), flex: 1,)
//                                  ],
//                                ),),
//
//
//                              Container(
//                                child:
//                                Row(
//                                  children: <Widget>[
//                                    Flexible(child: Container(
//                                      padding: EdgeInsets.only(
//                                          right: 150, left: 16),
//                                      child: Text("Dark Theme"),), flex: 5,),
//                                    Flexible(child: Radio(
//
//                                      value: 1,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ), flex: 1,)
//                                  ],
//                                ),),
//
                        IconButton(
                          icon: Icon(Icons.check_box_outline_blank),
                          onPressed: () {
                            // s.setLoginCheck(false);
                            // model.resetUserInfo();
                            //Navigator.of(context)
                               // .popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                            print("Logging in the organization: $orgId");
                            setState(() {
                              // _load=true;
                            });
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => LoginScreen()));
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => OrgLoginScreen()));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        IntermediateOrgLogin(orgId: orgId)));
                          },
                        )
                      ])),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateEventPage(orgId: orgId)),
                          );
                        },
                        child: Icon(
                          Icons.add,
                        ),
                        heroTag: "Add Event",
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      ),
                      body: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child:
                                        // orgList[orgIndex].tag == "default_image"
                                        true
                                            ? Container(
                                                margin: EdgeInsets.all(16),
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  orgList[orgIndex]
                                                      .name
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    right: 20.0,
                                                    left: 30.0,
                                                    top: 16.0),
                                                child: Image.asset(
                                                    orgList[orgIndex].tag,
                                                    width: 90.0,
                                                    height: 90.0,
                                                    fit: BoxFit.cover),
                                              ),
                                    flex: 4,
                                  ),
                                  Flexible(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 40),
                                                    child: Text(
                                                      orgList[orgIndex].name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                flex: 1),
                                            Flexible(
                                                child: Text(
                                                  orgList[orgIndex].location,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                flex: 1),
                                          ]),
                                      flex: 6),
                                ]),
                            flex: 3,
                          ),
                          Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(top: 16, left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          "Events",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        flex: 15,
                                      ),
                                      Flexible(
                                          child: IconButton(
                                              icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.grey,
                                          )),
                                          flex: 1),
                                    ],
                                  )),
                              flex: 1),
                          Flexible(
                              child: Center(
                                  child: Container(
                                child: Text("No Events"),
                              )),
                              flex: 8),
                        ],
                      )));
                } else {
                  //  print(snapshot.data);
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Hades',
                          textAlign: TextAlign.center,
                        ),
                        centerTitle: true,
                        elevation: 0.0,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NotificationScreen(orgName, token),
                                ),
                              );
                            },
                          )
                        ],
                        // backgroundColor: Colors.grey[50],
                      ),
                      drawer: Drawer(
                          child: ListView(children: <Widget>[
                        Container(
                            height:
                                double.parse((90 * orgList.length).toString()),
                            child: ListView.builder(
                                itemCount: orgList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        // setState(() async {
                                        //   orgIndex=index;
                                        // });
                                        setState(() {
                                          orgIndex = index;
                                          orgName = orgList[index].name;
                                          orgId = orgList[index].orgId;
                                          model.setCurrentOrgId(orgId);
                                        });
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                        print(
                                            "Logging in the organization: $orgId");
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        IntermediateOrgLogin(
                                                            orgId: orgId)));
                                      },
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child:
                                                  // orgList[orgIndex].tag ==
                                                  //         "default_image"
                                                  true
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  16),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors
                                                            //     .blueAccent,
                                                            color: RandomColor
                                                                .next(),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            // orgList[orgIndex]
                                                            orgList[index]
                                                                .name
                                                                .substring(0, 1)
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                color: Colors.white
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20.0,
                                                                  left: 30.0,
                                                                  top: 16.0),
                                                          child: Image.asset(
                                                              orgList[orgIndex]
                                                                  .tag,
                                                              width: 90.0,
                                                              height: 90.0,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                              flex: 4,
                                            ),
                                            Flexible(
                                              child: Text(
                                                orgList[index].name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              flex: 3,
                                            )
                                          ],
                                        ),
                                      ));
                                })),

//
//           Container(
//         child:
//           Row(
//             children: <Widget>[
//              Flexible(child:Container(
//                padding: EdgeInsets.only(left:16,right: 150),
//                child: Text("Light Theme"),),flex:5,)  ,
//                       Flexible(child: Radio(
//
//        value: 0,
//        groupValue: _radioValue,
//        onChanged: _handleRadioValueChange,
//      ),flex: 1,)
//             ],
//           ),),
//
//
//       Container(
//         child:
//           Row(
//             children: <Widget>[
//              Flexible(child:Container(
//                padding: EdgeInsets.only(right: 150,left: 16),
//                child: Text("Dark Theme"),),flex:5,)  ,
//                       Flexible(child: Radio(
//
//        value: 1,
//        groupValue: _radioValue,
//        onChanged: _handleRadioValueChange,
//      ),flex: 1,)
//             ],
//           ),),
                        Container(
                          // child: IconButton(
                          //   icon: Icon(Icons.check_box_outline_blank),
                          //   onPressed: () {
                          //     // print("Second wala LoginScreen option!");
                          //     // s.setLoginCheck(false);
                          //     // Navigator.of(context).popUntil((route) => route.isFirst);
                          //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          //     Navigator.of(context)
                          //         .popUntil((route) => route.isFirst);
                          //     print("Logging in the organization: $orgId");
                          //     model.resetUserInfo();
                          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          //     // Navigator.pushReplacement(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (BuildContext context) =>
                          //     //             IntermediateOrgLogin(orgId: orgId)));
                          //   },
                          // ),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              print("Logging in the organization: $orgId");
                              model.resetUserInfo();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen()));
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              // model.resetUserInfo();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          GetOrganizationPage(skip: false)));
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Create/Join Org",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEventPage()),
                          );
                        },
                        child: Icon(
                          Icons.add,
                        ),
                        heroTag: "Add Event",
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      ),
                      body: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child:
                                        // orgList[orgIndex].tag == "default_image"
                                        true
                                            ? Container(
                                                margin: EdgeInsets.all(16),
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  orgList[orgIndex]
                                                      .name
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    right: 20.0,
                                                    left: 30.0,
                                                    top: 16.0),
                                                child: Image.asset(
                                                    orgList[orgIndex].tag,
                                                    width: 90.0,
                                                    height: 90.0,
                                                    fit: BoxFit.cover),
                                              ),
                                    flex: 4,
                                  ),
                                  Flexible(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 40),
                                                    child: Text(
                                                      orgList[orgIndex].name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                flex: 1),
                                            Flexible(
                                                child: Text(
                                                  orgList[orgIndex].location,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                flex: 1),
                                          ]),
                                      flex: 6),
                                ]),
                            flex: 3,
                          ),
                          Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(top: 16, left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          "Events",
                                          style: TextStyle(
                                              // fontSize: 15.0,
                                              // fontWeight: FontWeight.w400,
                                              // color: Colors.grey),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        flex: 15,
                                      ),
                                      // Flexible(
                                      //     child: IconButton(
                                      //         icon: Icon(
                                      //       Icons.arrow_drop_down,
                                      //       color: Colors.grey,
                                      //     )),
                                      //     flex: 1),
                                    ],
                                  )),
                              flex: 1),
                          Flexible(
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                padding: const EdgeInsets.only(
                                    bottom: 16, left: 16, right: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  return EventCard(
                                      snapshot.data[index], index, orgName);
                                },
                              ),
                              flex: 8),
                        ],
                      )));
                }
              }),
        ),
        new Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    );
  }

  Widget _loadingIndicator() {
    // print("Changing state of loading indicator!");
    // print(_load);
    return _load
        ? Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: RadialGradient(
                  stops: [0.1, 10],
                  colors: [
                    Colors.grey[200],
                    Colors.grey[400],
                  ],
                ),
              ),
              child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Center(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "Logging In...",
                        style: introText,
                      )
                    ],
                  )))),
            )))
        : new Container();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return buildBody(model);
      },
      // child: ,
    );
  }

  @override
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.blue,
          backgroundColor: Colors.grey[50],
          primaryColor: Colors.grey[50],
        ));
  }

  @override
  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.purple,
            primaryColor: Colors.grey[850],
            backgroundColor: Colors.grey[850]));
  }
}


/*ListView.builder(
                                itemCount: orgList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () async {
                                        await setState(() {
                                          orgIndex = index;
                                          orgName = orgList[index].name;
                                          orgId = orgList[index].orgId;
                                          model.setCurrentOrgId(orgId);
                                        });
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                        // print("Logging in the organization: $orgId");
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        IntermediateOrgLogin(
                                                            orgId: orgId)));
                                      },
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child:
                                                  // orgList[orgIndex].tag =="default_image"
                                                  // || orgList[orgIndex].tag==null || orgList[orgIndex].tag==""
                                                  true
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  16),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .blueAccent,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            orgList[orgIndex]
                                                                .name
                                                                .substring(0, 1)
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20.0,
                                                                  left: 30.0,
                                                                  top: 16.0),
                                                          // child: Image.asset(orgList[orgIndex].tag,
                                                          child: Image.asset(
                                                              "imageAssets/orgPng.png",
                                                              width: 90.0,
                                                              height: 90.0,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                              flex: 4,
                                            ),
                                            Flexible(
                                              child: Text(
                                                orgList[index].name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              flex: 3,
                                            )
                                          ],
                                        ),
                                      ));
                                }),*/
