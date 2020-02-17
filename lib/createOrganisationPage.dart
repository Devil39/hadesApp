import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import './util.dart' as prefix0;
import './util.dart';
import './models/global.dart';
import './userDataMangment.dart';
import './screens/signupPage.dart';

class CreateOrganisationScreen extends StatefulWidget {
  @override
  _CreateOrganisationScreenState createState() =>
      _CreateOrganisationScreenState();
}

class _CreateOrganisationScreenState extends State<CreateOrganisationScreen> {
  TextStyle style = TextStyle(
    fontSize: 20.0,
    color: Colors.pink,
  );

  bool _validate = false;
  String logemail;
  String _logpass;
  bool obsc = true;
  File galleryFile;

  String meth;
  Icon ic = Icon(
    Icons.lock_outline,
    color: Colors.grey,
  );

  void toHomePage() {
    // Process your data and upload to server
    _key.currentState?.reset();
    _load = false;
    Navigator.of(context).pushReplacementNamed('/homepage');
//    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(index: 0,)));
  }

  void toSignupPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  GlobalKey<FormState> _key = new GlobalKey();

  Map<String, dynamic> body = {
    "name": "",
    "location": "",
    "description": "",
    "tag": "",
    "website": ""
  };

  String token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainModel model = ScopedModel.of(context);
    _getToken(model);
    // Future<String> tt=s.getToken();
    // tt.then((value){
    // setState(() {
    // token=value;
    // });
    // });
  }

  void _getToken(MainModel model) async {
    String _token = await model.getToken();
    setState(() {
      token = _token;
    });
  }

  SharedPreferencesTest s = new SharedPreferencesTest();

  String orgName;
  String orgLocation;
  String orgDes;
  String orgWeb;
  String orgtag;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
        appBar: AppBar(
          title: Text("Create Organization"),
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
      },
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
                        "Creating Organisation...",
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

                                        // hintText: 'eg@gmail.com',
                                        labelText: 'Name'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateName,
                                    onSaved: (String val) {
                                      orgName = val;
                                    }))),
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

                                        // hintText: 'eg@gmail.com',
                                        labelText: 'Location'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateName,
                                    onSaved: (String val) {
                                      orgLocation = val;
                                      print(logemail);
                                    }))),
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

                                        // hintText: 'eg@gmail.com',
                                        labelText: 'Description'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateName,
                                    onSaved: (String val) {
                                      orgDes = val;
                                    }))),

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

                                        // hintText: 'eg@gmail.com',
                                        labelText: 'Website'),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String val) {
                                      orgWeb = val;
                                    }))),
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 16, 16,0),
                          height: 40,
                          margin: EdgeInsets.only(
                            top: 16,
                          ),
                          width: MediaQuery.of(context).size.width - 30,

                          decoration: BoxDecoration(
                              color: prefix0.backgroundColor,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: prefix0.backgroundColor,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            margin: EdgeInsets.all(1),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Upload Logo",
                                      style: loginformText,
                                    )),
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      imageSelectorGallery();
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        margin:
                                            EdgeInsets.only(left: 16, top: 2),
                                        // padding: EdgeInsets.only(bottom: 4,right: 2),
                                        decoration: BoxDecoration(
                                          color: profilebool
                                              ? Colors.green
                                              : Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.grey[400],
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          //  margin: EdgeInsets.only(bottom: ,right: 2),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ),

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
                                    // _login_Server();
                                    _createOrg(model);
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
                                          "Create",
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
                      ],
                    )
                  ]))),
      new Align(
        child: loadingIndicator,
        alignment: FractionalOffset.center,
      ),
    ]);
  }

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,

      // maxHeight: 50.0,
      // maxWidth: 50.0,
    );
    setState(() {
      profilebool = true;
    });
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

  bool profilebool = false;
  String image_upload_url = "default_image";
  _createOrg(MainModel model) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _load = true;

      if (profilebool == true) {
        // FirebaseApp.initializeApp(this);

        try {
          StorageReference storageRef = FirebaseStorage.instance
              .ref()
              .child("Organization")
              .child("${orgName}.jpg");

          final StorageUploadTask uploadTask = storageRef.putFile(galleryFile);
          final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
          final String url = (await downloadUrl.ref.getDownloadURL());
          image_upload_url = url.toString();

          print('URL Is $url');
        } catch (e) {
          print("Error is " + e.toString());
        }
      }

      body["name"] = '$orgName';
      body["location"] = '$orgLocation';
      body["description"] = '$orgDes';
      body["tag"] = '$image_upload_url';
      body["website"] = '$orgWeb';

      print(body);

      Future fetchPosts(http.Client client, MainModel model) async {
        print("yjhtgfdsyutrgds");
        var response1 = await http.post(
          URL_CREATEORGANIZATION,
          headers: {"Authorization": "$token"},
          body: json.encode(body),
        );

        var a=model.createOrg(name: orgName, location: orgLocation, description: orgDes, website: orgWeb, tag: "", token: token);
        
        var response;
        await a.then((res){
          response=res;
        });
        // print(response.statusCode);
        // print(a.statusCode)

        // if (response.statusCode == 200) {
        if (response["code"] == 200) {
          // final data = json.decode(response.body);
          // print(data);
          var data=response;
          // if (data["message"].compareTo("Created Organization") == 0) {
          // if (data["message"].compareTo("Successfully retrieved user organizations") == 0) {
          if (data["message"].compareTo("Organization created successfully") == 0) {
            Navigator.of(context).pop();
            Toast.show("Oragnization Created", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            setState(() {
              _load = false;
            });
          } else {
            Toast.show("Oragnization already exists", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            setState(() {
              _load = false;
            });
          }
        } else {
          setState(() {
            _load = false;
          });
          Toast.show("Try Again", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }

      return FutureBuilder(
          future: fetchPosts(http.Client(), model),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container();
            }
          });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
