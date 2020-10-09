import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/dimens.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/drop_down.dart';
import '../../../ui_utils/widgets/loading_card.dart';
import '../../../ui_utils/widgets/message_card.dart';
import '../../../ui_utils/widgets/submit_button.dart';
import '../../../ui_utils/widgets/text_area.dart';
import '../../../utils/enums.dart';
import '../../../utils/validators.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _loading = true, _loadingCard = false;

  int noOfDays;

  List<String> noOfDaysList = ["Choose"];

  String orgToken, newValue, day = "Choose", errMsg = "";

  final TextEditingController _textController = TextEditingController();

  QRStatus status = QRStatus.NoColor;

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
  }

  Future<void> _getOrgToken(model) async {
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
    });
  }

  Future<void> _getNoOfDays(MainModel model) async {
    var a = await model.getNoOfDaysInEvent(widget.currEvent.eventId, orgToken);
    if (a == null) {
      return;
    }
    noOfDays = a["segments"].length;
    for (int i = 0; i < a["segments"].length; i++) {
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: DropDown(
                                  itemsList: noOfDaysList,
                                  onChanged: (String changedValue) {
                                    newValue = changedValue;
                                    setState(() {
                                      day = newValue;
                                    });
                                  },
                                  value: day,
                                  title: "Day",
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                height: MediaQuery.of(context).size.height * 0.2,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Attendance',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: BColors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimens.mediumHeadingTextSize,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.center_focus_weak,
                                          color: BColors.blue,
                                          size: 60.0,
                                        ),
                                        Spacer(),
                                        SubmitButton(
                                          buttonText: 'Scan',
                                          onPressed: () {
                                            _scanQR(model);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              status == QRStatus.Red || (status == QRStatus.Green && errMsg != "")
                                  ? Container(
                                      width: MediaQuery.of(context).size.width * 0.87,
                                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        errMsg,
                                        style: TextStyle(
                                          fontSize: Dimens.smallHeadingTextSize,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              status == QRStatus.Red ? BColors.red : BColors.green,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              status == QRStatus.Red && day != "Choose"
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
                              status == QRStatus.Red && day != "Choose"
                                  ? Container(
                                      child: SubmitButton(
                                        buttonText: 'Check',
                                        onPressed: () => _markAttendance(model),
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
    if (day == "Choose" || day == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Choose a day',
        ),
      );
      return;
    }
    try {
      var barcodeResult = await BarcodeScanner.scan();
      String barcode = barcodeResult.rawContent;
      setState(() {
        status = QRStatus.Green;
        _textController.text = barcode;
      });
      _markAttendance(model);
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

  void _markAttendance(MainModel model) async {
    if (_textController.text.trim() == '') {
      return;
    }
    setState(() {
      _loadingCard = true;
    });
    //if (day == "Choose" || day == null) {
    //  setState(() {
    //    errMsg = "Choose a day";
    //    status = QRStatus.Red;
    //  });
    //  setState(() {
    //    _loadingCard = false;
    //  });
    //  return;
    //}
    var response = await model.markPresent(
      _textController.text.trim(),
      day,
      widget.currEvent.eventId,
      orgToken,
    );
    if (response['code'] == 200) {
      setState(() {
        errMsg = "Attendance recorded succcessfully";
        status = QRStatus.Green;
      });
    } else if (response['code'] == 404) {
      setState(() {
        status = QRStatus.Red;
        errMsg = "Participant doesn't exist";
      });
    } else {
      setState(() {
        status = QRStatus.Red;
        errMsg = "Some error occurred, please rescan or manually enter in the given field";
      });
    }
    setState(() {
      _loadingCard = false;
    });
  }
}
