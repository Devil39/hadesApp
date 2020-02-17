import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as prefix1;
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/urls.dart';
// import 'package:hades_app/models/userModel.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';

import '../models/global.dart';
import '../userDataMangment.dart';
import '../util.dart' as prefix0;
import '../screens/getOrganizationPage.dart';
import 'homePage.dart';
import '../util.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextStyle style = TextStyle(
    fontSize: 20.0,
    color: Colors.pink,
  );

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  String _signname;
  String _signlastname;
  String _signusername;
  String _signemail;
  String _signmob;
  String _signpassword;
  String _signcpassword;
  bool _validate = false;

  SharedPreferencesTest s = new SharedPreferencesTest();

  Icon ic = Icon(
    Icons.lock_outline,
    color: Colors.grey,
  );

  void toHomePage() {
    _key.currentState?.reset();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => GetOrganizationPage()));
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));

    setState(() {
      _load = false;
    });
  }

//  pass(){
//    if(obsc){
//      setState(() {
//        ic=Icon(Icons.lock_open,color: Colors.pink,);
//        obsc=false;
//      });
//    }
//    else if(!obsc){
//      setState(() {
//        ic=Icon(Icons.lock_outline,color: Colors.grey,);
//        obsc=true;
//      });
//    }
//  }

  GlobalKey<FormState> _key = new GlobalKey();

  Map<String, dynamic> body = {
    "firstName": "test",
    "lastName": "test",
    "password": "test",
    "email": "test1@test.com",
    "phoneNumber": "998171818",
    "linkedIn": "test",
    "facebook": "test",
    "description": "test",
    "createdAt": "20-01-01"
  };

  @override
  void initState() {
    // new FirebaseNotifications().setUpFirebase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prefix0.backgroundColor,
        title: Text("REGISTER"),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: prefix0.backgroundColor,
      body: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model){
                return Form(
                  key: _key,
                  autovalidate: _validate,
                  child: formUI(model),
                );
              },
              child: Container(),
          ),
        );
      }

  bool _load = false;

  Widget formUI(MainModel model) {
    Widget loadingIndicator2 = _load
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
                        "Signing In...",
                        style: editText,
                      )
                    ],
                  )))),
            )))
        : new Container();
    return Stack(children: <Widget>[
      SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                color: prefix0.backgroundColor,
              ),
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Container(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
                        child: Theme(
                            data: new ThemeData(
                                primaryColor: Colors.blue,
                                accentColor: Colors.blue,
                                hintColor: Colors.blue),
                            child: TextFormField(
                              style: TextStyle(color: Colors.blue),
                              cursorColor: Theme.of(context).accentColor,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: prefix0.loginformText,
                                labelStyle: prefix0.loginformText,
                                // hintText: 'What People call you?',
                                labelText: 'First Name',
                              ),
                              controller: myController,
                              validator: validateName,
                              onSaved: (String val) {
                                _signname = myController.text.toString();
                              },
                            ))),
                    Container(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
                        child: Theme(
                            data: new ThemeData(
                                primaryColor: Colors.blue,
                                accentColor: Colors.blue,
                                hintColor: Colors.blue),
                            child: TextFormField(
                              style: TextStyle(color: Colors.blue),
                              cursorColor: Theme.of(context).accentColor,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: prefix0.loginformText,
                                labelStyle: prefix0.loginformText,
                                // hintText: 'What People call you?',
                                labelText: 'Last Name',
                              ),
                              controller: myController2,
                              validator: validateName,
                              onSaved: (String val) {
                                _signlastname = myController2.text.toString();
                              },
                            ))),
                    Container(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Theme(
                          data: new ThemeData(
                              primaryColor: Colors.blue,
                              accentColor: Colors.blue,
                              hintColor: Colors.blue),
                          child: new TextFormField(
                              style: TextStyle(color: Colors.blue),
                              cursorColor: Theme.of(context).accentColor,
                              decoration: new InputDecoration(
                                hintStyle: prefix0.loginformText,
                                labelStyle: prefix0.loginformText,
                                hintText: 'Email ID',
                                labelText: 'Email ID',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              onSaved: (String val) {
                                _signemail = val;
                              })),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                                  border: OutlineInputBorder(),
                                  hintText: 'Where your Friends can call you?',
                                  labelText: 'Mobile Number'),
                              keyboardType: TextInputType.phone,
                              validator: validateMobile,
                              onSaved: (String val) {
                                _signmob = val;
                              },
                            ))),
                    Container(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                                border: OutlineInputBorder(),
                                hintText: "**********",
                                labelText: 'Password'),
                            validator: (val) => val.length == 0
                                ? 'Please Enter the Password'
                                : (val.length < 6)
                                    ? 'Password too short'
                                    : null,
                            onSaved: (val) => _signpassword = val,
                            obscureText: true,
                          )),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                                border: OutlineInputBorder(),
                                hintText: "**********",
                                labelText: 'Confirm Password'),
                            validator: (val) => val.length == 0
                                ? 'Please Enter the Password'
                                : (val.length < 6)
                                    ? 'Password too short'
                                    : null,
                            onSaved: (val) => _signcpassword = val,
                            obscureText: true,
                          )),
                    ),
                    new Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: const EdgeInsets.only( right: 20.0, top: 30.0),
                        alignment: Alignment.center,
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 30.0),
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
                                          //  _load2=true;
                                          _sendToServer(model);
                                        });
                                      },
                                      child: new Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 20.0,
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Expanded(
                                              child: Text(
                                                "REGISTER",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                  ]))
                            ])),
                    Container(
                        alignment: Alignment(0, 0),
                        padding: EdgeInsets.only(top: 16, bottom: 2),
                        child: Text(
                          "By creating an account you agree to our",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )),
                    GestureDetector(
                        child: Container(
                            alignment: Alignment(0, 0),
                            padding: EdgeInsets.only(top: 2, bottom: 16),
                            child: Text(
                              "Terms of Service and Privacy Policy",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ))),
                  ])))),
      new Align(
        child: loadingIndicator2,
        alignment: FractionalOffset.center,
      ),
    ]);
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validateCpassword(String value) {
    if (value.length == 0) {
      return "Re-Type the password";
    } else if (value.compareTo(_signpassword) != 0) {
      return "Password did not match";
    } else {
      return null;
    }
  }

  _sendToServer(MainModel model) async {
    // print("Testing Hive!");
    // model.testHive();
    // return;
    // print("Something!");
    if (_key.currentState.validate()) {
      _load = true;
      _key.currentState.save();
      if (_signcpassword.compareTo(_signpassword) == 0) {
        // body["firstName"] = '$_signname';
        // body["lastName"] = '$_signlastname';
        // body["email"] = '$_signemail';
        // body["phoneNumber"] = '$_signmob';
        // body["password"] = '$_signpassword';
        body["email"]="$_signemail";
        body["password"]='$_signpassword';
        body["first_name"]="$_signname";
        body["last_name"]="$_signlastname";
        body["phone_number"]="$_signlastname";
        body["description"]="$_signlastname";
        // UserModel.signUp();
        var response=await model.signUp(email: _signemail, password: _signpassword, first_name: _signname, last_name: _signlastname, phone_number: _signmob);
        print(response);
        // response.then((){

        // });
        if (response["code"] == 200) {
        // final data = json.decode(response.body);

        // print(data);
        var data=response;
        if (data['message'].toString().compareTo("User account successfully saved") == 0) {
          // s.setToken(data["token"]);
          // s.setLoginCheck(true);
          Toast.show("Successful Signup", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          toHomePage();
        } else {
          Toast.show("User already exists", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          setState(() {
            _load = false;
          });
        }
      } else {
        // Toast.show("Server Error", context,
        //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Toast.show(response["message"], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        setState(() {
          _load = false;
        });
      }
        // Future fetchPosts(http.Client client) async {
        //   // print("yjhtgfdsyutrgds");
        //   var response = await http.post(
        //     url_signup+"/something",
        //     headers: {"Content-Type": "application/json"},
        //     body: json.encode(body),
        //   );

        //   print(response.statusCode);
        //   print(response.body);
        //   if (response.statusCode == 200) {
        //     final data = json.decode(response.body);

        //     print(data);
        //     if (data['message'].toString().compareTo("Done") == 0) {
        //       s.setToken(data["token"]);
        //       s.setLoginCheck(true);
        //       Toast.show("Successful Signup", context,
        //           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        //       toHomePage();
        //     } else {
        //       Toast.show("User already exists", context,
        //           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        //       setState(() {
        //         _load = false;
        //       });
        //     }
        //   } else {
        //     Toast.show("Server Error", context,
        //         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        //     setState(() {
        //       _load = false;
        //     });
        //   }
        // }

        // print(body);

        // return FutureBuilder(
        //     future: fetchPosts(http.Client()),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       return Container(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     });

//
      } else {
        setState(() {
          _load = false;
        });
        Toast.show("Password did not match", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
//

    else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
