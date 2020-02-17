import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/readApi1.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';

class CreateAttendeePage extends StatefulWidget {
  RS1 events;
  int pos;

  CreateAttendeePage(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _CreateAttendeePage(events, pos);
  }
}

class _CreateAttendeePage extends State<CreateAttendeePage> {
  RS1 events;
  int pos;

  _CreateAttendeePage(this.events, this.pos);
  String selectedgender;

  String name;
  String reg;
  String email;
  String mob;
  String gend;
  String orgToken;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  Map<String, dynamic> body = {
    "details": {
      "name": "angad sharma",
      "registrationNumber": "17BBE1010",
      "email": "SDADAS@A.COM",
      "phoneNumber": "919191991911",
      "gender": "M",
      "eventsAttended": "ALL",
      "eventName": "DEVSOC"
    }
  };

  List _gender = ["Male", "Female", "Other"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedGender;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedGender = _dropDownMenuItems[0].value;
    _getOrgToken();
  }

  void _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    String _orgToken=await model.getOrgToken();
    setState(() {
      orgToken=_orgToken;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(value: gender, child: new Text(gender)));
    }
    return items;
  }

  String newValue;

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: new Form(
            key: _key,
            autovalidate: _validate,
            child: FormUI(model),
          ),
        );
      },
          // child: ,
    );
  }

  Widget FormUI(MainModel model) {
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
                  "Form",
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
            ),
          ),
          SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                    child: new Theme(
                        data: new ThemeData(
                          primaryColor: Theme.of(context).accentColor,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'What People call you?',
                            labelText: 'Full Name',
                          ),
                          controller: myController,
                          validator: validateName,
                          onSaved: (String val) {
                            name = myController.text.toString();
                          },
                        ))),
                Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: new Theme(
                        data: new ThemeData(
                          primaryColor: Theme.of(context).accentColor,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '17BCE0987',
                              labelText: 'Registration Number'),
                          onSaved: (String val) {
                            reg = val;
                          },
                        ))),
                Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Theme.of(context).accentColor,
                      ),
                      child: new TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Email ID',
                            labelText: 'Email ID',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          onSaved: (String val) {
                            email = val;
                          }),
                    )),
                Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: new Theme(
                        data: new ThemeData(
                          primaryColor: Theme.of(context).accentColor,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Where your Friends can call you?',
                              labelText: 'Mobile Number'),
                          keyboardType: TextInputType.phone,
                          validator: validateMobile,
                          onSaved: (String val) {
                            mob = val;
                          },
                        ))),
                ListTile(
                  title: const Text('Gender'),
                  trailing: new DropdownButton<String>(
                      hint: Text('Choose'),
                      onChanged: (String changedValue) {
                        newValue = changedValue;
                        setState(() {
                          // newValue;
                          gend = newValue;
                        });
                      },
                      value: newValue,
                      items: <String>['Male', 'Female', 'Other']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList()),
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: new RaisedButton(
                      elevation: 5,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _sendToServer(model);
                      },
                    ))
              ]))
        ]));
  }

  void changedDropDownItem(String selectedgender) {
    setState(() {
      _selectedGender = selectedgender;
    });
  }

  void _processData() {
    // Process your data and upload to server
    _key.currentState?.reset();
    Navigator.of(context).pop();
    //widget.key?.currentState?.reset();
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  _sendToServer(MainModel model) {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      String eve = events.name.toString();
      // body["details"]["name"] = '$name';
      // body["details"]["registrationNumber"] = '$reg';
      // body["details"]["email"] = '$email';
      // body["details"]["phoneNumber"] = '$mob';
      // body["details"]["gender"] = '$gend';
      // body["details"]["eventName"] = '$eve';

      Future fetchPosts(http.Client client) async {
        // var response=await http.post(URL_CREATEATTENDEE, body: json.encode(body));
        var a=model.createParticipant(name, reg, email, gend, mob, events.eventId, orgToken);
        var response;
        // print("<__>");
        // print(a);
        await a.then((res){
          // print(res);
          response=res;
        });
        // print("Printing response in createAttendePage.dart");
        // print(response);
        if (response['code'] == 200) {
          Toast.show("User Created", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          _processData();
        } else {
          Toast.show("User not created, Try Again", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        // final data = json.decode(response.body);
        // print(data['rs']);
        // if (data['error'] == null) {
        //   Toast.show("User Created", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //   _processData();
        // } else {
        //   Toast.show("User not created, Try Again", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // }
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
              //     Fluttertoast.showToast(
              // msg: "Check Your Connection",
              // toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.BOTTOM,
              // timeInSecForIos: 1,
              // backgroundColor: Colors.grey[700],
              // textColor: Colors.white);
            }
          });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
