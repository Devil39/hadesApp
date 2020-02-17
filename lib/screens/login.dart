import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:scoped_model/scoped_model.dart';


import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../util.dart';
import '../models/global.dart';
import '../userDataMangment.dart';
import '../screens/signupPage.dart';
import '../util.dart' as prefix0;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(
    fontSize: 20.0,
    color: Colors.pink,
  );

  bool _validate = false;
  String logemail;
  String _logpass;
  bool obsc = true;

  String meth;
  Icon ic = Icon(
    Icons.lock_outline,
    color: Colors.grey,
  );

  void toHomePage() {
    // Process your data and upload to server
    _key.currentState?.reset();
    _load = false;
    Navigator.of(context).pushReplacementNamed('/getOrg');
//    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(index: 0,)));
  }

  void toSignupPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  GlobalKey<FormState> _key = new GlobalKey();

  Map<String, dynamic> body = {
    "email": "pratz@gmail.com",
    "password": "qwerty",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SharedPreferencesTest s = new SharedPreferencesTest();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            elevation: 0,
            centerTitle: true,
            backgroundColor: prefix0.backgroundColor,
          ),
          backgroundColor: prefix0.backgroundColor,
          body: new Form(
            key: _key,
            autovalidate: _validate,
            child: FormUI(model),
          ),
        );
      }
                // child: ,
    );
  }

  bool _load = false;
//  SharedPreferencesTest s = new SharedPreferencesTest();

  Widget FormUI(MainModel model) {
    Widget loadingIndicator = _load
        ? Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: RadialGradient(
                  stops: [0.1, 10],
                  colors: [
//
                    Colors.grey[200],

                    Colors.grey[400],
                  ],
                ),
              ),
              child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Center(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "Logging In...",
                        style: introText,
                      )
                    ],
                  )))),
            )))
        : new Container();

    int flag;
    return Stack(children: <Widget>[
      SingleChildScrollView(
          child: Container(
              color: prefix0.backgroundColor,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: prefix0.backgroundColor,
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(5),
                          height: 130,
                          width: 90,
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 26.0),
                            child: Theme(
                                data: new ThemeData(
                                    primaryColor: Colors.blue,
                                    accentColor: Colors.blue,
                                    hintColor: Colors.blue),
                                child: TextFormField(
                                    style: TextStyle(color: Colors.blue),
                                    cursorColor: Colors.blue,
                                    decoration: const InputDecoration(
                                        hintStyle: prefix0.loginformText,
                                        labelStyle: prefix0.loginformText,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        hintText: 'eg@gmail.com',
                                        labelText: 'Email'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEM,
                                    onSaved: (String val) {
                                      logemail = val;
                                      print(logemail);
                                    }))),
                        Container(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Theme(
                                data: new ThemeData(
                                    primaryColor: Colors.blue,
                                    accentColor: Colors.blue,
                                    hintColor: Colors.blue),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.blue),
                                  cursorColor: Theme.of(context).accentColor,
                                  decoration: const InputDecoration(
                                      hintStyle: prefix0.loginformText,
                                      labelStyle: prefix0.loginformText,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
//                              suffixIcon:IconButton(icon: Icon(Icons.lock_outline,color: Colors.grey,), onPressed:() {})
                                      hintText: '******',
                                      labelText: 'Password'),
                                  validator: (val) => val.length == 0
                                      ? 'Please Enter the Password'
                                      : (val.length < 6)
                                          ? 'Password too short'
                                          : null,
                                  onSaved: (val) => _logpass = val,
                                  obscureText: true,
                                ))),
                        Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey[400],
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            width: 200,
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: new Row(children: <Widget>[
                              new Expanded(
                                  child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    //  _load=true;
                                    _login_Server(model);
                                  });
                                },
                                child: new Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "LOGIN",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ])),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
//                     GestureDetector(
//                         onTap: () {
// //                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
//                         },
//                         child: Container(
//                           child: Text("Forgot Password?", style: blackNormalText,),
//                         )),
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: 200,
                            margin: EdgeInsets.only(top: 2, bottom: 80),
                            alignment: Alignment.center,
                            child: new Row(children: <Widget>[
                              new Expanded(
                                  child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    toSignupPage();
                                  });
                                },
                                child: new Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "REGISTER",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ]))
                      ],
                    )
                  ]))),
      new Align(
        child: loadingIndicator,
        alignment: FractionalOffset.center,
      ),
    ]);
  }

  String validateEM(String value) {
    print(value);
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    String pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp1 = new RegExp(pattern1);
    if (regExp.hasMatch(value) && (value.isNotEmpty)) {
      meth = "phoneNo";

      if (value.length == 0) {
        return "Mobile is Required";
      } else if (value.length != 10) {
        return "Mobile number must 10 digits";
      } else if (!regExp.hasMatch(value)) {
        return "Mobile Number must be digits";
      }
      return null;
    } else if (regExp1.hasMatch(value) && value.isNotEmpty) {
      meth = "email";
      if (value.length == 0) {
        return "Email is Required";
      } else if (!regExp1.hasMatch(value)) {
        return "Invalid Email";
      } else {
        return null;
      }
    } else {
      return "Enter the Details";
    }
  }

  _login_Server(MainModel model) async {
    // print("Something!");
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _load = true;

      body["email"] = '$logemail';
      body["password"] = '$_logpass';
      var resp=await model.logIn(email: logemail, password: _logpass);
      // print(resp);
      var response=resp;
      // print(response.status);
      // print(response["status"]);
      // print(response["status"] == 200);
      if (response["code"] == 200) {
      // final data = json.decode(response.body);
      final data = response;
        // s.setToken(data["token"]);
        // s.setLoginCheck(true);
        // print(data);
        toHomePage();
        // if (data["rs"].toString().compareTo("Done") == 0) {
        //   s.setToken(data["token"]);
        //   toHomePage();
        // }
      }
      else {
        if(response["code"]==500) {
          final data = json.decode(response.body);
          Toast.show(data["err"].toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          setState(() {
            _load = false;
          });
        }
        else{
          setState(() {
            _load = false;
          });
          Toast.show("Try again", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }
//       Future fetchPosts(http.Client client) async {
//         print("yjhtgfdsyutrgds");
//         var response = await http.post(
//           URL_LOGIN, headers: {"Content-Type": "application/json"},
//           body: json.encode(body),);

//         print(response.statusCode);
//         print(response.body);
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);

//             s.setToken(data["token"]);
//             s.setLoginCheck(true);
//             toHomePage();

//             print(data);

//             if (data["rs"].toString().compareTo("Done") == 0) {
//               s.setToken(data["token"]);
//               toHomePage();
//             }

//         }
//         else {

//           if(response.statusCode==500) {
//             final data = json.decode(response.body);
//             Toast.show(data["err"].toString(), context,
//                 duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//             setState(() {
//               _load = false;
//             });
//           }
//           else{
//             setState(() {
//               _load = false;
//             });
//             Toast.show("Try again", context,
//                 duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//           }
//         }
//       }

//       print(body);

//       return FutureBuilder(

//           future: fetchPosts(http.Client()),
//           builder: (BuildContext context,AsyncSnapshot snapshot){
//             if(snapshot.data==null){
//               return Container(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );

//             }
//             else{
// return Container();
//             }
//           });

    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
