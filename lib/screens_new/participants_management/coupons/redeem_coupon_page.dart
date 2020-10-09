import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/read_coupon.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/dimens.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/failure_card.dart';
import '../../../ui_utils/widgets/loading_card.dart';
import '../../../ui_utils/widgets/submit_button.dart';
import '../../../ui_utils/widgets/success_card.dart';
import '../../../ui_utils/widgets/text_area.dart';
import '../../../utils/enums.dart';
import '../../../utils/validators.dart';

class RedeemCouponPage extends StatefulWidget {
  RedeemCouponPage({
    @required this.currEvent,
    @required this.coupon,
  });

  final ReadCoupon coupon;
  final Event currEvent;

  @override
  _RedeemCouponPageState createState() => _RedeemCouponPageState();
}

class _RedeemCouponPageState extends State<RedeemCouponPage> {
  bool _loading = true, _loadingCard = false;

  final TextEditingController _textController = TextEditingController();

  QRStatus status = QRStatus.NoColor;

  String errMsg = "", orgToken;

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  _initializePage(MainModel model) async {
    await _getOrgToken(model);
    setState(() {
      _loading = false;
    });
  }

  Future<void> _getOrgToken(model) async {
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          //backgroundColor: BColors.white,
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
            title: widget.coupon.name,
          ),
          body: _loading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : IgnorePointer(
                  ignoring: _loadingCard,
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                //margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: BColors.backgroundBlue,
                                  border: Border.all(
                                    color: status == QRStatus.Red
                                        ? BColors.red
                                        : status == QRStatus.Green
                                            ? BColors.green
                                            : BColors.transparent,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child:
                                              Text('Day ${widget.coupon.day}'),
                                        ),
                                        Image.asset(
                                          'images/snacks.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5),
                                                    child: Text(
                                                      widget.coupon.name,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: BColors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.coupon.description,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                SubmitButton(
                                                  buttonText: 'Scan',
                                                  onPressed: () {
                                                    _scanQR(model);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              status == QRStatus.Red
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.87,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        errMsg,
                                        style: TextStyle(
                                          fontSize: Dimens.smallHeadingTextSize,
                                          fontWeight: FontWeight.w600,
                                          color: BColors.red,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              status == QRStatus.Red
                                  ? Container(
                                      child: TextArea(
                                        title: '',
                                        hint: 'someone@email.com',
                                        obscureText: false,
                                        label: 'Email',
                                        validator: Validators.validateEmail,
                                        controller: _textController,
                                      ),
                                    )
                                  : Container(),
                              status == QRStatus.Red
                                  ? Container(
                                      child: SubmitButton(
                                        buttonText: 'Check',
                                        onPressed: () => _redeemCoupon(model),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          _loadingCard
                              ? Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: LoadingCard(),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future _scanQR(MainModel model) async {
    try {
      var barcodeResult = await BarcodeScanner.scan();
      String barcode = barcodeResult.rawContent;
      setState(() {
        status = QRStatus.Green;
        _textController.text = barcode;
      });
      _redeemCoupon(model);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          status = QRStatus.Red;
          errMsg = "Camera Permission Denied, please allow it";
        });
      } else {
        setState(() {
          status = QRStatus.Red;
          errMsg =
              "Some error occurred while scanning, please rescan or manually enter in the given field";
        });
      }
    }
  }

  void _redeemCoupon(MainModel model) async {
    if (_textController.text.trim() == '') {
      return;
    }
    setState(() {
      _loadingCard = true;
    });
    var response = await model.redeemCoupon(
      widget.currEvent.eventId,
      widget.coupon.couponId,
      _textController.text.trim(),
      orgToken,
    );
    if (response['code'] == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => SuccessCard(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      );
    } else if (response['code'] == 404) {
      setState(() {
        status = QRStatus.Red;
        errMsg = "Participant doesn't exist";
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(),
      );
      setState(() {
        status = QRStatus.Red;
        errMsg =
            "Some error occurred, please rescan or manually enter in the given field";
      });
    }
    setState(() {
      _loadingCard = false;
    });
  }
}
