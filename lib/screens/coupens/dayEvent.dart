import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/readApi1.dart';
import '../../models/global.dart';
import '../../screens/coupens/markAttendee.dart';
import '../../models/readApi.dart';

class DayCoupenPage extends StatefulWidget {
  RS1 events;
  int pos;

  DayCoupenPage(this.pos, this.events);
  @override
  @override
  State<StatefulWidget> createState() {
    return _DayCoupenPage(events, pos);
  }
}

class _DayCoupenPage extends State<DayCoupenPage> {
  RS1 events;
  int pos;

  _DayCoupenPage(this.events, this.pos);
  String selectedgender;

  String name;
  String day;
  String des;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mark Attendee',
          textAlign: TextAlign.center,
        ),
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
                            hintText: 'eg: 1',
                            labelText: 'Day',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: Number,
                          onSaved: (String val) {
                            day = val;
                          },
                        ))),
                Container(
                    padding: EdgeInsets.all(16),
                    child: new RaisedButton(
                      elevation: 5,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Mark Attendence',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _sendToServer();
                      },
                    ))
              ]))
        ]));
  }

  String Number(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Day is Required";
    } else if (value.length > 3) {
      return "Enter valid Day Number";
    } else if (!regExp.hasMatch(value)) {
      return "Day must be digits";
    }
    return null;
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

  void _mark(int day) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarkScreen(day, events)),
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      String eve = events.name.toString();
      print(name);
      var dd = int.parse(day);
      _mark(dd);
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
