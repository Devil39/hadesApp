import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../models/readApi.dart';
import '../screens/eventPage.dart';
import '../models/read_attendee.dart';
import '../screens/attendeScreens/editAttendeePage.dart';

class AttendeeCard extends StatefulWidget {
  String name;
  String clubname;
  ReadAttendee attendees;
  int pos;
  RS1 events;

  AttendeeCard(this.attendees,this.pos,this.events);

  @override
  State<StatefulWidget> createState() {
    return AttendeeCardState(attendees,pos,events);
  }
}

class AttendeeCardState extends State<AttendeeCard> {
  String name;
  String clubname;
  ReadAttendee attendees;
  int pos;
  RS1 events;

  AttendeeCardState(this.attendees,this.pos,this.events);

  Widget get babyCard {
    return
    GestureDetector( 
     
      child:new Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person,size:40,color: Colors.blue,),
              title: Text(attendees.name),
              subtitle: Text(attendees.registrationNumber),
              // subtitle: Text(attendees.regNo),
              onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>EditAttendeePage(attendees,pos,events),
          ),
        );
      },
              
            ),
            
          ]
        )
      ));
           
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
          child:  babyCard,
        );
  }
}