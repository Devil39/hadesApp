import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';
import '../../util.dart';
import '../../screens/export/filesex.dart';

class ExcelParticipantsList extends StatefulWidget {
  RS1 events;
  int pos;

  ExcelParticipantsList(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ExcelParticipantsPage(events, pos);
  }
}

class _ExcelParticipantsPage extends State<ExcelParticipantsList> {
  RS1 events;
  int pos;

  _ExcelParticipantsPage(this.events, this.pos);

  Map<String, dynamic> body;

  double _result = 0.0;
  int _radioValue = 1;
// TextEditingController controlle = TextEditingController();
  String state;
  Future<Directory> _appDocDir;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = 1;
          type = "project-all";
          print(_result);
          break;
        case 1:
          _result = 2;
          type = "project-present";
          print(_result);
          break;
        case 2:
          _result = 3;
          type = "project-absent";
          print(_result);
          break;
      }
    });
  }

  List _gender = ["Male", "Female", "Both"];

  List _part = ["All", "Present", "Absent"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItems2;
  String _selectedGender;
  String _selectedpart;

  String newValue;
  String gend;
  String newValue2;
  String type;
  String orgToken;
  String newValue3;
  String day;

  int noOfDays;

  List<String> noOfDaysList=["Choose"];

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(value: gender, child: new Text(gender)));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedGender = _dropDownMenuItems[0].value;
    MainModel model = ScopedModel.of(context);
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedGender = _dropDownMenuItems[0].value;
    _initializePage(model);
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
    return;
  }

  void _getNoOfDays(MainModel model) async {
    var a=await model.getNoOfDaysInEvent(events.eventId ,orgToken);
    noOfDays=a["segments"].length;
    for(int i=0;i<a["segments"].length; i++){
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
  }

  void _getOrgToken(MainModel model) async {
    String _orgToken=await model.getOrgToken();
    setState(() {
      orgToken=_orgToken;
    });
  }

  var progressString = "";
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator2 = downloading
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
//
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
                        "Downloading File: $progressString",
                        style: editText,
                      )
                    ],
                  )))),
            )))
        : new Container();
    // TODO: implement build
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model){
        return Stack(children: <Widget>[
        Scaffold(
            appBar: AppBar(
              title: Text(
                'Excel List',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.file_download,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Filesex(events, pos)),
                    );
                  },
                )
              ],
            ),
            body: Container(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15.0),
                    children: <Widget>[
                  ListTile(
                    title: const Text('Day'),
                    trailing: new DropdownButton<String>(
                        hint: Text('Choose'),
                        onChanged: (String changedValue) {
                          newValue3 = changedValue;
                          setState(() {
                            // newValue;
                            day = newValue3;
                          });
                        },
                        value: day,
                        items: noOfDaysList
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList()),
                  ),
                  ListTile(
                    title: const Text('Gender'),
                    trailing: new DropdownButton<String>(
                        hint: Text('Choose'),
                        onChanged: (String changedValue) {
                          newValue = changedValue;
                          setState(() {
                            newValue;
                            gend = newValue;
                            print(newValue);
                          });
                        },
                        value: newValue,
                        items: <String>['Male', 'Female', 'Both']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList()),
                  ),
                  Column(children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 150),
                              child: Text("All Participants"),
                            ),
                            flex: 5,
                          ),
                          Flexible(
                            child: Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: 120, left: 8),
                              child: Text("Present Participants"),
                            ),
                            flex: 5,
                          ),
                          Flexible(
                            child: Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: 125, left: 8),
                              child: Text("Absent Participants"),
                            ),
                            flex: 5,
                          ),
                          Flexible(
                            child: Radio(
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ]),

                  Container(
                      padding: EdgeInsets.all(16),
                      child: new RaisedButton(
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Theme.of(context).accentColor,
                        child:
                            Text('Submit', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _sendToServer(model);
                        },
                      )),
//                FutureBuilder<Directory>(
//               future: _appDocDir,
//               builder:
//                   (BuildContext context, AsyncSnapshot<Directory> snapshot) {
//                 Text text = Text('',style: TextStyle(fontWeight: FontWeight.w600),);
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     text = Text('Error: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     text = Text('Path: ${snapshot.data.path}');
//                   } else {
//                     text = Text('Unavailable');
//                   }
// } return new Container(
//                   child: text,
// );
//                   }
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child:  Text('${state ?? "Select the option"}'),
//               )
                ]))),
        new Align(
          child: loadingIndicator2,
          alignment: FractionalOffset.center,
        ),
      ]);
      },
          // child: ,
    );
  }

  Storage storage = Storage();

  Future<File> writeData(String data) async {
    setState(() {
      state = data;
      print("yoyo");
      print(state);
    });

    return storage.writeData(state, _result.toInt());
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  _sendToServer(MainModel model) {
    String eve = events.name.toString();
    getAppDirectory();

    if (gend.toString() != 'Both') {
      body = {
        "event": "DEVFEST 2019",
        "query": {"key": "gender", "value": "F", "specific": "project-all"}
      };
      body["query"]["specific"] = '$type';
      body["query"]["value"] = '$gend';
      body["query"]["key"] = 'gender';
      body["event"] = '$eve';
    } else {
      body = {
        "event": "DEVFEST 2019",
        "query": {"specific": "project-all"}
      };
      body["query"]["specific"] = '$type';
      body["event"] = '$eve';
    }
    //print(name);
    //  body["details"]["name"] = '$name';
    //  body["details"]["registrationNumber"] = '$reg';
    //  body["details"]["email"] = '$email';

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    if(day=='Choose')
     {
       day='1';
     }
    var a=model.getAllInCsv(orgToken, events.eventId, day, '', '');
    // HttpClient client = new HttpClient();
    // var _downloadData = StringBuffer();
    // var fileSave = new File("/index.html");
    // client
    //     .getUrl(Uri.parse(
    //         "${URL_EXCELFETCH}?key=gender&value=${gend}&specific=${type}&event=${eve}"))
    //     .then((HttpClientRequest request) {
    //   print("yaya");
    //   return request.close();
    // }).then((HttpClientResponse response) {
    //   response.transform(utf8.decoder).listen((d) => _downloadData.write(d),
    //       onDone: () {
    //     print(fileSave);
    //     fileSave.writeAsString(_downloadData.toString());
    //   });
    // });

    // print(body);
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

//   return FutureBuilder(
//
//        future: downloadFile(),
//        builder: (BuildContext context,AsyncSnapshot snapshot){
//          if(snapshot.data==null){
//            return Container(
//              child: Center(
//                child: CircularProgressIndicator(),
//              ),
//            );
//
//          }
//          else{
//            return Container();
//        //     Fluttertoast.showToast(
//        // msg: "Check Your Connection",
//        // toastLength: Toast.LENGTH_SHORT,
//        // gravity: ToastGravity.BOTTOM,
//        // timeInSecForIos: 1,
//        // backgroundColor: Colors.grey[700],
//        // textColor: Colors.white);
//          }
//          });
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<String> readData(int pos) async {
    try {
      // final file = await localFile;
      final path = await localPath;
      File file;
      if (pos == 0) {
        file = File('$path/All_Participantsexcel.txt');
      } else if (pos == 1) {
        file = File('$path/Present_Participantsexcel.txt');
      } else if (pos == 2) {
        file = File('$path/Absent_Participantsexcel.txt');
      }

      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data, int pos) async {
    final path = await localPath;
    File file;
    if (pos == 1) {
      file = File('$path/All_Participantsexcel.txt');
    } else if (pos == 2) {
      file = File('$path/Present_Participantsexcel.txt');
    } else if (pos == 3) {
      file = File('$path/Absent_Participantsexcel.txt');
    }

    return file.writeAsString("$data");
  }
}
