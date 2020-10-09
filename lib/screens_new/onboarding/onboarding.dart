import 'package:auto_route/auto_route.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

import '../../utils/router.gr.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageList = [
    PageModel(
      color: const Color(0xFF678FB4),
      // color: const Color(0xffff0000),
      heroAssetPath: 'images/onboarding-1.webp',
      //heroAssetPath: '',
      title: Text('', //Hotels
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Container(
        child: Column(
          children: [
            Text(
              'Description of Participant Management, description of Management',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      iconAssetPath: 'images/onboarding-1.webp',
    ),
    PageModel(
      color: const Color(0xFF65B0B4),
      //color: const Color(0xff0000ff),
      //heroAssetPath: 'images/orgPng.png',
      heroAssetPath: 'images/onboarding-2.png',
      title: Text(
        '', //Banks
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Text(
        'Description of Participant Management, description of Management',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'images/onboarding-2.png',
    ),
    PageModel(
      color: const Color(0xFF9B90BC),
      //color: const Color(0xff008000),
      heroAssetPath: 'images/onboarding-3.png',
      title: Text('', //'Store'
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text(
        'Description of Participant Management, description of Management',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'images/onboarding-3.png',
    ),
    PageModel(
      color: const Color(0xFF678FB4),
      //color: const Color(0xFF678FB4),
      heroAssetPath: 'images/onboarding-4.png',
      title: Text(
        '', //Store
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Text(
        'Description of Participant Management, description of Management',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'images/onboarding-4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () => ExtendedNavigator.rootNavigator
            .pushReplacementNamed(Routes.loginPage),
        onSkipButtonPressed: () => ExtendedNavigator.rootNavigator
            .pushReplacementNamed(Routes.loginPage),
      ),
    );
  }
}
