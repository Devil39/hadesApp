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
>Create Event: Budget and days
>Scroll in sidebar of home page
>White color conversion in that circle avatar
>Popup in Edit participant screen
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

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import './screens/homePage.dart';
import './screens/splashScreen.dart';
import './theme.dart';
import './screens/getOrganizationPage.dart';
import './screens/login.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/get_Organization.dart';
// import 'package:hades_app/models/get_Organization.g.dart';
// main()=>runApp(MyApp());

void main() async {  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model=MainModel();
  bool initialized=false;

  void _initializeHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    await Hive.init(appDocumentDir.path);
    Hive.registerAdapter(DataAdapter(), 0);
    Hive.registerAdapter(OrganizationAdapter(), 1);
    setState((){
      initialized= true;
    });
    print("Hive Initialized!");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    _initializeHive();
  }

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
            debugShowCheckedModeBanner: false,
            title: 'Hades',
            theme: snapshot.data,
            home: initialized
            ?SplashScreen(
              themeBloc: themeBloc,
            ):Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            routes: <String, WidgetBuilder> {
              '/homepage': (BuildContext context) => HomePage(
              themeBloc: themeBloc,),
              '/getOrg':(BuildContext context)=>GetOrganizationPage(),
              '/login':(BuildContext context)=>LoginScreen(),
            },
          ),
        );
      },
    );  
  }
  @override
  void dispose() {
    Hive.close();
  }
}