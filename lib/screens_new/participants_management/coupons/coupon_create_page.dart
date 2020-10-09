import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/drop_down.dart';
import '../../../ui_utils/widgets/failure_card.dart';
import '../../../ui_utils/widgets/loading_card.dart';
import '../../../ui_utils/widgets/message_card.dart';
import '../../../ui_utils/widgets/submit_button.dart';
import '../../../ui_utils/widgets/success_card.dart';
import '../../../ui_utils/widgets/text_area.dart';
import '../../../utils/validators.dart';

class CreateCouponPage extends StatefulWidget {
  const CreateCouponPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _CreateCouponPageState createState() => _CreateCouponPageState();
}

class _CreateCouponPageState extends State<CreateCouponPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _loading = true, _autoValidate = false, _loadingCard = false;

  int noOfDays;

  List<String> noOfDaysList = ["Choose"];

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
    noOfDays = a["segments"].length;
    for (int i = 0; i < a["segments"].length; i++) {
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
    setState(() {
      _loading = false;
    });
  }

  String orgToken, newValue, day = "Choose";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Create Coupon',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: BColors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return _buildBody(model);
      }),
    );
  }

  Widget _buildBody(MainModel model) {
    return _loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : IgnorePointer(
            ignoring: _loadingCard,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Form(
                  //autovalidate: _autoValidate,
                  // autovalidateMode: _autoValidate
                  //     ? AutovalidateMode.always
                  //     : AutovalidateMode.disabled,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextArea(
                            title: 'Name',
                            hint: 'Lunch Coupon',
                            label: null,
                            obscureText: false,
                            validator: Validators.validateText,
                            controller: _nameController,
                          ),
                          TextArea(
                            title: 'Description',
                            hint: 'This is the lunch coupon for second day',
                            label: null,
                            obscureText: false,
                            validator: Validators.validateText,
                            controller: _descController,
                          ),
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
                          SubmitButton(
                            buttonText: 'Create',
                            onPressed: () => _createCoupon(model),
                          ),
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
  }

  void _createCoupon(MainModel model) async {
    setState(() {
      _autoValidate = true;
    });
    if (day == "Choose") {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Choose a day',
        ),
      );
      setState(() {
        _autoValidate = false;
      });
      return;
    }
    if (_validateAll()) {
      setState(() {
        _loadingCard = true;
      });
      var response = await model.createCoupon(
        widget.currEvent.eventId,
        _nameController.text.trim(),
        _descController.text.trim(),
        day,
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
      } else if (response['code'] == 403) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MessageCard(
            message: 'Unauthorized',
          ),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => FailureCard(),
        );
      }
    }
    setState(() {
      _loadingCard = false;
    });
  }

  bool _validateAll() {
    return Validators.validateText(_nameController.text.trim()) == null &&
        Validators.validateText(_descController.text.trim()) == null;
  }
}
