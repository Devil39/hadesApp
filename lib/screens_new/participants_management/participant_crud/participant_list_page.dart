import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/event.dart';
import '../../../models/read_attendee.dart';
import '../../../models/scoped_models/mainModel.dart';
import '../../../ui_utils/colors.dart';
import '../../../ui_utils/dimens.dart';
import '../../../ui_utils/widgets/app_bar.dart';
import '../../../ui_utils/widgets/failure_card.dart';
import '../../../ui_utils/widgets/heading.dart';
import '../../../ui_utils/widgets/photo_card.dart';
import '../../../utils/enums.dart';
import '../../../utils/router.gr.dart';

class ParticipantListPage extends StatefulWidget {
  const ParticipantListPage({
    @required this.currEvent,
  });

  final Event currEvent;

  @override
  _ParticipantListPageState createState() => _ParticipantListPageState();
}

class _ParticipantListPageState extends State<ParticipantListPage> {
  String orgToken;

  bool loading = true, search = false;

  List<ReadAttendee> allParticipants = [];
  List<ReadAttendee> filteredParticipants = [];

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getAllParticipants(model);
    setState(() {
      loading = false;
    });
  }

  void _searchParticipant(
    String searchText,
    MainModel model,
  ) async {
    filteredParticipants = [];
    searchText = searchText.trim();
    if (searchText != "") {
      setState(() {
        search = true;
      });
      var a = await model.searchParticipant(searchText, allParticipants);
      if (a.length > 0) {
        setState(() {
          filteredParticipants = a;
        });
      }
    } else {
      setState(() {
        search = false;
      });
    }
  }

  Future<void> _getAllParticipants(MainModel model) async {
    var response = await model.getAllParticipants(
      '1',
      widget.currEvent.eventId,
      orgToken,
    );
    if (response['code'] == 200) {
      if (response["event"]["attendees"].length == 0) {
        return "No Data to be Fetched";
      }
      List<ReadAttendee> participants = new List<ReadAttendee>();
      for (int i = 0; i < response["event"]["attendees"].length; i++) {
        participants
            .add(new ReadAttendee.fromJson(response["event"]["attendees"][i]));
      }
      setState(() {
        allParticipants = participants;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(),
      );
      Navigator.pop(context);
      Navigator.pop(context);
    }
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
          appBar: Header(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: BColors.blue,
              ),
            ),
            title: widget.currEvent.name,
          ),
          body: Container(
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(headingText: 'Read Form'),
                      Heading(
                        headingText: 'View',
                        headingTextSize: Dimens.smallHeadingTextSize,
                        headingFollowWidget: Text(''),
                        //Icon(
                        //  Icons.arrow_drop_down,
                        //  color: BColors.blue,
                        //),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.87,
                          margin: EdgeInsets.only(bottom: 27.0),
                          child: Material(
                            elevation: 6.0,
                            shadowColor: BColors.black,
                            borderRadius: BorderRadius.circular(12.0),
                            child: TextField(
                              onChanged: (searchText) {
                                _searchParticipant(searchText, model);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 5.0,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: BColors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      allParticipants.length == 0
                          ? Expanded(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'No Participants!',
                                    style: TextStyle(
                                      fontSize: Dimens.smallHeadingTextSize,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: search
                                    ? filteredParticipants.length
                                    : allParticipants.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      ExtendedNavigator.rootNavigator.pushNamed(
                                        Routes.participantCreateEditPage,
                                        arguments:
                                            ParticipantCreateEditPageArguments(
                                          mode: ParticipantScreenMode.Edit,
                                          participant: allParticipants[index],
                                          currEvent: widget.currEvent,
                                        ),
                                      );
                                    },
                                    child: PhotoCard(
                                      tileTitle: search
                                          ? filteredParticipants[index].name
                                          : allParticipants[index].name,
                                      tileImage: 'images/orgPng.png',
                                      icon: Container(
                                        width: 50.0,
                                        height: 69.0,
                                        child: Icon(
                                          Icons.person,
                                          color: BColors.blue,
                                          size: 39.0,
                                        ),
                                      ),
                                      tileSubtitle: search
                                          ? filteredParticipants[index].email
                                          : allParticipants[index].email,
                                      tileTrailing: Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward,
                                            color: BColors.blue,
                                          ),
                                          onPressed: () {
                                            ExtendedNavigator.rootNavigator
                                                .pushNamed(
                                              Routes.participantCreateEditPage,
                                              arguments:
                                                  ParticipantCreateEditPageArguments(
                                                mode:
                                                    ParticipantScreenMode.Edit,
                                                participant:
                                                    allParticipants[index],
                                                currEvent: widget.currEvent,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
