/*
{
  Someone
  18BCE0001
  someone@gmail.com
  9632587410
  Male
}
*/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import 'package:hades_app/models/readApi1.dart';
import 'package:hades_app/models/scoped_models/mainModel.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';
import '../../models/read_attendee.dart';
import '../../cards/attendeeCard.dart';
import '../../userDataMangment.dart';

class ReadAttendeePage extends StatefulWidget {
  RS1 events;
  int pos;

  ReadAttendeePage(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ReadAttendeePage(events, pos);
  }
}

class _ReadAttendeePage extends State<ReadAttendeePage> {
  RS1 events;
  int pos;

  _ReadAttendeePage(this.events, this.pos);
  String selectedgender;
  SharedPreferencesTest s = new SharedPreferencesTest();

  String newValue;
  String day;

  String token = '';
  String orgToken='';

  int noOfDays;

  List<String> noOfDaysList=["Choose"];

  bool hide = false;
  bool searching=false;
  String search;
  TextEditingController editingController;

  List<ReadAttendee> allParticipants;
  List<ReadAttendee> filteredParticipants;
  
  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    // Future<String> tok = s.getToken();
    // tok.then((res) {
    //   print(res);
    //   setState(() {
    //     token = res;
    //   });
    // });
    _initializePage(model);
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
    return;
  }

  void _getOrgToken(MainModel model) async {
    String _orgToken=await model.getOrgToken();
    setState(() {
      orgToken=_orgToken;
    });
  }

  void _getNoOfDays(MainModel model) async {
    var a=await model.getNoOfDaysInEvent(events.eventId ,orgToken);
    noOfDays=a["segments"].length;
    for(int i=0;i<a["segments"].length; i++){
      noOfDaysList.add(a["segments"][i]["day"].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> body = {
    //   "event": "Developer 1O1",
    //   "day": 0,
    //   "query": {"key": "", "value": "", "specific": "DSCVIT"}
    // };

    dynamic searchParticipant(String value, MainModel model, var participants) async {
      filteredParticipants=[];
      if(value!="")
       {
         searching=true;
         var a=await model.searchParticipant(value, allParticipants);
         if(a.length>0)
          {
            print("Filtered Candidates!");
            for(int i=0; i<a.length; i++)
             {
               print(a[i].name);
             }
            // a.map((data){
            //   print(data.name);
            // });
            filteredParticipants=a;
            setState(){}
          }
       }
      else{
        searching=false;
      }
     return filteredParticipants;
    }

    Future fetchPosts(http.Client client, MainModel model) async {
      // String eve = events.name.toString();
      // body["event"] = '$eve';
      // print(body);
      if(day=='Choose')
       {
        //  Toast.show("Please Choose a day!", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //   return "No Data to be Fetched";
        day='1';
       }
      if (orgToken != '') {
        // var response = await http.post(URL_ALLPARTICIPANTS,
        //     headers: {"Authorization": "$token"}, body: json.encode(body));
        // final data = json.decode(response.body);
        var a=model.getAllParticipants(day, events.eventId, orgToken);
        var response;
        await a.then((res){
          response=res;
        });
        if (response["code"] == 200) {
          // print(response['rs'][0]);
          // List<ReadAttendee> products = new List<ReadAttendee>();
          // for (int i = 0; i < response['rs'].length; i++) {
          //   products.add(new ReadAttendee.fromJson(response['rs'][i]));
          //   print(response['rs'][i]);
          // }
          // print(products[0].name);
          // return products;
          if(response['participants'].length==0)
           {
             return "No Data to be Fetched";
           }
          List<ReadAttendee> participants = new List<ReadAttendee>();
          for (int i = 0; i < response['participants'].length; i++) {
            participants.add(new ReadAttendee.fromJson(response['participants'][i]));
            // print(response['rs'][i]);
          }
          // print(participants[0].name);
          allParticipants=participants;
          if(searching)
           {    
            //  filteredParticipants=searchParticipant(search, model, allParticipants);
            //  print("Filtered Candidates1!");
            //  print(filteredParticipants);
             return filteredParticipants;
           }
          return participants;
        } else {
          return "No Data to be Fetched";
        }


        // if (data["error"] == null) {
        //   print(data['rs'][0]);
        //   List<ReadAttendee> products = new List<ReadAttendee>();
        //   for (int i = 0; i < data['rs'].length; i++) {
        //     products.add(new ReadAttendee.fromJson(data['rs'][i]));
        //     print(data['rs'][i]);
        //   }
        //   print(products[0].name);
        //   return products;
        // } else {
        //   return "No Data to be Fetched";
        // }
      }
    }

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Read',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
              child: FutureBuilder(
                future: fetchPosts(http.Client(), model),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print("Snapshot Data");
                  // print(snapshot.data);
                  if(snapshot.data!=null)
                   {
                     for(int i=0; i<snapshot.data.length; i++)
                      {
                        print(snapshot.data[i].name);
                      }
                   }
                  if (snapshot.data == null) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Day'),
                            trailing: new DropdownButton<String>(
                                hint: Text('Choose'),
                                onChanged: (String changedValue) {
                                  newValue = changedValue;
                                  setState(() {
                                    // newValue;
                                    day = newValue;
                                  });
                                },
                                value: day,
                                items: noOfDaysList
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList()),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {
                    if (snapshot.data != "No Data to be Fetched") {
                      return Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: const Text('Day'),
                            trailing: new DropdownButton<String>(
                                hint: Text('Choose'),
                                onChanged: (String changedValue) {
                                  newValue = changedValue;
                                  setState(() {
                                    // newValue;
                                    day = newValue;
                                  });
                                },
                                value: day,
                                items: noOfDaysList
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList()),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, right: 16, left: 16, bottom: 8),
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: TextField(
                              cursorColor: Colors.blue,
                              controller: editingController,
                              decoration: InputDecoration(
                                hintText: "Search participant",
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hide = true;

                                        editingController.clear();
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                      ),
                                    )),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  hide = false;
                                  search = value;
                                  searchParticipant(value, model, snapshot.data);
                                });
                              },
                            ),
                          ),
                          Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(top: 16, left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          "Participants",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        flex: 15,
                                      ),
                                      Flexible(
                                          child: IconButton(
                                              icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.grey,
                                          )),
                                          flex: 1),
                                    ],
                                  )),
                              flex: 1),
                          Flexible(
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                padding: const EdgeInsets.only(
                                    bottom: 16, left: 16, right: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  return AttendeeCard(
                                      snapshot.data[index], index, events);
                                },
                              ),
                              flex: 8)
                        ],
                      ));
                    } else {
                      return Center(
                        child: Container(//Text(snapshot.data)
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: const Text('Day'),
                                trailing: new DropdownButton<String>(
                                hint: Text('Choose'),
                                onChanged: (String changedValue) {
                                  newValue = changedValue;
                                  setState(() {
                                    // newValue;
                                    day = newValue;
                                  });
                                },
                                value: day,
                                items: noOfDaysList
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList()),
                              ),
                              Text(snapshot.data),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ));
      },
          // child: ,
    );
  }
}
// import 'package:flutter/material.dart';
// import '../../models/readApi.dart';
// import 'package:http/http.dart' as http;
// import '../../models/global.dart';
// import '../../models/read_attendee.dart';
// import '../../cards/attendeeCard.dart';
// import 'dart:async';
// import 'dart:convert';

// class ReadAttendeePage extends StatefulWidget{

//    RS events;
//   int pos;

//    ReadAttendeePage(this.events,this.pos);
//   @override
//   @override
//   State<StatefulWidget> createState() {
//     return _ReadAttendeePage(events,pos);
//   }
// }

//   class _ReadAttendeePage extends State<ReadAttendeePage>{

//     RS events;
//     int pos;

//     _ReadAttendeePage(this.events,this.pos);
//     String selectedgender;

//     // var items = List<ReadAttendee>();

//     List<ReadAttendee> products = new List<ReadAttendee>();

// // void filterSearchResults(String query) {
// //     List<ReadAttendee> dummySearchList = List<ReadAttendee>();
// //     dummySearchList.addAll(products);
// //     if(query.isNotEmpty) {
// //       List<ReadAttendee> dummyListData = List<ReadAttendee>();
// //       dummySearchList.forEach((item) {
// //         if(item.name.contains(query)) {
// //           dummyListData.add(item);
// //         }
// //       });
// //       setState(() {
// //         items.clear();
// //         items.addAll(dummyListData);
// //       });
// //       return;
// //     } else {
// //       setState(() {
// //         items.clear();
// //         items.addAll(products);
// //       });
// //     }

// //   }

//   @override
//   Widget build(BuildContext context) {
// //      var details = {
// //     '"event"': "WomenTechies"
// // };
// Map<String, dynamic> body = {
//     "event": "WomenTechies"
// };
// TextEditingController editingController = TextEditingController();

//      String eve=events.name.toString();
//    body["event"] = '$eve';
//    print(body);

//     Future fetchPosts(http.Client client) async {
//  var response=await http.post(URL_ALLPARTICIPANTS, body: json.encode(body));

//  final data = json.decode(response.body);
//  if(data["error"]==null)
//  {
//       print(data['rs'][0]);

//     for (int i = 0; i < data['rs'].length; i++) {
//       products.add(new ReadAttendee.fromJson(data['rs'][i]));
//       print(data['rs'][i]);
//     }
//     print(products[0].name);

//     return products;
//   }
//   else{
//     return "No Data to be Fetched";
//   }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Read',
//          textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         elevation: 0.0,

//       ),
//       body:Container(
//       child: FutureBuilder(
//         future: fetchPosts(http.Client()),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.data==null){
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );

//           }
//           else{

//             if(snapshot.data!="No Data to be Fetched")
//             {

//             return Container(
//               child:Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[

//     //          Flexible(child:Padding(
//     //           padding: const EdgeInsets.all(16.0),
//     //           child: TextField(
//     //             onChanged: (value) {
//     //                setState(() {
//     //   if(items.length!=snapshot.data.length){
//     //   items=products;
//     //   filterSearchResults(value);
//     //   }
//     // });
//     //             },
//     //             controller: editingController,
//     //             decoration: InputDecoration(
//     //                 labelText: "Search",
//     //                 hintText: "Search",
//     //                 prefixIcon: Icon(Icons.search),
//     //                 border: OutlineInputBorder(
//     //                     borderRadius: BorderRadius.all(Radius.circular(16.0)))),
//     //           ),
//     //         ),flex: 3,),
//              Flexible(child: Container(
//               padding: EdgeInsets.only(top: 16,left:20),
//               child: Row(
//                 children: <Widget>[
//                   Flexible(child:Text(
//                     "Participants",
//                     style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey),
//                   ),flex: 15,),

//                 ],
//               )),flex: 1),
//                 Flexible(child:
//                 Container(
//                   padding: EdgeInsets.only(top: 8),
//                   child:
//                 ListView.builder(
//               itemCount: snapshot.data.length,
//                padding: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
//               itemBuilder: (BuildContext context,int index){
//                 return  AttendeeCard(snapshot.data[index],index,events);

//               },
//             )),flex: 8)

//               ],));
//             }
//             else{
//               return Center(child:Container(
//                 child: Text(snapshot.data),
//               ),);
//             }

//           }
//         },
//       ),
//     )

//     );
//   }
//   }
