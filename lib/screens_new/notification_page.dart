import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/scoped_models/mainModel.dart';
import '../models/organization.dart';
import '../ui_utils/colors.dart';
import '../ui_utils/dimens.dart';
import '../ui_utils/widgets/failure_card.dart';
import '../ui_utils/widgets/success_card.dart';
import '../ui_utils/widgets/photo_card.dart';
import '../utils/enums.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    @required this.currOrg,
    @required this.orgToken,
    @required this.joinReqs,
    @required this.removeReqAtIndex,
  });

  final String orgToken;
  final Organization currOrg;
  final List<dynamic> joinReqs;
  final Function removeReqAtIndex;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 36.0, left: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 9.0),
                    child: Icon(
                      Icons.notifications,
                      color: BColors.blue,
                    ),
                  ),
                  Text(
                    'Requests',
                    style: TextStyle(fontSize: Dimens.headingTextSize),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(9.0),
              child: Text(
                'Swipe to accept/reject requests',
                style: TextStyle(fontSize: Dimens.smallerHeadingTextSize),
              ),
            ),
            joinReqs.length == 0
                ? Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          'No pending requests!',
                          style:
                              TextStyle(fontSize: Dimens.smallHeadingTextSize),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: joinReqs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              reqStatus status = reqStatus.Decline;
                              _changeJoinReqStatus(
                                index,
                                joinReqs[index]['email'],
                                model,
                                context,
                                status,
                              );
                            } else {
                              reqStatus status = reqStatus.Accept;
                              _changeJoinReqStatus(
                                index,
                                joinReqs[index]['email'],
                                model,
                                context,
                                status,
                              );
                            }
                          },
                          key: Key(joinReqs[index]['email']),
                          background: Container(
                            color: BColors.green,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.done,
                                  color: BColors.black,
                                ),
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: BColors.red,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ),
                          child: PhotoCard(
                            tileTitle: joinReqs[index]['email'],
                            tileImage: 'images/orgPng.png',
                            tileTrailing: null,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      );
    });
  }

  void _changeJoinReqStatus(
    int index,
    String email,
    MainModel model,
    BuildContext context,
    reqStatus status,
  ) async {
    var response;
    if (status == reqStatus.Accept) {
      response = await model.acceptJoinReq(currOrg.org_id, email, orgToken);
    }
    if (status == reqStatus.Decline) {
      response = await model.declineJoinReq(currOrg.org_id, email, orgToken);
    }
    if (response["code"] == 200) {
      removeReqAtIndex(index);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => SuccessCard(),
      );
      //Future.delayed(Duration(seconds: 1), () {
      //  Navigator.pop(context);
      //});
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }
}
