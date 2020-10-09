import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

import '../../models/event.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/dimens.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/drop_down.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/heading.dart';
import '../../ui_utils/widgets/loading_card.dart';
import '../../ui_utils/widgets/message_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../utils/enums.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({
    @required this.currEvent,
    @required this.mode,
  });
  final Event currEvent;
  final ExportScreenMode mode;
  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  bool _loading = true, _loadingCard = false;

  int noOfDays;

  List<String> noOfDaysList = [];

  String orgToken, day, gender, participantType, filePath = '';

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
            actionsList: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: BColors.blue,
                ),
                onPressed: () {
                  Share.shareFiles([filePath], text: 'File');
                },
              ),
            ],
          ),
          body: _loading
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : IgnorePointer(
                  ignoring: _loadingCard,
                  child: Stack(
                    children: [
                      Container(
                        child: ListView(
                          children: <Widget>[
                            Heading(
                              headingText: widget.mode == ExportScreenMode.JSON
                                  ? 'JSON'
                                  : 'CSV',
                              headingTextSize: Dimens.smallHeadingTextSize,
                              headingFollowWidget: Text(''),
                              //Icon(
                              //  Icons.arrow_drop_down,
                              //  color: BColors.blue,
                              //),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: DropDown(
                                itemsList: noOfDaysList,
                                onChanged: (String changedValue) {
                                  setState(() {
                                    day = changedValue;
                                  });
                                },
                                value: day,
                                title: "Day",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: DropDown(
                                itemsList: ["Male", "Female", "Other", "All"],
                                onChanged: (String changedValue) {
                                  setState(() {
                                    gender = changedValue;
                                  });
                                },
                                value: gender,
                                title: 'Gender',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: DropDown(
                                itemsList: [
                                  "All",
                                  "Present",
                                  "Absent",
                                ],
                                onChanged: (String changedValue) {
                                  setState(() {
                                    participantType = changedValue;
                                  });
                                },
                                value: participantType,
                                title: 'Participant Type',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: SubmitButton(
                                buttonText: "Export",
                                onPressed: () {
                                  _getExport(model);
                                },
                              ),
                            ),
                            filePath == ''
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 10.0,
                                    ),
                                    child: Text(
                                      'File can be found at: ' + filePath,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              Dimens.smallHeadingTextSize),
                                    ),
                                  ),
                          ],
                        ),
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
        );
      },
    );
  }

  void _getExport(MainModel model) async {
    setState(() {
      _loadingCard = true;
      //day = day ?? "1";
      //gender = gender ?? "All";
      //participantType = participantType ?? "All";
    });
    if (day == null || day == 'Choose') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Choose day',
        ),
      );
      setState(() {
        _loadingCard = false;
      });
      return;
    }
    if (gender == null || gender == 'Choose') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Choose gender',
        ),
      );
      setState(() {
        _loadingCard = false;
      });
      return;
    }
    if (participantType == null || participantType == 'Choose') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Choose participant type',
        ),
      );
      setState(() {
        _loadingCard = false;
      });
      return;
    }
    if (widget.mode == ExportScreenMode.JSON) {
      var response = await model.getAllInJson(
        orgToken,
        widget.currEvent.eventId,
        day,
        gender,
        participantType,
      );
      if (response['code'] == 200) {
        _writeJSONToFile(response['data'].toString());
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => FailureCard(),
        );
      }
    } else if (widget.mode == ExportScreenMode.CSV) {
      var response = await model.getAllInCsv(
        orgToken,
        widget.currEvent.eventId,
        day,
        gender,
        participantType,
      );
      if (response['code'] == 200) {
        _writeCSVToFile(response['csv-data'].toString());
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

  void _writeJSONToFile(String data) async {
    final path = await _localPath;
    File selectedFile;
    if (participantType == "All") {
      selectedFile = File('$path/All_Participants.json');
    } else if (participantType == "Present") {
      selectedFile = File('$path/Present_Participants.json');
    } else if (participantType == "Absent") {
      selectedFile = File('$path/Absent_Participants.json');
    }
    selectedFile.writeAsString(data);
    setState(() {
      filePath = selectedFile.path;
    });
  }

  void _writeCSVToFile(String data) async {
    final path = await _localPath;
    File selectedFile;
    if (participantType == "All") {
      selectedFile = File('$path/All_Participants.csv');
    } else if (participantType == "Present") {
      selectedFile = File('$path/Present_Participants.csv');
    } else if (participantType == "Absent") {
      selectedFile = File('$path/Absent_Participants.csv');
    }
    selectedFile.writeAsString(data);
    setState(() {
      filePath = selectedFile.path;
    });
  }

  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
