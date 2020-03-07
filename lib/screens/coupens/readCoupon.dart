import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';
import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../models/global.dart';
import '../../models/read_attendee.dart';
import '../../cards/attendeeCard.dart';
import '../../models/read_coupon.dart';
import '../../cards/coupenCard.dart';
import '../../screens/coupens/qrScanner.dart';

// class ReadCouponPage extends StatefulWidget {
//   RS1 events;
//   int pos;
//   ReadCouponPage(this.events, this.pos);
//   @override
//   @override
//   State<StatefulWidget> createState() {
//     return _ReadCouponPage(events, pos);
//   }
// }

// class _ReadCouponPage extends State<ReadCouponPage> {
//   RS1 events;
//   int pos;

//   _ReadCouponPage(this.events, this.pos);
//   String selectedgender;
//   String orgToken;

//   String newValue;
//   String day;

//   int noOfDays;

//   List<String> noOfDaysList = ["Choose"];

//   @override
//   void initState() {
//     super.initState();
//      MainModel model = ScopedModel.of(context);
//     _initializePage(model);
//   }

//   void _initializePage(MainModel model) async {
//     await _getOrgToken(model);
//     await _getNoOfDays(model);
//     return;
//   }

//   void _getOrgToken(MainModel model) async {
//     String _orgToken = await model.getOrgToken();
//     setState(() {
//       orgToken = _orgToken;
//     });
//   }

//   void _getNoOfDays(MainModel model) async {
//     var a=await model.getNoOfDaysInEvent(events.eventId ,orgToken);
//     noOfDays=a["segments"].length;
//     for(int i=0;i<a["segments"].length; i++){
//       noOfDaysList.add(a["segments"][i]["day"].toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
// //      var details = {
// //     '"event"': "WomenTechies"
// // };
//     Map<String, dynamic> body = {"event": "WomenTechies"};

//     String eve = events.name.toString();
//     body["event"] = '$eve';
//     // print(body);

//     Future fetchPosts(http.Client client) async {
//       // print("orgToken: $orgToken");
//       if(day=='Choose')
//        {
//          day='1';
//        }
//       if (orgToken != '') {
//         MainModel model = ScopedModel.of(context);
//         var a = model.getAllCoupons(events.eventId, day, orgToken);
//         print(a);
//         var response;
//         await a.then((resp) {
//           response = resp;
//         });
//         if (response['code'] == 200) {
//           var data = response["coupons"];
//           List<ReadCoupon> coupons = new List<ReadCoupon>();
//           for (int i = 0; i < data.length; i++) {
//             coupons.add(new ReadCoupon.fromJson(data[i]));
//           }
//           return coupons;
//         } else {
//           return "No Data to be Fetched";
//         }
//       }
//       // var response = await http.post(URL_VIEWCOUPON, body: json.encode(body));

//       // final data = json.decode(response.body);
//       // print(data);
//       // if (data["error"] == null && data["rs"] != null) {
//       //   print(data['rs'][0]);
//       //   List<ReadCoupon> products = new List<ReadCoupon>();
//       //   for (int i = 0; i < data['rs'].length; i++) {
//       //     products.add(new ReadCoupon.fromJson(data['rs'][i]));
//       //     print(data['rs'][i]);
//       //   }
//       //   print(products[0].name);
//       //   return products;
//       // } else {
//       //   return "No Data to be Fetched";
//       // }
//     }

//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Redeem',
//             textAlign: TextAlign.center,
//           ),
//           centerTitle: true,
//           elevation: 0.0,
//         ),
//         body: Container(
//           child: FutureBuilder(
//             future: fetchPosts(http.Client()),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               } else {
//                 if (snapshot.data != "No Data to be Fetched") {
//                   return Container(
//                       child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Flexible(
//                           child: Container(
//                               padding: EdgeInsets.only(top: 16, left: 20),
//                               child: Row(
//                                 children: <Widget>[
//                                   Flexible(
//                                     child: Text(
//                                       "View",
//                                       style: TextStyle(
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.grey),
//                                     ),
//                                     flex: 15,
//                                   ),
//                                   Flexible(
//                                       child: IconButton(
//                                           icon: Icon(
//                                         Icons.arrow_drop_down,
//                                         color: Colors.grey,
//                                       )),
//                                       flex: 1),
//                                 ],
//                               )),
//                           flex: 1),
//                       Flexible(
//                           child: Column(
//                             children: <Widget>[
//                               ListTile(
//                                 title: const Text('Day'),
//                                 trailing: new DropdownButton<String>(
//                                     hint: Text('Choose'),
//                                     onChanged: (String changedValue) {
//                                       newValue = changedValue;
//                                       setState(() {
//                                         // newValue;
//                                         day = newValue;
//                                       });
//                                     },
//                                     value: day,
//                                     items: noOfDaysList.map((String value) {
//                                       return new DropdownMenuItem<String>(
//                                         value: value,
//                                         child: new Text(value),
//                                       );
//                                     }).toList()),
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemCount: snapshot.data.length,
//                                   padding: const EdgeInsets.only(
//                                       bottom: 16, left: 16, right: 16),
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return CouponCard(
//                                         snapshot.data[index], index, events);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           flex: 8)
//                     ],
//                   ));
//                 } else {
//                   return Center(
//                     child: Container(
//                       child: Text(snapshot.data),
//                     ),
//                   );
//                 }
//               }
//             },
//           ),
//         ));
//     //);
//   }
// }

class ReadCouponPage extends StatefulWidget {
  RS1 events;
  int pos;
  ReadCouponPage(this.events, this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ReadCouponPage(events, pos);
  }
}

class _ReadCouponPage extends State<ReadCouponPage> {
  RS1 events;
  int pos;

  _ReadCouponPage(this.events, this.pos);
  String selectedgender;
  String orgToken;

  String newValue;
  String day;

  int noOfDays;

  List<String> noOfDaysList = ["Choose"];
  List<dynamic> _coupons=[];

  bool loading=true;

  @override
  void initState() {
    super.initState();     
     MainModel model = ScopedModel.of(context);
    _initializePage(model);
  }


  getAllCoupons() async {
      if(day=='Choose')
       {
         day='1';
       }
      if (orgToken != '') {
        MainModel model = ScopedModel.of(context);
        var a = model.getAllCoupons(events.eventId, day, orgToken);
        // print(a);
        var response;
        await a.then((resp) {
          response = resp;
        });
        loading=false;
        if(this.mounted)
         {
           setState((){});
         }        
        if (response['code'] == 200) {
          var data = response["coupons"];
          List<ReadCoupon> coupons = new List<ReadCoupon>();
          for (int i = 0; i < data.length; i++) {
            coupons.add(new ReadCoupon.fromJson(data[i]));
          }
          _coupons=coupons;
          return coupons;
        } else {
          return "No Data to be Fetched";
        }
      }
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken(model);
    await _getNoOfDays(model);
    await getAllCoupons();
    return;
  }

  void _getOrgToken(MainModel model) async {
    String _orgToken = await model.getOrgToken();
    setState(() {
      orgToken = _orgToken;
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

    // Map<String, dynamic> body = {"event": "WomenTechies"};

    // String eve = events.name.toString();
    // body["event"] = '$eve';

    // Future fetchPosts(http.Client client) async {
    //   if(day=='Choose')
    //    {
    //      day='1';
    //    }
    //   if (orgToken != '') {
    //     MainModel model = ScopedModel.of(context);
    //     var a = model.getAllCoupons(events.eventId, day, orgToken);
    //     print(a);
    //     var response;
    //     await a.then((resp) {
    //       response = resp;
    //     });
    //     if (response['code'] == 200) {
    //       var data = response["coupons"];
    //       List<ReadCoupon> coupons = new List<ReadCoupon>();
    //       for (int i = 0; i < data.length; i++) {
    //         coupons.add(new ReadCoupon.fromJson(data[i]));
    //       }
    //       return coupons;
    //     } else {
    //       return "No Data to be Fetched";
    //     }
    //   }
    // }
    getAllCoupons();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Redeem',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: loading?Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  child: Container(
                      padding: EdgeInsets.only(top: 16, left: 20),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "View",
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
                  child: Column(
                    children: <Widget>[
                      // ListTile(
                      //   title: const Text('Day'),
                      //   trailing: new DropdownButton<String>(
                      //       hint: Text('Choose'),
                      //       onChanged: (String changedValue) {
                      //         newValue = changedValue;
                      //         setState(() {
                      //           // newValue;
                      //           day = newValue;
                      //         });
                      //       },
                      //       value: day,
                      //       items: noOfDaysList.map((String value) {
                      //         return new DropdownMenuItem<String>(
                      //           value: value,
                      //           child: new Text(value),
                      //         );
                      //       }).toList()),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _coupons.length,
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
                          itemBuilder:
                              (BuildContext context, int index) {
                            return CouponCard(
                                _coupons[index], index, events);
                          },
                        ),
                      ),
                    ],
                  ),
                  flex: 8)
            ],
          ))
        );
    //);
  }
}
