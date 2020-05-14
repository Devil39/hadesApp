import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hades_app/screens/intermediateOrgLogin.dart';
//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../userDataMangment.dart';
import '../models/global.dart';

class CreateEventPage extends StatefulWidget{
  String orgName;
  int orgId;

  CreateEventPage({this.orgName, this.orgId});

  @override
  _CreateEventPage createState()=>_CreateEventPage();   
  }
  
  class _CreateEventPage extends State<CreateEventPage> {
    String orgName;
    int orgId;

    _CreateEventPage({this.orgName, this.orgId});
    final formats = {
      //InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
      // InputType.date: DateFormat('yyyy-MM-dd'),
      // InputType.time: DateFormat("HH:mm"),
    };

    // Changeable in demo
    // InputType inputType1 = InputType.date;
    // InputType inputType2 = InputType.time;

    final myController = TextEditingController();
    final myController2 = TextEditingController();

    String orgToken;

    bool editable = true;
    DateTime fromdate;
    DateTime fromTime;
    DateTime toDate;
    DateTime toTime;

    String clubName;
    String eventName;
    String budget;
    String description;
    String category;
    String venue;
    String attendence;
    String expectedParticipants;
    String facultyNmae;
    String facRegNo;
    String facemail;
    String facphoneNumber;
    String facgend;
    String stuName;
    String stuReg;
    String stuEmail;
    String stugend;
    String stuPhoneNumber;

    String proRequest;
    String campeng;
    String duration;
    String sponName;
    String sponEmail;
    String sponPhn;
    String spongend;
    String sponstake;
    String sponloc;


    GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

    Map<String, dynamic> body = {
      "event": {
        "clubName": "WTM",
        "name": "womentechies",
        "toDate": "10TH OCTOBER",
        "fromDate": "8TH OCTOBER",
        "toTime": "10 PM",
        "fromTime": "11 AM",
        "budget": "200000",
        "description": "TECHNICAL EVENT AT GDG VIT. ITS GONNA BE AMAZING",
        "category": "TECHNICAL",
        "venue": "ANNA AUDI",
        "attendance": "4000",
        "expectedParticipants": "4000",
        "facultyCoordinator": {
          "name": "NOORU MAA",
          "registrationNumber": "17BBE1010",
          "email": "SDADAS@A.COM",
          "phoneNumber": "919191991911",
          "gender": "M",
          "eventsAttended": "ALL"
        },
        "studentCoordinator": {
          "name": "NOOR",
          "registrationNumber": "17BBE1010",
          "email": "SDADAS@A.COM",
          "phoneNumber": "919191991911",
          "gender": "M",
          "eventsAttended": "ALL"
        },
        "PROrequest": "SAJDOOSIJANDFSAKFDSAFD",
        "campusEngineerRequest": "SDFHBSADUB, ASNFD , AS KDFSAM FDSA, AS, SD",
        "duration": "16 hours",
      }
    };


    String gend;

    List _gender =
    ["Male", "Female", "Other"];

    List<DropdownMenuItem<String>> getDropDownMenuItems() {
      List<DropdownMenuItem<String>> items = new List();
      for (String gender in _gender) {
        items.add(new DropdownMenuItem(
            value: gender,
            child: new Text(gender)
        ));
      }
      return items;
    }

    String newValue;
    String newValue1;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // Future<String> tt = s.getToken();
      // tt.then((value) {
      //   setState(() {
      //     print("---" + value);
      //     token = value;
      //   });
      // });
      _getOrgToken();
    }

    void _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    // print("Getting Token in homePage!");
    String _orgToken=await model.getOrgToken();
    // print("Token:");
    // print(_token);
    setState(() {
      orgToken=_orgToken;
    });
  }
  
  SharedPreferencesTest s = new SharedPreferencesTest();

    @override
    Widget build(BuildContext context) {
      return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model){
          return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Event',
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
        }
        // child: ,
      );
    }

    Widget FormUI(MainModel model) {
      int flag;
      return

        Container(
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
                    ),),
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                      primaryColor: Theme
                                          .of(context)
                                          .accentColor,

                                    ),
                                    child:
                                    TextFormField(
                                      cursorColor: Theme
                                          .of(context)
                                          .accentColor,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          //hintText: 'Club Name',
                                          labelText: 'Event Name'
                                      ),
                                      validator: checkfeild,
                                      onSaved: (String val) {
                                        eventName = val;
                                      },
                                    )
                                )),
                            // Container(padding: EdgeInsets.only(
                            //     left: 16.0, right: 16.0, top: 8.0),
                            //   child:
                            //   Text("From:", style: TextStyle(
                            //     fontSize: 15.0, fontWeight: FontWeight.w300,)),
                            // ),

                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 8.0),
                            //     child: new Theme(
                            //       data: new ThemeData(
                            //           primaryColor: Theme
                            //               .of(context)
                            //               .accentColor,
                            //           primaryColorDark: Colors.grey
                            //       ),
                            //       child:
                            //       DateTimePickerFormField(
                            //         inputType: inputType1,
                            //         format: formats[inputType1],
                            //         editable: editable,
                            //         decoration: InputDecoration(
                            //             border: OutlineInputBorder(),
                            //             hintText: 'From',
                            //             labelText: 'Date',
                            //             hasFloatingPlaceholder: false),
                            //         onChanged: (dt) =>
                            //             setState(() {
                            //               print(dt);
                            //               fromdate = dt;
                            //             }),
                            //       ),
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 8.0),
                            //     child: new Theme(
                            //       data: new ThemeData(
                            //           primaryColor: Theme
                            //               .of(context)
                            //               .accentColor,
                            //           primaryColorDark: Colors.grey
                            //       ),
                            //       child:
                            //       DateTimePickerFormField(
                            //         // DateTimeField(
                            //         inputType: inputType2,
                            //         format: formats[inputType2],
                            //         editable: editable,
                            //         decoration: InputDecoration(
                            //             border: OutlineInputBorder(),
                            //             hintText: 'From',
                            //             labelText: 'Time',
                            //             hasFloatingPlaceholder: false),
                            //         onChanged: (dt) =>
                            //             setState(() => fromTime = dt),
                            //       ),
                            //     )),
                            // Container(padding: EdgeInsets.only(
                            //     left: 16.0, right: 16.0, top: 8.0),
                            //   child:
                            //   Text("To:", style: TextStyle(
                            //     fontSize: 15.0, fontWeight: FontWeight.w300,)),
                            // ),

                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 8.0),
                            //     child: new Theme(
                            //       data: new ThemeData(
                            //           primaryColor: Theme
                            //               .of(context)
                            //               .accentColor,
                            //           primaryColorDark: Colors.grey
                            //       ),
                            //       child:
                            //       DateTimePickerFormField(
                            //         inputType: inputType1,
                            //         format: formats[inputType1],
                            //         editable: editable,
                            //         decoration: InputDecoration(
                            //             border: OutlineInputBorder(),
                            //             hintText: 'To',
                            //             labelText: 'Date',
                            //             hasFloatingPlaceholder: false),
                            //         onChanged: (dt) =>
                            //             setState(() => toDate = dt),
                            //       ),
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 8.0),
                            //     child: new Theme(
                            //       data: new ThemeData(
                            //           primaryColor: Theme
                            //               .of(context)
                            //               .accentColor,
                            //           primaryColorDark: Colors.grey
                            //       ),
                            //       child:
                            //       DateTimePickerFormField(
                            //         inputType: inputType2,
                            //         format: formats[inputType2],
                            //         editable: editable,
                            //         decoration: InputDecoration(
                            //             border: OutlineInputBorder(),
                            //             hintText: 'From',
                            //             labelText: 'Time',
                            //             hasFloatingPlaceholder: false),
                            //         onChanged: (dt) =>
                            //             setState(() => toTime = dt),
                            //       ),
                            //     )),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,
                                        primaryColorDark: Colors.grey
                                    ),
                                    child:

                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '10000',
                                          labelText: 'Budget'
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: checkfeild,
                                      onSaved: (String val) {
                                        budget = val;
                                      },
                                    )
                                )),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,
                                        primaryColorDark: Colors.grey
                                    ),
                                    child:
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'About the event',
                                          labelText: 'Description'
                                      ),
                                      validator: checkfeild,
                                      onSaved: (String val) {
                                        description = val;
                                      },
                                    )
                                )),

                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,
                                        primaryColorDark: Colors.grey
                                    ),
                                    child:
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          // hintText: 'About the event',
                                          labelText: 'Category'
                                      ),
                                      validator: checkfeild,
                                      onSaved: (String val) {
                                        category = val;
                                      },
                                    )
                                )),

                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,
                                        primaryColorDark: Colors.grey
                                    ),
                                    child:
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          //hintText: 'About the event',
                                          labelText: 'Venue'
                                      ),
                                      validator: checkfeild,
                                      onSaved: (String val) {
                                        venue = val;
                                      },
                                    )
                                )),

                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               hintText: '4000',
                            //               labelText: 'Attendees'
                            //           ),
                            //           onSaved: (String val) {
                            //             attendence = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               hintText: '10,000',
                            //               labelText: 'Expected Participants'
                            //           ),
                            //           onSaved: (String val) {
                            //             expectedParticipants = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'PRO Request'
                            //           ),
                            //           onSaved: (String val) {
                            //             proRequest = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Campus Engineer Request'
                            //           ),
                            //           onSaved: (String val) {
                            //             campeng = val;
                            //           },
                            //         )
                            //     )),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: new Theme(
                                    data: new ThemeData(
                                        primaryColor: Theme
                                            .of(context)
                                            .accentColor,
                                        primaryColorDark: Colors.grey
                                    ),
                                    child:
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (val){
                                        var a=isNumeric(val);
                                        if(val==null)
                                         {
                                           return 'The day field should not be empty';
                                         }
                                        if(a)
                                         {
                                           return null;
                                         }
                                        else{
                                          return 'The day field should be a number';
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          //hintText: 'About the event',
                                          // labelText: 'Duration'
                                          labelText: 'Days',
                                      ),
                                      onSaved: (String val) {
                                        duration = val;
                                      },
                                    )
                                )),
                            // Container(padding: EdgeInsets.only(left: 16.0,
                            //     right: 16.0,
                            //     top: 16.0,
                            //     bottom: 8.0),
                            //   child:
                            //   Text("Faculty Coordinator", style: TextStyle(
                            //     fontSize: 15.0, fontWeight: FontWeight.w500,)),
                            // ),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Name'
                            //           ),
                            //           controller: myController,

                            //           //validator: validateName,
                            //           validator: validateName,
                            //           onSaved: (String val) {
                            //             facultyNmae = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Registration Number'
                            //           ),
                            //           validator: checkfeild,
                            //           onSaved: (String val) {
                            //             facRegNo = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //             decoration: const InputDecoration(
                            //                 border: OutlineInputBorder(),
                            //                 //hintText: 'About the event',
                            //                 labelText: 'Email'
                            //             ),
                            //             keyboardType: TextInputType
                            //                 .emailAddress,
                            //             validator: validateEmail,
                            //             onSaved: (String val) {
                            //               facemail = val;
                            //             }
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Phone Number'
                            //           ),
                            //           keyboardType: TextInputType.phone,
                            //           validator: validateMobile,
                            //           onSaved: (String val) {
                            //             facphoneNumber = val;
                            //           },
                            //         )
                            //     )),
                            // ListTile(

                            //   title: const Text('Gender'),
                            //   trailing: new DropdownButton<String>(
                            //       hint: Text('Choose'),
                            //       onChanged: (String changedValue) {
                            //         newValue = changedValue;
                            //         setState(() {
                            //           newValue;
                            //           facgend = newValue;
                            //           print(newValue);
                            //         });
                            //       },
                            //       value: newValue,
                            //       items: <String>['Male', 'Female', 'Other']
                            //           .map((String value) {
                            //         return new DropdownMenuItem<String>(
                            //           value: value,
                            //           child: new Text(value),
                            //         );
                            //       }).toList()),

                            // ),
                            // Container(padding: EdgeInsets.only(left: 16.0,
                            //     right: 16.0,
                            //     top: 16.0,
                            //     bottom: 8.0),
                            //   child:
                            //   Text("Student Coordinator", style: TextStyle(
                            //     fontSize: 15.0, fontWeight: FontWeight.w500,)),
                            // ),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Name'
                            //           ),
                            //           validator: checkfeild,
                            //           onSaved: (String val) {
                            //             stuName = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Registration Number'
                            //           ),
                            //           validator: checkfeild,
                            //           onSaved: (String val) {
                            //             stuReg = val;
                            //           },
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //             decoration: const InputDecoration(
                            //                 border: OutlineInputBorder(),
                            //                 //hintText: 'About the event',
                            //                 labelText: 'Email'
                            //             ),
                            //             keyboardType: TextInputType
                            //                 .emailAddress,
                            //             validator: validateEmail,
                            //             onSaved: (String val) {
                            //               stuEmail = val;
                            //             }
                            //         )
                            //     )),
                            // Container(
                            //     padding: EdgeInsets.only(
                            //         left: 16.0, right: 16.0, top: 16.0),
                            //     child: new Theme(
                            //         data: new ThemeData(
                            //             primaryColor: Theme
                            //                 .of(context)
                            //                 .accentColor,
                            //             primaryColorDark: Colors.grey
                            //         ),
                            //         child:
                            //         TextFormField(
                            //           decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //               //hintText: 'About the event',
                            //               labelText: 'Phone Number'
                            //           ),
                            //           keyboardType: TextInputType.phone,
                            //           validator: validateMobile,
                            //           onSaved: (String val) {
                            //             stuPhoneNumber = val;
                            //           },
                            //         )
                            //     )),
                            // ListTile(

                            //   title: const Text('Gender'),
                            //   trailing: new DropdownButton<String>(
                            //       hint: Text('Choose'),
                            //       onChanged: (String changedValue) {
                            //         newValue1 = changedValue;
                            //         setState(() {
                            //           newValue1;
                            //           stugend = newValue1;
                            //           print(newValue1);
                            //         });
                            //       },
                            //       value: newValue1,
                            //       items: <String>['Male', 'Female', 'Other']
                            //           .map((String value) {
                            //         return new DropdownMenuItem<String>(
                            //           value: value,
                            //           child: new Text(value),
                            //         );
                            //       }).toList()),
                            // ),


                            Container(padding: EdgeInsets.all(16),
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
                                    style: TextStyle(color: Colors.white),),
                                  onPressed: () {
                                    _sendToServer(model);
                                  },))
                          ]))
                ])
        );
    }

    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    String checkfeild(String value) {
      // print("<__>");
      // print(isNumeric('q'));
      if (value.length == 0 && isNumeric(value)) {
        return "This field is Mandatory and should be number";
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

    String validateMobile(String value) {
      String patttern = r'(^[0-9]*$)';
      RegExp regExp = new RegExp(patttern);
      if (value.length == 0) {
        return "Mobile Number is Required";
      } else if (value.length != 10) {
        return "Mobile number must 10 digits";
      } else if (!regExp.hasMatch(value)) {
        return "Mobile Number must be digits";
      }
      return null;
    }

    String validateEmail(String value) {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0) {
        return "Email is Required";
      } else if (!regExp.hasMatch(value)) {
        return "Invalid Email";
      } else {
        return null;
      }
    }

    void _processData() {
      // Process your data and upload to server
      _key.currentState?.reset();
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>IntermediateOrgLogin(orgId: widget.orgId)));
      //widget.key?.currentState?.reset();
    }

    _sendToServer(MainModel model) {
      if (_key.currentState.validate()) {
        _key.currentState.save();


//         String dt = toDate.toString().substring(0, 11);
//         print(dt);
//         String df = fromdate.toString().substring(0, 11);
//         print(df);
//         String tt = toTime.toString().substring(12, 16);
//         print(tt);
//         String tf = fromTime.toString().substring(12, 16);
//         print(tf);
// //
//         print(token);

//         body["event"]["name"] = '$eventName';
//         body["event"]["toDate"] = '$dt';
//         body["event"]["fromDate"] = '$df';
//         body["event"]["toTime"] = '$tt';
//         body["event"]["fromTime"] = '$tf';
//         body["event"]["budget"] = '$budget';
//         body["event"]["description"] = '$description';
//         body["event"]["category"] = '$category';
//         body["event"]["venue"] = '$venue';
//         body["event"]["attendance"] = '$attendence';
//         body["event"]["expectedParticipants"] = '$expectedParticipants';
//         body["event"]["facultyCoordinator"]["name"] = '$facultyNmae';
//         body["event"]["facultyCoordinator"]["registrationNumber"] = '$facRegNo';
//         body["event"]["facultyCoordinator"]["email"] = '$facemail';
//         body["event"]["facultyCoordinator"]["phoneNumber"] = '$facphoneNumber';
//         body["event"]["facultyCoordinator"]["gender"] = '$facgend';
//         body["event"]["studentCoordinator"]["name"] = '$stuName';
//         body["event"]["studentCoordinator"]["registrationNumber"] = '$stuReg';
//         body["event"]["studentCoordinator"]["email"] = '$stuEmail';
//         body["event"]["studentCoordinator"]["phoneNumber"] = '$stuPhoneNumber';
//         body["event"]["studentCoordinator"]["gender"] = '$stugend';

//         body["event"]["PROrequest"] = '$proRequest';
//         body["event"]["campusEngineerRequest"] = '$campeng';
//         body["event"]["duration"] = '$duration';
//         print(body);

        Future fetchPosts(http.Client client) async {
          // print();
          // var response = await http.post(
          //     URL_CREATEEVENT, headers: {"Authorization": "$token"},
          //     body: json.encode(body));
          var response;
          var a=model.createEvent(orgToken, eventName, widget.orgId, duration, budget, description, category, venue);
          await a.then((res){
            response=res;
          });
          // final data = json.decode(response.body);
          final data=response;
          // if (data['error'] == null) {
          //   Toast.show("Event Created", context, duration: Toast.LENGTH_LONG,
          //       gravity: Toast.BOTTOM);
          //   _processData();
          // }
          // else if (data["error"].toString().compareTo(
          //     "An event with this name already exists") == 0) {
          //   Toast.show(
          //       data['error'].toString(), context, duration: Toast.LENGTH_LONG,
          //       gravity: Toast.BOTTOM);
          // }
          // else {
          //   Toast.show(
          //       "Some Error Ocurred", context, duration: Toast.LENGTH_LONG,
          //       gravity: Toast.BOTTOM);
          // }

          if (data['code'] == 200) {
            Toast.show("Event Created", context, duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
            _processData();
          }
          else if (data["message"].toString().compareTo(
              "An event with this name already exists") == 0) {
            Toast.show(
                data['message'].toString(), context, duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
          }
          else if (data["message"].toString().compareTo(
              "You are forbidden from modifying this resource") == 0) {
            Toast.show(
                "Unauthorized", context, duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
          }
          else {
            Toast.show(
                "Some Error Ocurred", context, duration: Toast.LENGTH_LONG,
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
        setState(() {
          _validate = true;
        });
      }


//
    }
//
//


//  }

  // void updateInputType({bool date, bool time}) {
  //   date = date ?? inputType1 != InputType.time;
  //   time = time ?? inputType2 != InputType.date;
  //   setState(() => inputType =
  //       date ? time ?  InputType.date : InputType.time);
  // }


//  }
  }