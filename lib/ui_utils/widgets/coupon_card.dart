import 'package:flutter/material.dart';

import '../colors.dart';

class CouponCard extends StatelessWidget {

  CouponCard({
    @required this.couponImage,
    @required this.couponText,
  });

  final String couponImage;
  final String couponText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BColors.backgroundBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              couponImage,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(couponText),
            ),
          ],
        ),
      ),
    );
  }
}
