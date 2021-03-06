/*
>Convert Card to Container
>Search bar in Read participant view //Ask why it is not showing the correct data
>Change QR code library
>Drop Down for day selection in mark attendance
>Good Show up for app without internet connectivity
>Remove upload photo option
>Making server error screen beautiful
>Are u sure u want to delete-readCoupon
>Red color change on scanning
>Remove day selection from reedem
>Change No of days route
>Notification Screen, accept-delete container
>Download pdf for json
>Change create/join organization page
===========================================================================
Edit option in Read participant view
A screen for showing all users of org
***************************************************************************
Once check whether to delete a participant permanently or from the event.
Pin and password screen for participant change
First letter capital in participant create
Checkbox alignment in export
Export in download should show notification above
*/

/*
Features:
OnBoarding Screens
Splash Screen
Login Screen
SignUp Screen
Search and join org. Screen
Create org. Screen
Slack type change org. sidebar on homepage
Home page containing all events list, current org. name other visual or details as you think imp.
Create event Screen
Create Participant Screen
Edit participant details and also delete it: on screen for this
Accept/reject join request to org.: one screen for this
Export participant list:
 1) Json Format
 2) CSV format
 Filters availabe:
 1) Filter based on gender
 2) Filter based on day
 3) Filter based on participants nature, eg. in current app they are: present/absent/all participants.
View for Json format seperately
Create coupon screen
Redeem coupon screen(QR scan screen for this, alongwith day picker, also if QR fails an option to manually enter details(refer photos sent by me))
Attendee attendance, same parameters like redeem coupon
Mailing screens
  1)Mailing to all
  2)Mailing to specific set of persons
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:hades_app/models/get_Organization.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:scoped_model/scoped_model.dart';

import './screens/getOrganizationPage.dart';
import './screens/homePage.dart';
import './screens/login.dart';
import './theme.dart';
import 'screens_new/splash_page.dart';
import 'utils/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: themeBloc.initialTheme().data,
      stream: themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return ScopedModel<MainModel>(
          model: _model,
          child: MaterialApp(
            builder: ExtendedNavigator<Router>(router: Router()),
            debugShowCheckedModeBanner: false,
            title: 'Hades',
            theme: snapshot.data,
            home: SplashPage(),
            // initialized
            // ?SplashScreen(
            //   themeBloc: themeBloc,
            // ):Container(
            //   child: Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            routes: <String, WidgetBuilder>{
              '/homepage': (BuildContext context) => HomePage(
                    themeBloc: themeBloc,
                  ),
              '/getOrg': (BuildContext context) => GetOrganizationPage(),
              '/login': (BuildContext context) => LoginScreen(),
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  void initState() {
    _initializeHive();
    super.initState();
  }

  void _initializeHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    await Hive.init(appDocumentDir.path);
    Hive.registerAdapter(DataAdapter(), 0);
    Hive.registerAdapter(OrganizationAdapter(), 1);
    setState(() {
      initialized = true;
    });
    print("Hive Initialized!");
  }
}
