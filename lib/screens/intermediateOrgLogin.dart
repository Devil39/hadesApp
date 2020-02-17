import 'package:flutter/material.dart';
import 'package:hades_app/screens/homePage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import 'package:hades_app/screens/homePage.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';

class IntermediateOrgLogin extends StatefulWidget {

  int orgId;

  IntermediateOrgLogin({this.orgId});

  @override
  _IntermediateOrgLoginState createState() => _IntermediateOrgLoginState();
}

class _IntermediateOrgLoginState extends State<IntermediateOrgLogin> {

  String token;

  @override
  initState(){
    super.initState();
    MainModel model = ScopedModel.of(context);
    _getToken(model);
  }

  void _toHomePage(){
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  _getOrgDetails(MainModel model) async {

    Future fetchPosts() async {
      var a=model.orgLogIn(token, widget.orgId);
      var response;
      await a.then((res){
        response=res;
      });
      if(response["code"]==200){
        Toast.show("Successfully logged in!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
      else{
        Toast.show("Try Again!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
      _toHomePage();
    }

    return FutureBuilder(
      future: fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _getToken(MainModel model) async {
    String _token=await model.getToken();
    setState(() {
      token=_token;
    });
    _getOrgDetails(model);
  }

  Widget _buildBody(){
    return Scaffold(
      body: Container(
        child: Center(
          // child: Text("Please wait while you are logged in into organization!"),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}