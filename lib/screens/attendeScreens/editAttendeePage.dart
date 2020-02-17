import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import '../../models/read_attendee.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';

class EditAttendeePage extends StatefulWidget {
  ReadAttendee attendee;
  int pos;
  RS1 events;

  EditAttendeePage(this.attendee,this.pos,this.events);
  @override
  @override
  State<StatefulWidget> createState() {
    return _EditAttendeePage(attendee,pos,events);
  }
}

class _EditAttendeePage extends State<EditAttendeePage> {
  ReadAttendee attendee;
  int pos;
  RS1 events;
  String orgToken;

  _EditAttendeePage(this.attendee,this.pos,this.events);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrgToken();
  }

  void _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    String _orgToken=await model.getOrgToken();
    setState(() {
      orgToken=_orgToken;
    });
  }

  Map<String, dynamic> body ={
    "query": {
        "key": "name",
        "Value": "dhruv sharma",
        "changeKey": "DSC",
        "changeValue": "DEVFEST 2019"
    }
};

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'View',
            textAlign: TextAlign.center,
            ),
            centerTitle: true,
            elevation: 0.0,  
          ),
          body:Container(child:Column(
            children: <Widget>[
            Container(
            padding: EdgeInsets.all(28.0),
            height: 400,
            width: 500,
            child: Card(
              
              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
              child:Column(
                
              children: <Widget>[
                Flexible(
                child:Container(
                  padding: EdgeInsets.all(16.0),
                  child:Center(child:Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          IconButton(
                  icon: Icon(
                    Icons.person,size: 80,
                  ),
                  padding: EdgeInsets.all(16.0),
                )])))),
                      
                    flex: 6,),
                    
                    
              Flexible(child: Container(
                  padding: EdgeInsets.all(16.0),
                  child:Row(

                  children: <Widget>[
                    Text("Name: ",style: TextStyle(fontWeight: FontWeight.w600),),
                    Text(attendee.name)
                  ],
                )),flex: 3,),
              Flexible(child:Container(
                  padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text("Email: ",style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(attendee.email)
                  ],
                )),flex:3),
              Flexible(child:Container(
                  padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text("Registration Number: ",style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(attendee.registrationNumber)
                  ],
                )),flex:3),
                Flexible(child:Container(
                  padding: EdgeInsets.all(16.0),
                  child:Row(
                  children: <Widget>[
                    Text("Mobile Number: ",style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(attendee.phoneNumber)
                  ],
                )),flex:3),
                Flexible(child:Container(
                  padding: EdgeInsets.all(16.0),
                  child:Row(
                  children: <Widget>[
                    Text("Gender: ",style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(attendee.gender)
                  ],
                )),flex: 3,),
              ],
            ),
            elevation: 5.0,
          ),
          ),
          Center(child:      Container(
            
            padding: EdgeInsets.all(16.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child:
              RaisedButton(
                
                    elevation: 5,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      color: Colors.red,
                        child: Text('Delete',style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    _sendToServer(model);
                  
                  },)),
                  // RaisedButton(
                  //   elevation: 5,
                  //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  //     color: Theme.of(context).accentColor,
                  //       child: Text('Edit',style: TextStyle(color: Colors.white),),
                  // onPressed: (){
                  //  // _sendToServer();
                  
                  // },)
            ],
          ))
          ) ] )));
      },
          // child: ,
    );
  }

  void _processData() {
    // Process your data and upload to server
    //_key.currentState?.reset();
    Navigator.of(context).pop();
    //widget.key?.currentState?.reset();
  }

  _sendToServer(MainModel model){
    // String eve=attendee.name.toString();
    // String evt=events.name.toString();
    // String nm=events.clubName.toString();
    // String nm="DSC";
    //  print(attendee.name);
    //  body["query"]["changeValue"] = '$evt';
    //  body["query"]["Value"] = '$eve';
    //   body["query"]["changeKey"] = '$nm';
  

     Future fetchPosts(http.Client client) async {
//  var response=await http.post(URL_DELETEATTENDEE, body: json.encode(body));
    var a=await model.deleteParticipant(attendee.registrationNumber, events.eventId, orgToken);
    var response=a;
    if(response["code"]==200)
     {
       Toast.show("Participant deleted successfully", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
     }
    else{
      Toast.show("Try Again", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  //  final data = json.decode(response.body);
      /*print(data['rs']);*/
      //  Fluttertoast.showToast(
      //   msg: data['rs'].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIos: 1,
      //   backgroundColor: Colors.grey[700],
      //   textColor: Colors.white);
        _processData();
  }
    
     
   print(body);
   
   return FutureBuilder(

        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          }
          else{
        //     Fluttertoast.showToast(
        // msg: "Check Your Connection",
        // toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 1,
        // backgroundColor: Colors.grey[700],
        // textColor: Colors.white);
          }
          });



   
     
    
   

  }
}
