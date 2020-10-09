import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/read_coupon.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/dimens.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/coupon_card.dart';
import '../../../ui_utils/widgets/failure_card.dart';
import '../../../utils/router.gr.dart';

class CouponListPage extends StatefulWidget {
  const CouponListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _CouponListPageState createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage> {
  String orgToken;

  bool _loading = true;

  List<ReadCoupon> _coupons = [];

  int noOfDays = 0;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
    await getAllCoupons();
  }

  Future<void> getAllCoupons() async {
    for (int i = 1; i <= noOfDays; i++) {
      _coupons.addAll(await getDaysCoupon(i));
    }
    setState(() {
      _loading = false;
    });
  }

  Future<List<ReadCoupon>> getDaysCoupon(int day) async {
    if (orgToken != '') {
      MainModel model = ScopedModel.of(context);

      var a = model.getAllCoupons(
          widget.currEvent.eventId, day.toString(), orgToken);
      // print(a);
      var response;
      await a.then((resp) {
        response = resp;
      });
      if (this.mounted) {
        setState(() {});
      }
      if (response['code'] == 200) {
        var data = response["coupons"];
        List<ReadCoupon> coupons = new List<ReadCoupon>();
        for (int i = 0; i < data.length; i++) {
          coupons.add(new ReadCoupon.fromJson(data[i]));
        }
        return coupons;
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => FailureCard(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        );
        return [];
      }
    }
    return [];
  }

  Future<void> _getNoOfDays(MainModel model) async {
    var a = await model.getNoOfDaysInEvent(widget.currEvent.eventId, orgToken);
    if (a == null) {
      return;
    }
    noOfDays = a["segments"].length;
  }

  void _getOrgToken(MainModel model) async {
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
    });
  }

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
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _coupons.length == 0
                ? Container(
                    child: Center(
                      child: Text(
                        'No Coupons!',
                        style: TextStyle(
                          fontSize: Dimens.smallHeadingTextSize,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: _buildCouponCards(),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  List<Widget> _buildCouponCards() {
    List<Widget> coupons = [];
    for (int i = 0; i < _coupons.length; i++) {
      coupons.add(
        GestureDetector(
          onTap: () {
            ExtendedNavigator.rootNavigator.pushNamed(
              Routes.redeemCouponPage,
              arguments: RedeemCouponPageArguments(
                coupon: _coupons[i],
                currEvent: widget.currEvent,
              ),
            );
          },
          child: CouponCard(
            couponImage: 'images/snacks@2x.png',
            couponText: 'Day ${_coupons[i].day}: ${_coupons[i].name}',
          ),
        ),
      );
    }
    return coupons;
  }
}
