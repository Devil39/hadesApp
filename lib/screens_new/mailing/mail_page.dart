import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/event.dart';
import '../../models/read_attendee.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/dimens.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/heading.dart';
import '../../ui_utils/widgets/loading_card.dart';
import '../../ui_utils/widgets/message_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../ui_utils/widgets/success_card.dart';
import '../../utils/enums.dart';
import '../../utils/validators.dart';

class MailPage extends StatefulWidget {
  MailPage({
    @required this.mode,
    @required this.currEvent,
  });

  final MailingScreenMode mode;
  final Event currEvent;

  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  List<String> _emails = [];

  File file;

  String errFile = "", orgToken;

  List<ReadAttendee> allParticipants = [];

  bool _loading = true;

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
    return Scaffold(
      appBar: Header(
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: BColors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: widget.currEvent.name,
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return IgnorePointer(
          ignoring: _loading,
          child: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Heading(
                        headingText: 'Mailing Service: ',
                        headingFollowText: widget.mode == MailingScreenMode.All
                            ? "All"
                            : "Specific",
                        headingTextSize: Dimens.smallHeadingTextSize,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMailPageRows(
                              headingText: 'To ',
                              widget: Text(
                                widget.mode == MailingScreenMode.All
                                    ? 'Everyone who attends the event.'
                                    : 'Everyone mentioned in the list',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimens.smallerHeadingTextSize,
                                ),
                              ),
                            ),
                            widget.mode == MailingScreenMode.All
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: BColors.black),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Tags(
                                          columns: 1,
                                          key: _tagStateKey,
                                          itemCount: _emails.length,
                                          itemBuilder: (int index) {
                                            final email = _emails[index];
                                            return ItemTags(
                                              key: Key(index.toString()),
                                              activeColor: BColors.blue,
                                              index: index,
                                              title: email,
                                              combine: ItemTagsCombine
                                                  .withTextBefore,
                                              removeButton:
                                                  ItemTagsRemoveButton(
                                                      onRemoved: () {
                                                setState(() {
                                                  _emails.removeAt(index);
                                                });
                                                return true;
                                              }),
                                            );
                                          },
                                          textField: TagsTextField(
                                            hintText: "Add email address",
                                            autofocus: false,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.87,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            duplicates: false,
                                            onSubmitted: (String str) {
                                              if (Validators.validateEmail(
                                                      str) ==
                                                  null) {
                                                setState(() {
                                                  _emails.add(str);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            _buildMailPageRows(
                              headingText: 'Subject ',
                              widget: Container(
                                child: TextFormField(
                                  controller: _subjectController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: BColors.backgroundBlue,
                                  ),
                                  validator: Validators.validateText,
                                ),
                              ),
                            ),
                            _buildMailPageRows(
                              headingText: 'Body ',
                              widget: Container(
                                child: TextFormField(
                                  controller: _bodyController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: BColors.backgroundBlue,
                                  ),
                                  validator: Validators.validateText,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 27.0,
                              ),
                              child: Row(
                                children: [
                                  SubmitButton(
                                    buttonText: 'Attach File',
                                    onPressed: () async {
                                      try {
                                        File selectedFile =
                                            await FilePicker.getFile();
                                        setState(() {
                                          file = selectedFile;
                                        });
                                      } on Exception catch (err) {
                                        setState(() {
                                          errFile = err.toString();
                                        });
                                      }
                                    },
                                    backgroundColor: BColors.white,
                                    fontColor: BColors.black,
                                    borderColor: BColors.white,
                                  ),
                                  file == null
                                      ? errFile != ""
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Icon(
                                                Icons.cancel,
                                                color: BColors.red,
                                                size: Dimens.headingTextSize,
                                              ),
                                            )
                                          : Container()
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Icon(
                                            Icons.done,
                                            color: BColors.green,
                                            size: Dimens.headingTextSize,
                                          ),
                                        ),
                                  file == null
                                      ? errFile != ""
                                          ? Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                  "Error picking file, please try again",
                                                  style: TextStyle(
                                                    fontSize: Dimens
                                                        .smallHeadingTextSize,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container()
                                      : Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              file.path.split("/")[
                                                  (file.path.split("/"))
                                                          .length -
                                                      1],
                                              style: TextStyle(
                                                fontSize:
                                                    Dimens.smallHeadingTextSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 27.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SubmitButton(
                                    buttonText: 'Send',
                                    onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      final allEmails =
                                          await _getAllEmails(model);
                                      widget.mode == MailingScreenMode.All
                                          ? _sendSpecificMails(
                                              model: model,
                                              eventId: widget.currEvent.eventId,
                                              orgToken: orgToken,
                                              emails: allEmails,
                                              body: _bodyController.text,
                                              title: _subjectController.text,
                                              from: await model.getUserEmail(),
                                              name: widget.currEvent.name,
                                            )
                                          : _sendSpecificMails(
                                              model: model,
                                              eventId: widget.currEvent.eventId,
                                              orgToken: orgToken,
                                              emails: _emails,
                                              body: _bodyController.text.trim(),
                                              title: _subjectController.text
                                                  .trim(),
                                              from: await model.getUserEmail(),
                                              name: widget.currEvent.name,
                                            );
                                    },
                                  ),
                                  SubmitButton(
                                    buttonText: 'Discard',
                                    onPressed: () {
                                      setState(() {
                                        _emails = [];
                                        _subjectController.text = "";
                                        _bodyController.text = "";
                                        file = null;
                                        errFile = "";
                                      });
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
      }),
    );
  }

  Widget _buildMailPageRows({
    @required String headingText,
    @required Widget widget,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(
            headingText: headingText,
            headingTextSize: Dimens.smallHeadingTextSize,
            headingFollowWidget: Text(''),
            //headingText != ''
            //    ? Icon(
            //        Icons.arrow_drop_down,
            //        color: BColors.blue,
            //      )
            //    : Text(''),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 27.0,
            ),
            child: widget,
          ),
        ],
      ),
    );
  }

  void _sendSpecificMails({
    @required MainModel model,
    @required int eventId,
    @required String orgToken,
    @required List<String> emails,
    @required String body,
    @required String title,
    @required String from,
    @required String name,
  }) async {
    print(orgToken);
    print(_validateAll());
    if (_validateAll() && orgToken == "") {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Invalid, check fields again',
        ),
      );
      return;
    }

    var a = model.sendMails(
      eventId,
      orgToken,
      emails,
      body,
      title,
      from,
      name,
      false,
      file,
    );

    var response;

    await a.then((res) {
      response = res;
    });

    if (response['code'] == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => SuccessCard(
          onPressed: () {
            Navigator.pop(context);
          },
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

  Future<List<String>> _getAllEmails(MainModel model) async {
    List<String> emails = [];
    var resp =
        await model.getAllParticipants('1', widget.currEvent.eventId, orgToken);
    if (resp['code'] == 200) {
      if (resp["event"]["attendees"].length == 0) {
        if (widget.mode == MailingScreenMode.All) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => MessageCard(
              message: 'No Participants',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          );
        }
      }
      List<ReadAttendee> participants = new List<ReadAttendee>();
      for (int i = 0; i < resp["event"]["attendees"].length; i++) {
        participants
            .add(new ReadAttendee.fromJson(resp["event"]["attendees"][i]));
      }
      setState(() {
        allParticipants = participants;
      });
      for (int i = 0; i < participants.length; i++) {
        emails.add(participants[i].email);
      }
      return emails;
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
    }
    return [];
  }

  bool _validateAll() {
    return Validators.validateText(_bodyController.text.trim()) == null &&
        Validators.validateText(_subjectController.text.trim()) == null &&
        _emails.length != 0;
  }
}
