import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/readApi1.dart';
import '../models/readApi.dart';
import '../screens/eventPage.dart';
import '../screens/participantMangement.dart';
import '../models/global.dart';

class EventCard extends StatefulWidget {
  String clubname;
  // RS events;
  RS1 events;
  int pos;

  EventCard(this.events, this.pos, this.clubname);

  @override
  State<StatefulWidget> createState() {
    return EventCardState(events, pos, clubname);
  }
}

class EventCardState extends State<EventCard> {
  String clubname;
  RS1 events;
  int pos;

  EventCardState(this.events, this.pos, this.clubname);
  Map<String, dynamic> body = {
    "query": {"key": "name", "value": "GDG"}
  };

  Future<bool> _onWillPop(String ename) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Delete ?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                  child: new Text('Yes'),
                  onPressed: () {
                    _deletefromserver(ename);

                    Navigator.of(context).pop(false);
                  }),
            ],
          ),
        ) ??
        false;
  }

  Widget get babyCard {
    print(events.name);
    return GestureDetector(
        child: new Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: Colors.grey,
                ),

                title: Text(events.name),
                subtitle: Text(clubname), //Text("DSC")
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) =>EventPage(events,pos,events.clubName,events.name),
                      builder: (context) =>
                          EventPage(events, pos, clubname, events.name),
                    ),
                  );
                },
                onLongPress: () {
                  //  _onWillPop(events.name);
                },
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: babyCard,
    );
  }

  _deletefromserver(String ename) {
    body["query"]["value"] = '$ename';

    Future fetchPosts(http.Client client) async {
      var response = await http.post(URL_DELETEEVENT, body: json.encode(body));

      final data = json.decode(response.body);
      print(data['rs']);
      //  Fluttertoast.showToast(
      //   msg: data['rs'].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIos: 1,
      //   backgroundColor: Colors.grey[700],
      //   textColor: Colors.white);
    }

    print(body);

    return FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
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
