import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../models/readApi.dart';
import '../screens/participantMangement.dart';
import '../screens/mailingServices/mailingServicesScreen.dart';
import '../screens/export/exportScreen.dart';
import '../screens/coupens/coupensScreen.dart';
import '../screens/addExtras.dart';

class EventPage extends StatefulWidget {
   RS1 events;
  int pos;
   String name;
   String clubname;

  EventPage(this.events,this.pos,this.name,this.clubname);
  @override
  @override
  State<StatefulWidget> createState() {
    return _EventPage(events,pos,clubname,name);
  }
}

class _EventPage extends State<EventPage> {
  RS1 events;
  int pos;
  String name;
  String clubname;

  _EventPage(this.events,this.pos,this.clubname,this.name);

  @override
  Widget build(BuildContext context) {
    void _nav(){
      Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => ParticipantMangement(events,pos)),
 );
    };

 void _export(){
      Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => ExportScreen(events,pos)),
 );
    };

    void _coupen(){
      Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => CoupenServicesScreen(events,pos)),
 );
    };

     void _mail(){
      Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => MailingServicesScreen(events,pos)),
 );
    };
        return Scaffold(
            appBar: AppBar(
              title: Text(events.name),
              centerTitle: true,
              elevation:0.0,
             // backgroundColor: Colors.grey[50],
              actions: <Widget>[
  //               IconButton(
  //                      icon: Icon(
  //                    Icons.person_add,
  //                  ),
  //                  onPressed: (){
  //                     Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => AddExtras(events,pos)),
  // );
  //                  },
  //                  )
               
              ],
              
             
            ),
            body: Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
              //   Container(
              // padding: EdgeInsets.only(left:20),
              // child: Row(
              //   children: <Widget>[
              //     // Flexible(child:Text(
              //     //   "Services",
              //     //   style: TextStyle(
              //     //       fontSize: 15.0,
              //     //       fontWeight: FontWeight.w400,
              //     //       color: Colors.grey),
              //     // ),flex: 15,),
              //     // Flexible(child:IconButton(
              //     //     icon: Icon(
              //     //   Icons.arrow_drop_down,
              //     //   color: Colors.grey,
              //     // )),flex:1),
              //   ],
              // )),
                 GestureDetector(child: Container(
                    padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                    child: Center(
                        child: Card(
                          elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child:Container(
                               width: MediaQuery.of(context).size.width-60,
                               height: 200,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                 Flexible(child:Container(
                                   padding: EdgeInsets.all(5),
                                   child:Center(child: ClipRRect(
              borderRadius: new BorderRadius.only(topLeft:Radius.circular(8.0),topRight:Radius.circular(8.0)),
                                 // child:Image.network("https://i.postimg.cc/XrdJKJ8w/Event-Management.png"),
                                 child: Image.asset("images/eventManagement.webp"),
                                  ),)),flex: 7,),
                                   Flexible(child:Row(children: <Widget>[
                                                      Flexible(child:  Container(
                                                        padding: EdgeInsets.all(3),
                                    alignment: Alignment(-0.9, 0),
                                                        child:Text(
                                                             "Participants Managment",
                                                            style: TextStyle(fontWeight: FontWeight.w500),
                                                            textAlign:TextAlign.left,
                                                          )),flex: 2,),
                                                         Flexible(child: Container(
                                                             alignment: Alignment(0.9, 0),
                                                            padding: EdgeInsets.all(3),
                                                            child:Icon(Icons.chevron_right),
                                                           
                                                          ),flex:1 ,)
                                                     ],) ,flex: 2,)
                               
                               
                                ]))))),onTap: _nav,
                                                        ),
             
    
                 GestureDetector(child: Container(
                     padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                     child: Center(
                    
                         child: Card(
                            elevation: 2.0,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8.0),
                             ),
                             child:Container(

                                width: MediaQuery.of(context).size.width-60,
                                height: 200,
                             child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: <Widget>[
                                 Flexible(child:Container(
                                   padding: EdgeInsets.all(5),
                                   child:Center(child: ClipRRect(
               borderRadius: new BorderRadius.only(topLeft:Radius.circular(8.0),topRight:Radius.circular(8.0)),
                                  // child:Image.network("https://i.postimg.cc/6TP5DRbr/Mailing.png"),
                                  child: Image.asset("images/mail.webp"),
                                   ))),flex: 7,),
                                    Flexible(child:Row(children: <Widget>[
                                                       Flexible(child:  Container(
                                                         padding: EdgeInsets.all(3),
                                     alignment: Alignment(-0.9, 0),
                                                         child:Text(
                                                              "Mailing Services",
                                                             style: TextStyle(fontWeight: FontWeight.w500),
                                                             textAlign:TextAlign.left,
                                                           )),flex: 2,),
                                                          Flexible(child: Container(
                                                              alignment: Alignment(0.9, 0),
                                                             padding: EdgeInsets.all(3),
                                                             child:Icon(Icons.chevron_right),
                                                           
                                                           ),flex:1 ,)
                                                      ],) ,flex: 2,)
                               

                                 ])
                                
                                 )))),onTap: _mail,
                                                         ),
                                
                                         GestureDetector(child: Container(
                                            padding:EdgeInsets.only(left: 16,right:16,bottom: 16),
                                            child: Center(
                                                child: Card(
                                                   elevation: 2.0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child:Container(
                               width: MediaQuery.of(context).size.width-60,
                               height: 200,
                                                    child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                         Flexible(child:Container(
                                                            padding: EdgeInsets.all(5),
                                                           child:Center(child: ClipRRect(
                                      borderRadius: new BorderRadius.only(topLeft:Radius.circular(8.0),topRight:Radius.circular(8.0)),
                                                        // child:Image.network("https://i.postimg.cc/N2KGKfF2/Shared-Doc-Index.png"),
                                                        child: Image.asset("images/sharedDocIndex.webp"),
                                                          ))),flex: 7,),

                                                     Flexible(child:Row(children: <Widget>[
                                                      Flexible(child:  Container(
                                                        padding: EdgeInsets.all(3),
                                    alignment: Alignment(-0.9, 0),
                                                        child:Text(
                                                            "Export Details",
                                                            style: TextStyle(fontWeight: FontWeight.w500),
                                                            textAlign:TextAlign.left,
                                                          )),flex: 2,),
                                                         Flexible(child: Container(
                                                             alignment: Alignment(0.9, 0),
                                                            padding: EdgeInsets.all(3),
                                                            child:Icon(Icons.chevron_right),
                                                           
                                                          ),flex:1 ,)
                                                     ],) ,flex: 2,)
                                                        ]))))),onTap: _export,
                                                        ),

                                                         GestureDetector(child: Container(
                    padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                    
                    child: Center(
                    
                        child: Card(
                           elevation: 2.0,
                           
                            shape: RoundedRectangleBorder(
                              
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child:Container(
                               width: MediaQuery.of(context).size.width-60,
                               height: 200,
                          
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(child:Container
                                  
                                  (padding: EdgeInsets.only(top: 6),
                                    child:Center
                                (child: ClipRRect(
              borderRadius: new BorderRadius.only(topLeft:Radius.circular(8.0),topRight:Radius.circular(8.0)),
                                  //child:Image.network("https://i.postimg.cc/Th137Q02/Attendance.png"),
                                  child: Image.asset("images/attend.webp"),
                                  ))),flex: 7,),
                                   Flexible(child:Row(children: <Widget>[
                                                      Flexible(child:  Container(
                                                        padding: EdgeInsets.all(3),
                                    alignment: Alignment(-0.9, 0),
                                                        child:Text(
                                                              "Coupons",
                                                            style: TextStyle(fontWeight: FontWeight.w500),
                                                            textAlign:TextAlign.left,
                                                          )),flex: 2,),
                                                         Flexible(child: Container(
                                                             alignment: Alignment(0.9, 0),
                                                            padding: EdgeInsets.all(3),
                                                            child:Icon(Icons.chevron_right),
                                                           
                                                          ),flex:1 ,)
                                                     ],) ,flex: 2,)
                               
                                 
                                ])
                                
                                )))),onTap: _coupen,
                                                        ),
                                
                                      ]),
                                    ));
                              }
                            }
                            
                           