import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../screens/attendeScreens/createAttendeePage.dart';
import '../../screens/attendeScreens/readAttendeePage.dart';
import '../../screens/export/jsonParticipantsList.dart';
import '../../screens/export/excelParticipantList.dart';

class ExportScreen extends StatefulWidget {
   RS1 events;
  int pos;

  ExportScreen(this.events,this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ExportScreen(events,pos);
  }
}

class _ExportScreen extends State<ExportScreen> {
  RS1 events;
  int pos;

  _ExportScreen(this.events,this.pos);
  
  void _json() {
     Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => JsonParticipantsList(events,pos)),
 );
}

void _excel() {
  Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => ExcelParticipantsList(events,pos)),
 );
            
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar:AppBar(
              title: Text("Export"),
              centerTitle: true,
              elevation:0.0,
            ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
              
          Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Functions",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )),
                ],
              )),
              GestureDetector(
          child:Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

            child: Center(
                child: Card(
                  elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new Container(
                              
                                padding: EdgeInsets.all(40.0),
                                decoration: new BoxDecoration(
                                     color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0)))),
                            flex: 18,
                          ),
                          new Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 15.0),
                                  child: Text(
                                    "Participants List",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 3.0),
                                  child: Text("JSON",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.grey)),
                                )
                              ],
                            ),
                            flex: 30,
                          ),
                          Flexible(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 80.0, top: 10.0),
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                      Icons.chevron_right,
                                      
                                  
                                    )),
                                  )),
                              flex: 23),
                        ]))),
            // size: Size(300, 100),
          ),
          onTap: _json,
                    ),
                     GestureDetector(
          child:Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),

            child: Center(
                child: Card(
                  elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new Container(
                                padding: EdgeInsets.all(40.0),
                                decoration: new BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0)))),
                            flex: 18,
                          ),
                          new Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 15.0),
                                  child: Text(
                                    "Participants List",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 3.0),
                                  child: Text("Excel Sheet",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.grey)),
                                )
                              ],
                            ),
                            flex: 30,
                          ),
                          Flexible(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 78.0, top: 10.0),
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                      Icons.chevron_right,
                                     
                                    )),
                                  )),
                              flex: 23),
                        ]))),
            // size: Size(300, 100),
          ),
          onTap: _excel,
                    ),
                  ],
                )),
              );
            }
          }
          
          
