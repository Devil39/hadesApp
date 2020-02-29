import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import '../../models/read_coupon.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';

class MarkScreen extends StatefulWidget {
  int pos;
  RS1 events;
  MarkScreen(this.pos, this.events);

  @override
  State<StatefulWidget> createState() {
    return _MarkState(pos, events);
  }
}

class _MarkState extends State<MarkScreen> {
  String result = "Press Scan";
  ReadCoupon coupon;
  int pos;
  RS1 events;
  Color clr;
  int index = 1;
  List _colors;
  String day = "1";
  String barcode = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  _MarkState(this.pos, this.events);

  Map<String, dynamic> body = {
    "attendance": {"eventName": "DEVRELCONF", "email": "a@a.COM", "day": 2}
  };

  final myController = TextEditingController();
  String _text = "initial";
  TextEditingController _c;
  // String email;
  String regNo;
  String orgToken;

  String newValue;
  // String day;

  int noOfDays;

  List<String> noOfDaysList = ["Choose"];

  @override
  initState() {
    _c = new TextEditingController();
    super.initState();
    MainModel model = ScopedModel.of(context);
    initializePage(model);
  }

  void initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
  }

  void _getNoOfDays(MainModel model) async {
    var a=await model.getNoOfDaysInEvent(events.eventId ,orgToken);
    noOfDays=a["segments"].length;
    for(int i=0;i<a["segments"].length; i++){
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
    setState((){});
  }

  void _getOrgToken(model) async {
    String _orgToken=await model.getOrgToken();
    // print(_orgToken);
    setState(() {
      orgToken=_orgToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    clr = Theme.of(context).backgroundColor;
    _colors = [
      clr,
      Colors.green[500],
      Colors.red,
    ];
    //String result = "Hey there !";
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Day : " + pos.toString(),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          // backgroundColor: _colors[0],
        body: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(35.0),
            child: Container(
              color: _colors[index],
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(3),
                  color: Theme.of(context).backgroundColor,
                  padding: EdgeInsets.all(28),
                  child: Center(
                      child: Column(children: <Widget>[
                    Container(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: new Theme(
                          data: new ThemeData(
                            primaryColor: Theme.of(context).accentColor,
                          ),
                          child: new TextFormField(
                              decoration: new InputDecoration(
                                // hintText: 'Registration Number',
                                // labelText: 'Registration Number',
                                hintText: 'Email',
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              // keyboardType: TextInputType.emailAddress,
                              onChanged: (String val){
                                regNo=val;
                                // print(regNo);
                              },
                              onSaved: (String val) {
                                // email = val;
                                // print(val);
                                regNo = val;
                              }),
                        )),
                    RaisedButton(
                      elevation: 5,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Check',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // _sendToServer(email);
                        _sendToServer(regNo, model);
                      },
                    ),
                    Text(
                      result,
                      style: new TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ])),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text("Scan"),
            onPressed: (){
              _scanQR(model);
            },
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
        },
          // child: ,
    );
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

  Future _scanQR(MainModel model) async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      regNo=barcode;
      _sendToServer(barcode, model);
      // print("QRcode:");
      // print(barcode); 
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
    // try {
    //   String qrResult = await QRCodeReader().scan();
    //   if (qrResult != null) {
    //     setState(() {
    //       print(qrResult);
    //       _sendToServer(qrResult.toString(), model);
    //     });
    //   } else {
    //     setState(() {
    //       index = 2;
    //     });
    //     Toast.show("No QR Scanned", context,
    //         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    //   }
    // } catch (ex) {
    //   setState(() {
    //     result = "Unknown Error $ex";
    //     index = 2;
    //   });
    // }
  }

  void _processData(String res) {
    // Process your data and upload to server
    result = res;
    //widget.key?.currentState?.reset();
  }

  _sendToServer(String res, MainModel model) {
    // print("Print Here!");
    // String eve = events.name.toString();

    // print(eve + pos.toString() + result);

    // body["attendance"]["day"] = pos;
    // body["attendance"]["email"] = '$res';
    // body["attendance"]["eventName"] = '$eve';

    // print(body);

    Future fetchPosts(http.Client client) async {
      // print(regNo);
      // print(day);
      if(regNo!='' && regNo!=null)
       {
         var a=model.markPresent(regNo, day, events.eventId, orgToken);
        var response;
        await a.then((resp){
          response=resp;
        });
        print(response);
        if(response["code"]==200)
        {
          _processData(response['message']);
          Toast.show("Attendance Marked!".toString(), context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
        else{
          Toast.show("Try again", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
        // Navigator.pop(context);
       }
      // var response =
      //     await http.post(URL_MARKATTENDENCE, body: json.encode(body));

      // final data = json.decode(response.body);

      // print(data['rs']);
      // print(day);
      // setState(() {
      //   if (data['rs'].toString() ==
      //       "Successfully marked present for the day") {
      //     setState(() {
      //       index = 1;
      //     });
      //   } else {
      //     setState(() {
      //       index = 2;
      //     });
      //   }
      // });

      // _processData(data['rs']);
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
            return Container();
          }
        });
  }
}
