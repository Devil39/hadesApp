import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/read_attendee.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/dimens.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/drop_down.dart';
import '../../../ui_utils/widgets/failure_card.dart';
import '../../../ui_utils/widgets/heading.dart';
import '../../../ui_utils/widgets/loading_card.dart';
import '../../../ui_utils/widgets/message_card.dart';
import '../../../ui_utils/widgets/submit_button.dart';
import '../../../ui_utils/widgets/success_card.dart';
import '../../../ui_utils/widgets/text_area.dart';
import '../../../utils/enums.dart';
import '../../../utils/router.gr.dart';
import '../../../utils/validators.dart';

class ParticipantCreateEditPage extends StatefulWidget {
  ParticipantCreateEditPage({
    @required this.mode,
    @required this.currEvent,
    @required this.participant,
  });

  final ParticipantScreenMode mode;
  final Event currEvent;
  final ReadAttendee participant;

  @override
  _ParticipantCreateEditPageState createState() =>
      _ParticipantCreateEditPageState();
}

class _ParticipantCreateEditPageState extends State<ParticipantCreateEditPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();

  bool _autoValidate = false, _loading = true;

  String orgToken, gender;

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    if (widget.mode == ParticipantScreenMode.Edit) {
      _initControllers();
    }
    setState(() {
      _loading = false;
    });
  }

  void _initControllers() {
    _emailController.text = widget.participant.email;
    _nameController.text = widget.participant.name;
    _regNoController.text = widget.participant.registrationNumber;
    _phoneNumberController.text = widget.participant.phoneNumber;
    gender = widget.participant.gender;
  }

  Future<void> _getOrgToken(MainModel model) async {
    MainModel model = ScopedModel.of(context);
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
            child: IgnorePointer(
              ignoring: _loading,
              child: Stack(
                children: [
                  ListView(
                    children: <Widget>[
                      Heading(headingText: 'Participant Management'),
                      Heading(
                        headingText: widget.mode == ParticipantScreenMode.Edit
                            ? 'Update Form'
                            : 'Create Form',
                        headingTextColor: BColors.blue,
                        headingTextSize: Dimens.mediumHeadingTextSize,
                      ),
                      Container(
                        child: Form(
                          //autovalidate: _autoValidate,
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            children: <Widget>[
                              TextArea(
                                label: null,
                                obscureText: false,
                                hint: 'someone@email.com',
                                title: 'Email',
                                validator: Validators.validateEmail,
                                controller: _emailController,
                              ),
                              TextArea(
                                label: null,
                                obscureText: false,
                                hint: 'someone',
                                title: 'Name',
                                validator: Validators.validateText,
                                controller: _nameController,
                              ),
                              TextArea(
                                label: null,
                                obscureText: false,
                                hint: '19KSD0561',
                                title: 'Registration Number',
                                validator: Validators.validateRegNo,
                                controller: _regNoController,
                              ),
                              TextArea(
                                label: null,
                                obscureText: false,
                                hint: '9998887776',
                                title: 'Phone Number',
                                validator: Validators.validatePhoneNumber,
                                controller: _phoneNumberController,
                                inputType: TextInputType.phone,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: DropDown(
                                  itemsList: ["Male", "Female", "Other"],
                                  onChanged: (String changedValue) {
                                    setState(() {
                                      gender = changedValue;
                                    });
                                  },
                                  value: gender,
                                  title: "Gender",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SubmitButton(
                            buttonText:
                                widget.mode == ParticipantScreenMode.Edit
                                    ? 'Update'
                                    : 'Create',
                            onPressed: () {
                              if (widget.mode == ParticipantScreenMode.Edit) {
                                _updateParticipant(model);
                              } else {
                                _createParticipant(model);
                              }
                            },
                          ),
                          SubmitButton(
                            buttonText: 'Delete',
                            onPressed: widget.mode == ParticipantScreenMode.Edit
                                ? () {
                                    _deleteParticipant(model);
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  _loading
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
        );
      },
    );
  }

  void _createParticipant(MainModel model) async {
    setState(() {
      _autoValidate = true;
      _loading = true;
    });
    if (gender == null) {
      if (gender == null || gender == 'Choose') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MessageCard(
            message: 'Choose gender',
          ),
        );
        setState(() {
          _loading = false;
        });
        return;
      }
    }
    if (_validateAllFields()) {
      var response = await model.createParticipant(
        _nameController.text.trim(),
        _regNoController.text.trim(),
        _emailController.text.trim(),
        gender,
        _phoneNumberController.text.trim(),
        widget.currEvent.eventId,
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
      _loading = false;
    });
  }

  void _deleteParticipant(MainModel model) async {
    setState(() {
      _loading = true;
    });
    var response = await model.deleteParticipant(
        _regNoController.text.trim(), widget.currEvent.eventId, orgToken);
    if (response['code'] == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => SuccessCard(
          onPressed: () {
            Navigator.pop(context);
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
    setState(() {
      _loading = false;
    });
  }

  void _updateParticipant(MainModel model) async {
    setState(() {
      _autoValidate = true;
      _loading = true;
    });
    if (gender == null) {
      gender = "Male";
    }
    if (_validateAllFields()) {
      var response = await model.editParticipant(
        _nameController.text.trim(),
        _regNoController.text.trim(),
        _emailController.text.trim(),
        gender,
        _phoneNumberController.text.trim(),
        widget.currEvent.eventId,
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
              Navigator.pop(context);
              ExtendedNavigator.rootNavigator.pushNamed(
                Routes.participantListPage,
                arguments: ParticipantListPageArguments(
                  currEvent: widget.currEvent,
                ),
              );
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
      _loading = false;
    });
  }

  bool _validateAllFields() {
    return Validators.validateText(_nameController.text.trim()) == null &&
        Validators.validatePhoneNumber(_phoneNumberController.text.trim()) ==
            null &&
        Validators.validateEmail(_emailController.text.trim()) == null &&
        Validators.validateRegNo(_regNoController.text.trim()) == null;
  }
}
