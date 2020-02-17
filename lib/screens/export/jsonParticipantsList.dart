import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import '../../screens/export/files.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';

class JsonParticipantsList extends StatefulWidget {
  RS1 events;
  int pos;

  JsonParticipantsList(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _JsonParticipantsPage(events, pos);
  }
}

class _JsonParticipantsPage extends State<JsonParticipantsList> {
  RS1 events;
  int pos;

  _JsonParticipantsPage(this.events, this.pos);

  Map<String, dynamic> body;

  double _result = 0.0;
  int _radioValue = 1;
  String orgToken;

  TextEditingController controller = TextEditingController();
  String state;
  Future<Directory> _appDocDir;
  @override
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

  List _gender = ["Male", "Female", "Other"];

  List _part = ["All", "Present", "Absent"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItems2;
  String _selectedGender;
  String _selectedpart;

  String newValue;
  String gend;
  String newValue2;
  String type;
  String day;
  String newValue3;

  int noOfDays;

  List<String> noOfDaysList = ["Choose"];

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(value: gender, child: new Text(gender)));
    }
    return items;
  }

  @override
  void initState() {
    //  storage.readData(_result.toInt()).then((String value) {
    //     setState(() {
    //       state = value;
    //     });
    //   });
    super.initState();
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
    var a = await model.getNoOfDaysInEvent(events.eventId, orgToken);
    noOfDays = a["segments"].length;
    for (int i = 0; i < a["segments"].length; i++) {
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
  }

  void _getOrgToken(MainModel model) async {
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Json List',
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
                          builder: (context) => Files(events, pos)),
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
                        items: noOfDaysList.map((String value) {
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
                            // newValue;
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
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _sendToServer(model);
                        },
                      )),

//               FutureBuilder<Directory>(
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
                ])));
      },
      // child: ,
    );
  }

  Storage storage = Storage();

  Future<File> writeData(String data) async {
    setState(() {
      state = data;
      // print("yoyo");
      // print(state);
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
    // print("dfghjkl");
    // print(_appDocDir);
    // if (gend.toString() != 'Both') {
    //   body = {
    //     "event": "DEVFEST 2019",
    //     "query": {"key": "gender", "value": "F", "specific": "project-all"}
    //   };
    //   body["query"]["specific"] = '$type';
    //   body["query"]["value"] = '$gend';
    //   body["query"]["key"] = 'gender';
    //   body["event"] = '$eve';
    // } else {
    //   body = {
    //     "event": "DEVFEST 2019",
    //     "query": {"specific": "project-all"}
    //   };
    //   body["query"]["specific"] = '$type';
    //   body["event"] = '$eve';
    // }
    //print(name);
    //  body["details"]["name"] = '$name';
    //  body["details"]["registrationNumber"] = '$reg';
    //  body["details"]["email"] = '$email';

    Future fetchPosts(http.Client client) async {
      try {
        if (day == 'Choose') {
          day = '1';
        }
        if(_result==0)
         {
           _result=2;
         }
        var a = model.getAllInJson(orgToken, events.eventId, day, gend,
            (_result.toInt()).toString()); //_result//_gender
        var response;
        await a.then((resp) {
          response = resp;
        });
        // print("<__>");
        // print(response["data"].toString());
        var data = await response["data"].toString();
        if (response["code"] == 200) {
          await writeData(data);
          Toast.show("JSON Downloaded", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else {
          Toast.show("Try Again", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } catch (err) {
        Toast.show("Try Again", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
      // var response = await http.post(URL_JSONFETCH, body: json.encode(body));

      // final data = json.decode(response.body);
      // print(data);

      // writeData(data.toString());
    }

    // print(body);

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
            //     Fluttertoast.showToast(
            // msg: "Check Your Connection",
            // toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.BOTTOM,
            // timeInSecForIos: 1,
            // backgroundColor: Colors.grey[700],
            // textColor: Colors.white);
          }
        });
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
      if (pos == 1) {
        file = File('$path/All_Participants.txt');
      } else if (pos == 2) {
        file = File('$path/Present_Participants.txt');
      } else if (pos == 3) {
        file = File('$path/Absent_Participants.txt');
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
    // print(data);
    // print(pos);
    if (pos == 1) {
      file = File('$path/All_Participants.txt');
    } else if (pos == 2) {
      file = File('$path/Present_Participants.txt');
    } else if (pos == 3) {
      file = File('$path/Absent_Participants.txt');
    }
    return file.writeAsString("$data");
  }
}
