import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../models/global.dart';
import '../util.dart';
import 'package:toast/toast.dart';
import '../models/organization.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class JoinOrganization extends StatefulWidget {
  String token;
  JoinOrganization(this.token);

  @override
  State<StatefulWidget> createState() {
    return JoinOrganizationState(token);
  }
}

class JoinOrganizationState extends State<JoinOrganization> {
  bool hide = false;
  String search;
  String token;

  JoinOrganizationState(this.token);
  TextEditingController editingController;

  Requests requests = null;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model){
            return Scaffold(
          body: SingleChildScrollView(
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 50, right: 16, left: 16, bottom: 16),
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey[400],
                              offset: Offset(0.5, 0.5),
                              blurRadius: 10.0,
                            ),
                          ],
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextField(
                        cursorColor: Colors.blue,
                        controller: editingController,
                        decoration: InputDecoration(
                          //                                    icon: Container( margin: EdgeInsets.all(5), child: Icon(Icons.search, color: Colors.black,),),
                          hintText: "Search Organization",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hide = true;

                                  editingController.clear();
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                });
                              },
                              child: Container(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                              )),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            hide = false;
                            search = value;
                            _SearchOption(value, model);
                          });
                        },
                      ),
                    ),
                    requests == null
                        ? Container()
                        : Container(
                            height: 300,
                            child: Container(
                                child: ListView.builder(
                                    itemCount: requests.requested.length,
                                    itemBuilder: (context, index) {
                                      print(requests.requested[index].fullName);
                                      return Container(
                                          decoration: continerDecor,
                                          padding: containerPad,
                                          margin: containerMargin,
                                          child: Column(children: <Widget>[
                                            Row(children: <Widget>[
                                              Flexible(
                                                child: requests.requested[index]
                                                            .photoUrl ==
                                                        "default_image"
                                                    ? Container(
                                                        margin: EdgeInsets.all(3),
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.blueAccent,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Text(
                                                          requests
                                                              .requested[index]
                                                              .fullName
                                                              .substring(0, 1)
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 21),
                                                        ),
                                                      )
                                                    : Container(
                                                        padding: EdgeInsets.only(
                                                            right: 20.0,
                                                            left: 30.0,
                                                            top: 16.0),
                                                        child: Image.asset(
                                                            requests
                                                                .requested[index]
                                                                .photoUrl,
                                                            width: 60.0,
                                                            height: 60.0,
                                                            fit: BoxFit.cover),
                                                      ),
                                                flex: 4,
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Text(
                                                          requests
                                                              .requested[index]
                                                              .fullName,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                                        Container(
                                                            child: Text(
                                                          requests
                                                              .requested[index]
                                                              .location,
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.grey,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontFamily:
                                                                  'Raleway'),
                                                        )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                        ),
                                                        Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              //                                                   GestureDetector(
                                                              //                                                       onTap: () {
                                                              ////                                                         _checkStatusToServer(
                                                              ////                                                             true.toString(),
                                                              ////                                                             request
                                                              ////                                                                 .requested[index]
                                                              ////                                                                 .id,index);
                                                              //                                                       },
                                                              //                                                       child: Container(
                                                              //                                                         width: 100,
                                                              //                                                         margin: EdgeInsets.only(
                                                              //                                                             left: 16),
                                                              //                                                         padding: EdgeInsets
                                                              //                                                             .only(top: 3,
                                                              //                                                             bottom: 3,
                                                              //                                                             left: 10,
                                                              //                                                             right: 10),
                                                              //                                                         decoration: new BoxDecoration(
                                                              //                                                             border: Border.all(
                                                              //                                                               width: 1.0,
                                                              //                                                               color: Colors
                                                              //                                                                   .green,),
                                                              //                                                             borderRadius: new BorderRadius
                                                              //                                                                 .all(
                                                              //                                                                 Radius.circular(
                                                              //                                                                     10.0)),
                                                              //                                                             color: Colors
                                                              //                                                                 .green),
                                                              //                                                         child: Row(
                                                              //                                                           mainAxisAlignment: MainAxisAlignment
                                                              //                                                               .center,
                                                              //                                                           children: <Widget>[
                                                              //                                                             Container(
                                                              //                                                                 padding: EdgeInsets
                                                              //                                                                     .all(
                                                              //                                                                     3),
                                                              //                                                                 child: Text(
                                                              //                                                                   'Accept',
                                                              //                                                                   )
                                                              //                                                             )
                                                              //                                                           ],
                                                              //                                                         ),
                                                              //                                                       )),
                                                              //                                                       GestureDetector(
                                                              //                                                       onTap: () {
                                                              ////                                                         _checkStatusToServer(
                                                              ////                                                             false.toString(),
                                                              ////                                                             request
                                                              ////                                                                 .requested[index]
                                                              ////                                                                 .id,index);
                                                              //                                                       },
                                                              //                                                       child: Container(
                                                              //                                                         width: 100,
                                                              //                                                         margin: EdgeInsets.only(
                                                              //                                                             left: 16),
                                                              //                                                         padding: EdgeInsets
                                                              //                                                             .only(top: 3,
                                                              //                                                             bottom: 3,
                                                              //                                                             left: 10,
                                                              //                                                             right: 10),
                                                              //                                                         decoration: new BoxDecoration(
                                                              //                                                             border: Border.all(
                                                              //                                                               width: 1.0,
                                                              //                                                               color: Colors
                                                              //                                                                   .red,),
                                                              //                                                             borderRadius: new BorderRadius
                                                              //                                                                 .all(
                                                              //                                                                 Radius.circular(
                                                              //                                                                     10.0)),
                                                              //                                                             color: Colors.white),
                                                              //                                                         child: Row(
                                                              //                                                           mainAxisAlignment: MainAxisAlignment
                                                              //                                                               .center,
                                                              //                                                           children: <Widget>[
                                                              //                                                             Container(
                                                              //                                                                 padding: EdgeInsets
                                                              //                                                                     .all(
                                                              //                                                                     3),
                                                              //                                                                 child: Text(
                                                              //                                                                   'Reject',
                                                              //                                                                   )
                                                              //                                                             )
                                                              //                                                           ],
                                                              //                                                         ),
                                                              //                                                       )),
                                                            ])
                                                      ])),
                                              GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.translucent,
                                                  onTap: () {
                                                    sendRequest(requests
                                                        .requested[index]
                                                        .fullName, model);
                                                    //                                                         _checkStatusToServer(
                                                    //                                                             false.toString(),
                                                    //                                                             request
                                                    //                                                                 .requested[index]
                                                    //                                                                 .id,index);
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    margin: EdgeInsets.only(
                                                        left: 100),
                                                    padding: EdgeInsets.only(
                                                        top: 3,
                                                        bottom: 3,
                                                        left: 10,
                                                        right: 10),
                                                    decoration: new BoxDecoration(
                                                        border: Border.all(
                                                          width: 1.0,
                                                          color: Colors.blue,
                                                        ),
                                                        borderRadius:
                                                            new BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color: backgroundColor),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                            padding:
                                                                EdgeInsets.all(3),
                                                            child: Text(
                                                              'Send',
                                                            ))
                                                      ],
                                                    ),
                                                  )),
                                            ])
                                          ]));
                                    })))
                  ]))));
          },
          // child: ,
    );
  }

  _SearchOption(String res, MainModel model) {
    Future fetchPosts(http.Client client) async {
      // var response = await http.get(URL_SEARCHORG + "$res");
      // print(response.body);
      // print(response.statusCode);
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   print(data);
      //   if (this.mounted) {
      //     setState(() {
      //       requests = Requests.fromJson(data);

      //       print(requests.requested[0].fullName);
      //     });
      //   }
      // }
      var response;
      var a=model.searchOrg(res, token);
      await a.then((res){
        // print(res);
        response=res;
      });
      if (response["code"] == 200) {
        // final data = json.decode(response.body);
        // print(data);
        var data=response;
        if (this.mounted) {
          setState(() {
            print("Setting State!");
            requests = Requests.fromJson(data);
            // print(requests.requested[0].fullName);
          });
        }
      }
    }

    return FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  sendRequest(String res, MainModel model) {
    Future fetchPosts(http.Client client) async {
      // var response = await http
      //     .get(URL_SENDREQUEST + '$res', headers: {"Authorization": "$token"});
      // print(response.body);
      // print(response.statusCode);
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   print(data);
      //   if (data["data"] == "A join request is already pending") {
      //     Toast.show("Joinig request is already pending", context,
      //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //   } else if (data["data"] == null) {
      //     Toast.show("Joining Request Sent", context,
      //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //   } else {
      //     Toast.show("Try Again", context,
      //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //   }
      // }

      var a=model.sendReqToOrg(token, requests.requested[0].org_id, requests.requested[0].website);
      var response;
      await a.then((res){
        // print("<__>");
        // print(res);
        // print(res["code"]);
        response=res;
      });
      // if (response.statusCode == 200) {
      if (response["code"] == 200) {
        // final data = json.decode(response.body);
        // print(data);
        var data=response;
        if(data["message"]=="Join request created successfully")
         {
           Toast.show("Joining Request Sent!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
           Navigator.of(context).pushReplacementNamed('/homepage');
         }
        else{
          Toast.show("Joining Request Sent!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        // if (data["data"] == "A join request is already pending") {
        //   Toast.show("Joining request is already pending", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // } else if (data["data"] == null) {
        //   Toast.show("Joining Request Sent", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // } else {
        //   Toast.show("Try Again", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // }
      }
      else if(response["code"]==409){
          Toast.show("Joining request is already pending", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      else{
          Toast.show("Try Again", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }

    return FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
