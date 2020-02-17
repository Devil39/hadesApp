import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../screens/attendeScreens/createAttendeePage.dart';
import '../../screens/attendeScreens/readAttendeePage.dart';
import '../../userDataMangment.dart';
import '../../util.dart';
import '../../models/global.dart';

class MailSpecificScreen extends StatefulWidget {
  RS1 events;
  int pos;
  MailSpecificScreen({this.pos,this.events});
  @override
  State<StatefulWidget> createState() {
    return _Screen(events: events,pos: pos);
  }
}

class _Screen extends State<MailSpecificScreen> {

  RS1 events;
  int pos;

  _Screen({this.events, this.pos});

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;


  bool _load = false;
  SharedPreferencesTest s = new SharedPreferencesTest();

  String token = '';
  String _result;

  String bodye;
  int _radioValue = 0;
  String name = "";

String subject='';
String mailTo='';
String mailBody='';
  Map<String, dynamic> body =
  {
    "eventName": "Developer 1O1",
    "mailSubject": "test",
    "mailBody": "# Prateek",
    "isMarkdown": false,
    "customMail":"",

  };

  bool isSwitched=false;
  @override
  void initState() {
    name = events.name;
    super.initState();
    Future<String> tok = s.getToken();
    tok.then((res) {
      setState(() {
        token = res;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Specific"),
      centerTitle: true,
      elevation: 0.0,


    ),
      body: new Form(
        key: _key,
        autovalidate: _validate,
        child: FormUI(),
      ),
    );
  }

  Widget FormUI() {
    int flag;
    return Container(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "To",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        )),
                  ],
                ),),
              SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: new Theme(
                                data: new ThemeData(
                                  primaryColor: Theme
                                      .of(context)
                                      .accentColor,

                                ),
                                child:
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),


                                  ),
onSaved: (val){
             mailTo=val;
},
                                )
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Subject",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),),
                        Container(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: new Theme(
                                data: new ThemeData(
                                  primaryColor: Theme
                                      .of(context)
                                      .accentColor,

                                ),
                                child:
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),


                                  ),
onSaved: (val){
                                    subject=val;
},
                                )
                            )),
                        Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Body",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),),
                        Container(
                          height: 200,
//            color: backgroundColor,
                          margin: EdgeInsets.only(left:16.0,right: 16),
                          child: new ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 200.0,
                            ),
                            child: new Scrollbar(
                              child: new SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: SizedBox(
                                  height: 190.0,
                                  child: Theme(
                                      data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,

                                      ),child: new TextFormField(
                                    maxLines: 3000,
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(),

                                    ),
                                    onSaved: (String val) {
                                      mailBody=val;
                                    },
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16,right: 8),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Markdown"),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeTrackColor: Colors.blueAccent,
                                activeColor: Colors.blue,
                              ),
                            ],
                          ),),

                        Container(padding: EdgeInsets.only(left: 16,bottom: 16),
                            child:
                            new RaisedButton(
                              elevation: 5,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      10.0)),
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              child: Text('Submit',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                sendtoserver();
                              },))

                      ]))
            ])


    );
  }

//     sendtoserver()
//    {
//       _key.currentState?.reset();
//    Navigator.of(context).pop();
//    }

  sendtoserver() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        _load = true;
      });

      Future fetchPosts(http.Client client) async {
        print("yjhtgfdsyutrgds");
        body["mailSubject"] = '$subject';
        body["mailBody"] = '$mailBody';
        body['eventName'] = '$name';
        body['customMail']='$mailTo';
        body['isMarkdown']=isSwitched;
        print(body);
        print(token);
        print(json.encode(body));

        var response = await http.post(
          URL_SPECIFIC_MAIL+mailTo, headers: {"x-access-token": "$token",
          "Content-Type": "application/json"},
          body: json.encode(body),);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print(data);
          if (data["status"].compareTo("success") == 0) {
            setState(() {
              _load = false;
            });
            Navigator.of(context).pop();
            Toast.show("Mails Sent", context, duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
          }
          else {
            Toast.show(
                "Some Error Occured", context, duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
            setState(() {
              _load = false;
            });
          }
        }
        else {
          setState(() {
            _load = false;
          });
          Toast.show("Try Again", context, duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);
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
            }
            else {
              return Container();
            }
          });
    }


    else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
