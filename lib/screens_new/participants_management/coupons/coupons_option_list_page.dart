import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/heading.dart';
import '../../../ui_utils/widgets/photo_card.dart';
import '../../../ui_utils/widgets/submit_button.dart';
import '../../../utils/router.gr.dart';

class CouponsOptionListPage extends StatefulWidget {
  const CouponsOptionListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _CouponsOptionListPageState createState() => _CouponsOptionListPageState();
}

class _CouponsOptionListPageState extends State<CouponsOptionListPage> {
  int selectedCardIndex = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: BColors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: widget.currEvent.name,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Heading(headingText: 'Coupons'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCardIndex = 0;
                      });
                    },
                    child: PhotoCard(
                      tileTitle: 'Create Coupon',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: '',
                      bgColor: selectedCardIndex == 0
                          ? BColors.activeCardColor
                          : null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.edit,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCardIndex = 1;
                      });
                    },
                    child: PhotoCard(
                      tileTitle: 'Redeem Coupon',
                      tileImage: 'images/orgPng.png',
                      tileTrailing: null,
                      tileSubtitle: '',
                      bgColor: selectedCardIndex == 1
                          ? BColors.activeCardColor
                          : null,
                      icon: Container(
                        width: 50.0,
                        height: 69.0,
                        child: Icon(
                          Icons.list,
                          color: BColors.blue,
                          size: 39.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.24),
                    child: SubmitButton(
                      onPressed: selectedCardIndex == null
                          ? null
                          : () {
                              if (selectedCardIndex == 0) {
                                ExtendedNavigator.rootNavigator.pushNamed(
                                  Routes.createCouponPage,
                                  arguments: CreateCouponPageArguments(
                                    currEvent: widget.currEvent,
                                  ),
                                );
                              } else if (selectedCardIndex == 1) {
                                ExtendedNavigator.rootNavigator.pushNamed(
                                  Routes.couponListPage,
                                  arguments: CouponListPageArguments(
                                    currEvent: widget.currEvent,
                                  ),
                                );
                              }
                            },
                      buttonText: "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
