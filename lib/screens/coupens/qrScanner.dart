import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_flutter/qr_flutter.dart';

import 'package:hades_app/screens/coupens/qr.dart';
import 'package:hades_app/screens/coupens/QRCodeReader.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/global.dart';
import '../../models/read_coupon.dart';
import '../../models/readApi.dart';

class ScanScreen extends StatefulWidget {
  ReadCoupon attendee;
  int pos;
  RS1 events;
  ScanScreen(this.attendee, this.pos, this.events);
//   ScanScreen(this.pos,this.events);

  @override
  State<StatefulWidget> createState() {
    return _ScanState(attendee, pos, events);
//    return _ScanState(pos,events);
  }
}

class _ScanState extends State<ScanScreen> {
  String result = "Press Scan";

  int pos;
  RS1 events;
  Color clr;
  int index = 1;
  List _colors;
  ReadCoupon coupon;

//  _ScanState(this.pos,this.events);

  _ScanState(this.coupon, this.pos, this.events);

  Map<String, dynamic> body = {
    "attendance": {
      "couponName": "dinner",
      "day": 2,
      "email": "a@a.COM",
      "eventName": "DEVRELCONF"
    }
  };

  Map<String, dynamic> body2 = {
    "event": "DEVRELCONF",
    "query": {"name": "lunch", "day": 2, "description": "lunch"}
  };
  String regNo;
  String orgToken;

  @override
  initState() {
    super.initState();
    _getOrgToken();
  }

  void _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
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

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Redeem",
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Delete',
                onPressed: () {
                  _deleteFromServer(model);
                },
              )
            ],
          ),
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
                              // hintText: 'Email ID',
                              // labelText: 'Email ID',
                              hintText: 'Registration Number',
                              labelText: 'Registration Number',
                              border: OutlineInputBorder(),
                            ),
                            // keyboardType: TextInputType.emailAddress,
                            onChanged: (String val) {
                              regNo = val;
                              // print(regNo);
                            },
                            onSaved: (String val) {
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
                      _sendToServer(regNo, model);
                    },
                  ),
                  Text(
                    result,
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ])),
              )),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text("Scan"),
            onPressed: () {
              _scanQR(model);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
      // child: ,
    );
  }

  Future _scanQR(MainModel model) async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>QrCodeReader()));
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>QRViewExample()));
  //   try {
  //     // String qrResult = await QRCodeReader().scan();
  //     String qrResult = await QRCodeReader()
  //     .setAutoFocusIntervalInMs(200)
  //     .setForceAutoFocus(true)
  //     .setTorchEnabled(true)
  //     .setHandlePermissions(true)
  //     .setExecuteAfterPermissionGranted(true)
  //     .scan();
  //     // String qrResult = await BarcodeScanner.scan();
  //     setState(() {
  //       _sendToServer(qrResult.toString(), model);
  // //_processData(qrResult.toString());
  // //        result = qrResult;
  //     });
  //   } on PlatformException catch (err) {
  //     print(err);
  //     print(err.code);
  //   }
    // catch (ex) {
    //   setState(() {
    //     result = "Unknown Error $ex";
    //     index = 2;
    //   });
    // }
  }

  void _processData(String res) {
    // Process your data and upload to server
    result = res;
//    widget.key?.currentState?.reset();
  }

  _sendToServer(String res, MainModel model) {
    // print(res);
    // String eve = events.name.toString();
    // // String nm=events.clubName.toString();
    // String nm = "DSC";
    // String name = coupon.name.toString();
    // var dd = coupon.day;
    // //result = res;
    // body["attendance"]["couponName"] = '$name';
    // body["attendance"]["day"] = dd;
    // body["attendance"]["email"] = '$res';
    // body["attendance"]["eventName"] = '$eve';

    // print(body);

    Future fetchPosts(http.Client client) async {
      // print(regNo);
      if (orgToken != '' && regNo != '') {
        var a =
            model.redeemCoupon(events.eventId, coupon.couponId, res, orgToken);
        var response;
        await a.then((resp) {
          response = resp;
        });
        print(response);
        if (response["code"] == 200) {
          Toast.show("Coupon Redeemed!".toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else {
          Toast.show("Try Again!".toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
        Navigator.pop(context);
      }
      // var response = await http.post(URL_REDEEM, body: json.encode(body));

      // final data = json.decode(response.body);

      // print(data['rs']);
      // setState(() {
      //   if (data['rs'].toString() == "Successfully posted coupon") {
      //     setState(() {
      //       index = 1;
      //     });
      //   } else {
      //     setState(() {
      //       index = 2;
      //     });
      //   }
      // });

      // _processData(data["rs"]);
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

  void _processedData() {
//     Process your data and upload to server
//    _key.currentState?.reset();
//    Navigator.of(context).pop();
//    widget.key?.currentState?.reset();
  }

  _deleteFromServer(MainModel model) async {
    var a = model.deleteCoupon(events.eventId, coupon.couponId, orgToken);
    var response;
    await a.then((resp) {
      response = resp;
    });
    print(response);
    if (response["code"] == 200) {
      Toast.show("Coupon Created", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      Toast.show("Try Again", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
//     String eve=events.name.toString();
//     String name=coupon.name.toString();
//     String des=coupon.description.toString();
//      var dd = coupon.day;
//      //result = res;
//    body2["query"]["name"] = '$name';
//    body2["query"]["day"] = dd;
//      body2["query"]["description"] = '$des';
//      body2[ "event"] = '$eve';

//   print(body2);

//      Future fetchPosts(http.Client client) async {
//  var response=await http.post(URL_DELETECOUPON, body: json.encode(body2));

//    final data = json.decode(response.body);

//       print(data['rs']);
//       //  Fluttertoast.showToast(
//       //   msg: data['rs'].toString(),
//       //   toastLength: Toast.LENGTH_SHORT,
//       //   gravity: ToastGravity.BOTTOM,
//       //   timeInSecForIos: 1,
//       //   backgroundColor: Colors.grey[700],
//       //   textColor: Colors.white);
//        _processedData();
//   }

//    print(body);

//    return FutureBuilder(

//         future: fetchPosts(http.Client()),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.data==null){
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );

//           }
//           else{
//         //     Fluttertoast.showToast(
//         // msg: "Check Your Connection",
//         // toastLength: Toast.LENGTH_SHORT,
//         // gravity: ToastGravity.BOTTOM,
//         // timeInSecForIos: 1,
//         // backgroundColor: Colors.grey[700],
//         // textColor: Colors.white);
//           }
//           });
  }
}
