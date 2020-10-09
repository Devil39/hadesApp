import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//import 'package:toast/toast.dart';

import '../../models/organization.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/message_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../ui_utils/widgets/success_card.dart';
import '../../utils/router.gr.dart';

class JoinOrgDetailPage extends StatefulWidget {
  JoinOrgDetailPage({@required this.org});

  final Organization org;

  @override
  _JoinOrgDetailPageState createState() => _JoinOrgDetailPageState();
}

class _JoinOrgDetailPageState extends State<JoinOrgDetailPage> {
  String token;
  bool _loading = true;

  Future<String> _getToken(MainModel model) async {
    String _token = await model.getToken();
    setState(() {
      token = _token;
    });
    return token;
  }

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _getToken(model);
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
            title: widget.org.fullName,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: BColors.blue,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSize: 21.0,
          ),
          body: _loading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : IgnorePointer(
                  ignoring: _loading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.symmetric(
                      //     horizontal: 27.0,
                      //     vertical: 0.0,
                      //   ),
                      //   child: Text(
                      //     'Developers Student Club',
                      //     style: TextStyle(
                      //       fontSize: Dimens.headingTextSize,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 108.0,
                        height: 108.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/orgPng.png'),
                          ),
                        ),
                      ),
                      Container(
                        color: BColors.white,
                        width: double.infinity,
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.org.description),
                            Text(widget.org.website),
                            Text(widget.org.location),
                          ],
                        ),
                      ),
                      SubmitButton(
                        buttonText: 'Join',
                        onPressed: () async {
                          _sendReqToOrg(model);
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _sendReqToOrg(MainModel model) async {
    setState(() {
      _loading = true;
    });
    var result = model.sendReqToOrg(
      token,
      widget.org.org_id,
      widget.org.website,
    );
    var resp;
    await result.then((res) {
      resp = res;
    });
    setState(() {
      _loading = false;
    });
    if (resp["code"] == 200) {
      var data = resp;
      if (data["message"] == "Join request created successfully") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessCard(),
        );
        var a = model.getOrgList(token);
        var response;
        await a.then((res) {
          response = res;
        });
        if (response["code"] == 200) {
          if (response["organizations"] == null ||
              response["organizations"].length == 0) {
            //showDialog(
            //  context: context,
            //  barrierDismissible: false,
            //  builder: (context) => MessageCard(
            //    message: 'Please wait, you are part of no org',
            //  ),
            //);
            //Toast.show(
            //  "You have to wait for the request to be accepted as you are part of no organization",
            //  context,
            //  duration: Toast.LENGTH_LONG,
            //  gravity: Toast.BOTTOM,
            //);
          } else {
            ExtendedNavigator.rootNavigator
                .pushReplacementNamed(Routes.homePage);
          }
        }
      } else {
        //Toast.show("Joining Request Sent!", context,
        //    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessCard(),
        );
      }
    } else if (resp["code"] == 409) {
      //Toast.show("Joining request is already pending", context,
      //    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MessageCard(
          message: 'Already Pending',
        ),
      );
    } else {
      //Toast.show("Try Again", context,
      //    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(),
      );
    }
  }
}
