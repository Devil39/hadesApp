import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hades_app/models/organization.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/router.gr.dart';
import '../models/scoped_models/mainModel.dart';
import '../ui_utils/colors.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //String token;
  //Future<String> _getToken(MainModel model) async {
  //  String _token = await model.getToken();
  //  setState(() {
  //    token = _token;
  //  });
  //  return token;
  //}

  _initializePage(MainModel model) async {
    //await _getToken(model);
    Future.delayed(const Duration(milliseconds: 2000), () async {
      bool showIntro = await model.showIntro();
      if (showIntro) {
        ExtendedNavigator.of(context)
            .pushReplacementNamed(Routes.onBoardingScreen);
        return;
      }
      bool isLoggedIn = await model.isLoggedIn();
      //ExtendedNavigator.of(context)
      //    .pushReplacementNamed(Routes.loginPage);
      //return;
      if (isLoggedIn) {
        var resp = await model.getStoredOrgList();
        print(resp);
        if (resp != null && resp.organization.length != 0) {
          ExtendedNavigator.of(context).pushReplacementNamed(Routes.homePage);
        } else {
          ExtendedNavigator.of(context)
              .pushReplacementNamed(Routes.getOrganizationPage);
        }
      } else {
        ExtendedNavigator.of(context).pushReplacementNamed(Routes.loginPage);
      }
    });
  }

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BColors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/dsc_logo_2.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 57),
                  child: Text(
                    'HADES',
                    style: TextStyle(
                      letterSpacing: 9.0,
                      fontWeight: FontWeight.w700,
                      fontSize: 60.0,
                    ),
                  ),
                ),
                Container(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
