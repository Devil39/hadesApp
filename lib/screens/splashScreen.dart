import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../theme.dart';
import '../userDataMangment.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';


class SplashScreen extends StatefulWidget {

  final ThemeBloc themeBloc;

  SplashScreen({Key key, this.themeBloc}) : super(key: key);
 @override
  State<StatefulWidget> createState() {
    return _SplashScreenState(themeBloc: themeBloc,);
  }
}
class _SplashScreenState extends State<SplashScreen> {

   final ThemeBloc themeBloc;

  _SplashScreenState({Key key, this.themeBloc});
  @override 
  void initState() {
    MainModel model = ScopedModel.of(context);
    checktext(model);
    // TODO: implement initState
    super.initState();
 go();

  }
    void go() {

      Future.delayed(const Duration(seconds: 3), () {
       
          if (set.compareTo(true.toString()) == 0) {
            new Future.delayed(
                const Duration(seconds: 0),
                    () =>
              Navigator.of(context).pushReplacementNamed('/getOrg')
            );
          }
          else if (set.compareTo(false.toString()) == 0) {
            print(set);
            new Future.delayed(
                const Duration(seconds: 0),

                   () => Navigator.of(context).pushReplacementNamed('/login')
            );
          }
          else {
            new Future.delayed(
                const Duration(seconds: 0),

                    () => Navigator.of(context).pushReplacementNamed('/login')

            );
          }
        
      });


  }

SharedPreferencesTest s=new SharedPreferencesTest();
  String set="yo";
  Future<bool> check;
   Future<bool> checktext(MainModel model) async {
    bool a=await model.isLoggedIn();
     check = s.getLoginCheck();
    //  print("Check:");
    //  print(a);
     if(a)
      {
        setState(() {
          // set = resultString.toString();
          set = a.toString();
          print(set);
        });
      }
    //  check.then((resultString) {
    //    setState(() {
    //     //  print("wsl;rgtyui");
    //     // print("Result String:");
    //     // print(resultString);
    //     set = resultString.toString();
    //      print(set);
    //    });
    //  });
   }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        // checktext()
        // checktext(model);
        // go();
        return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                //          Image.asset('images/dscnew.webp',
                // width: 90.0, height: 90.0, fit: BoxFit.cover),
                Image.asset('images/dsc_logo.jpg',
                width: 240.0, height: 240.0, fit: BoxFit.cover),
          
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        Text(
                          "Developer Student Clubs",
                          style: TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Loading...",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                           // color: Colors.white),
                      )
                      )],
                  ),
                )
              ],
            )
          ],
        ),
      ); 
      }
          // child: 
    );
    
  }
}