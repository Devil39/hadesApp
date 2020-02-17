import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../models/readApi.dart';
import '../screens/eventPage.dart';
import '../models/read_coupon.dart';
import '../screens/coupens/qrScanner.dart';
import '../screens/attendeScreens/editAttendeePage.dart';

class CouponCard extends StatefulWidget {
  String name;
  String day;
  String des;
  ReadCoupon coupon;
  int pos;
  RS1 events;

  CouponCard(this.coupon, this.pos, this.events);

  @override
  State<StatefulWidget> createState() {
    return CouponCardState(coupon, pos, events);
  }
}

class CouponCardState extends State<CouponCard> {
  String name;
  String clubname;
  ReadCoupon coupon;
  int pos;
  RS1 events;

  CouponCardState(this.coupon, this.pos, this.events);

  Widget get babyCard {
    return GestureDetector(
        child: new Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: Container(
                  child: Text(
                    "Day: " + (coupon.day).toString(),
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text(coupon.name),
                subtitle: Container(
                    child: Row(
                  children: <Widget>[Text(coupon.description)],
                )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanScreen(coupon, pos, events),
                    ),
                  );
                },
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: babyCard,
    );
  }
}
