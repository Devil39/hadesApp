import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/urls.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../createOrganisationPage.dart';
import '../screens/joinOrganization.dart';
import '../models/get_Organization.dart';
import '../userDataMangment.dart';
import '../util.dart';

class GetOrganizationPage extends StatefulWidget {

  bool skip;

  GetOrganizationPage({this.skip=true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GetOrganizationPageState();
  }
}

class GetOrganizationPageState extends State<GetOrganizationPage> {
  SharedPreferencesTest s = new SharedPreferencesTest();

  String token = '';
  @override
  initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _getToken(model);
    // Future<String> tok = s.getToken();
    // tok.then((res) {
    //   setState(() {
    //     token = res;
    //   });
    // });
  }

  void _getToken(MainModel model) async {
    String _token=await model.getToken();
    setState(() {
      token=_token;
    });
  }

  toHomePage() {
    print("Redirecting to HomePage!");
    Navigator.of(context).pushReplacementNamed('/homepage');
  }

  Data _data;
  Future fetchPosts(http.Client client, MainModel model) async {
    if (token != '') {
//  var response=await http.get(URL_GETORG,headers:{"Authorization": "$token"} );
      // var response =
      //     await http.get(url_getOrgList, headers: {"Authorization": "$token"});
      var a=model.getOrgList(token);
      var response;
      // print("A: $a");
      await a.then((res){
        // print(res);
        response=res;
      });
      // print(response);
      // print(response["code"]);
      if (response["code"] == 200) {//.statusCode
        // final data = json.decode(response.body);
          // final data="";
          var data=response;
        //  if(data["message"].compareTo("Successful")==0) {//
        if (data["message"]
                .compareTo("Successfully retrieved user organizations") ==
                // .compareTo("Organizations retrieved successfully") ==
            0) {
          //  if (data["data"]["organizations"] == null) {
            // print(data["organizations"]);
          if (data["organizations"] == null || data["organizations"].length==0) {
          // if (data["orgs"] == null || data["orgs"].length==0) {
            print("Returning yo!");
            Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (BuildContext context) => JoinOrganization(token, widget.skip))
            );
            return "yo";
          } else {
            _data = Data.fromJson(data);
            //await model.setOrgList(_data);
            if(!widget.skip)
             {
               Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => JoinOrganization(token, widget.skip))
                );
               return "yo";
             }
            toHomePage();
            // return "yo";
            return _data;
          }
        }
      } else {
        return "Server Error";
      }
    }
  }

  toCreate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateOrganisationScreen()));
  }

  toJoin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => JoinOrganization(token, widget.skip)));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Container(
          color: backgroundColor,
          child: FutureBuilder(
              future: fetchPosts(http.Client(), model),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.data == "Server Error") {
                  return Container(
                    // decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15.0)
                    //       ),
                    child: Center(
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(9.0),
                          child: Text(
                          snapshot.data,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            // fontFamily: ''
                          ),
                      ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.data == "yo") {
                  return Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          "Hades",
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
//                IconButton(icon: Icon(Icons.check_box_outline_blank),onPressed: (){
//                  s.setLoginCheck(false);
//                  Navigator.of(context).popUntil((route) => route.isFirst);
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
//                },)
                        ],
                      ),
                      body: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Container(
                          //   child: 
                          // ),
                          GestureDetector(
                              onTap: () {
                                toJoin();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      height: 150,
                                      width: 150,
                                      margin: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey[400],
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              padding:
                                                  EdgeInsets.fromLTRB(8, 8, 8, 2),
                                              child: Icon(
                                                Icons.check_circle,
                                                size: 90,
                                                color: Colors.amber,
                                              )),
                                          Container(
                                              padding:
                                                  EdgeInsets.fromLTRB(8, 8, 8, 2),
                                              child: Text(
                                                "Join",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 16),
                                              ))
                                        ],
                                      )),
                                ],
                              )),
                          GestureDetector(
                              onTap: () {
                                toCreate();
                              },
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey[400],
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  margin: EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 8, 8, 2),
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 90,
                                            color: Colors.green,
                                          )),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 8, 8, 2),
                                          child: Text(
                                            "Create",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none,
                                                fontSize: 16),
                                          ))
                                    ],
                                  )))
                        ],
                      )));
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }));
      },
          // child: ,
    );
  }
}
