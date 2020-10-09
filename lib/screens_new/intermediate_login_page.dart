import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/scoped_models/mainModel.dart';
import '../ui_utils/widgets/failure_card.dart';
import '../utils/router.gr.dart';

class IntermediateLoginPage extends StatefulWidget {
  const IntermediateLoginPage({
    @required this.orgId,
    @required this.token,
  });

  final int orgId;
  final String token;

  @override
  _IntermediateLoginPageState createState() => _IntermediateLoginPageState();
}

class _IntermediateLoginPageState extends State<IntermediateLoginPage> {
  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _orgLogIn(model);
    super.initState();
  }

  void _orgLogIn(MainModel model) async {
    var resp = await model.orgLogIn(widget.token, widget.orgId);
    print(resp);
    if (resp['code'] == 200) {
      print("Done dune");
      model.setCurrentOrgId(widget.orgId);
      ExtendedNavigator.rootNavigator.pushReplacementNamed(Routes.homePage);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FailureCard(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
