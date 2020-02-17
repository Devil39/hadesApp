import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../screens/mailingServices/mailAllScreen.dart';
import '../../screens/attendeScreens/editAttendeePage.dart';
import '../../screens/coupens/qrScanner.dart';
import '../../screens/coupens/createCoupen.dart';
import '../../screens/coupens/readCoupon.dart';
import '../../screens/coupens/dayEvent.dart';

class CoupenServicesScreen extends StatefulWidget {
  RS1 events;
  int pos;

  CoupenServicesScreen(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _CoupenServicesScreen(events, pos);
  }
}

class _CoupenServicesScreen extends State<CoupenServicesScreen> {
  RS1 events;
  int pos;

  _CoupenServicesScreen(this.events, this.pos);

  void _all() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateCoupenPage(events, pos)),
    );
  }

  void _read() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadCouponPage(events, pos)),
    );
  }

  void _mark() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DayCoupenPage(pos, events)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coupons",
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Functions",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                  )),
                ],
              )),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

              child: Center(
                  child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new Container(
                                  padding: EdgeInsets.all(40.0),
                                  decoration: new BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)))),
                              flex: 18,
                            ),
                            new Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 15.0),
                                    child: Text(
                                      "Create",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 3.0),
                                    child: Text("For Food, Goodies, etc",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                  )
                                ],
                              ),
                              flex: 30,
                            ),
                            Flexible(
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 60.0, top: 10.0),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                        Icons.chevron_right,
                                      )),
                                    )),
                                flex: 23),
                          ]))),
              // size: Size(300, 100),
            ),
            onTap: _all,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

              child: Center(
                  child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new Container(
                                  padding: EdgeInsets.all(40.0),
                                  decoration: new BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)))),
                              flex: 18,
                            ),
                            new Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 15.0),
                                    child: Text(
                                      "Redeem",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 3.0),
                                    child: Text("For Food, Goodies, etc",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                  )
                                ],
                              ),
                              flex: 30,
                            ),
                            Flexible(
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 45.0, top: 10.0),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                        Icons.chevron_right,
                                      )),
                                    )),
                                flex: 23),
                          ]))),
              // size: Size(300, 100),
            ),
            onTap: _read,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

              child: Center(
                  child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new Container(
                                  padding: EdgeInsets.all(40.0),
                                  decoration: new BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)))),
                              flex: 18,
                            ),
                            new Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 15.0),
                                    child: Text(
                                      "Mark Attendance",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 3.0),
                                    child: Text("of Participants",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                  )
                                ],
                              ),
                              flex: 30,
                            ),
                            Flexible(
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 60.0, top: 10.0),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                        Icons.chevron_right,
                                      )),
                                    )),
                                flex: 23),
                          ]))),
              // size: Size(300, 100),
            ),
            onTap: _mark,
          ),
        ],
      )),
    );
  }
}
