import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import '../models/global.dart';
import 'package:flutter/services.dart';

class Event{
  String clubName;
  String name;
  String toDate;
  String fromDate;
  String toTime;
  String fromTime;
  String budget;
  String description;
  String category;
  String venue;
  String attendance;
  String expectedParticipants;
  facultyCoordinator facultycoordinator;
  studentCoordinator studentcoordinator;
  guest guestt;
  String PROrequest;
  String campusEngineerRequest;
  String duration;
  mainSponsor mainsponsor;
  String status;

  Event({
    this.clubName,
    this.name,
    this.toDate,
    this.fromDate,
    this.toTime,
    this.fromTime,
    this.budget,
    this.description,
    this.category,
    this.venue,
    this.attendance,
    this.expectedParticipants,
    this.facultycoordinator,
    this.studentcoordinator,
    this.guestt,
    this.PROrequest,
    this.campusEngineerRequest,
    this.duration,
    this.mainsponsor,
    this.status

  });
  factory Event.fromJson(Map<String,dynamic> json){
    return Event(
      clubName: json['clubName'],
      name: json['name'],
      toDate: json['toDate'],
      fromDate: json['fromDate'],
      toTime: json['toTime'],
      fromTime: json['fromTime'],
      budget: json['budget'],
      description: json['description'],
      category: json['category'],
      venue: json['venue'],
      attendance: json['attendance'],
      expectedParticipants: json['expectedParticipants'],
      facultycoordinator: json['facultyCoordinator'],
      studentcoordinator: json['studentCoordinator'],
      guestt: json['guest'],
      PROrequest: json['PROrequest'],
      campusEngineerRequest: json['campusEngineerRequest'],
      duration: json['duration'],
      mainsponsor: json['mainSponsor'],
      status: json['status']
    );
  }

}
class facultyCoordinator{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;

  facultyCoordinator({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender
  });
  factory facultyCoordinator.fromJson(Map<String,dynamic> json){
    return facultyCoordinator(
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender']
    );
  }
}

class studentCoordinator{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;

  studentCoordinator({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender
  });
  factory studentCoordinator.fromJson(Map<String,dynamic> json){
    return studentCoordinator(
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender']
    );
  }
}
class guest{
  String name;
  String email;
  String phoneNumber;
  String gender;
  String stake;
  String locationOfStay;

  guest({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.stake,
    this.locationOfStay
  });
  factory guest.fromJson(Map<String,dynamic> json){
    return guest(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      stake: json['stake'],
      locationOfStay: json['locationOfStay']
      );
  }

}
class mainSponsor{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;

  mainSponsor({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender
  });
  factory mainSponsor.fromJson(Map<String ,dynamic> json){
    return mainSponsor(
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender']
    );
  }
}
//  Map<String, dynamic> body = { "query":{
// 		"key":"clubName",
// 		"value":"GDG"
// 	}
//  };

Map map={'query':{'key':'clubname',
'value':'GDG'}};



Future<Event> fetchevent() async{
  final response=await http.post(URL_READEVENT,body:map);
  print("booo");
  print(response.body);
  if(response.statusCode==200){
    print('yooooo');
    return Event.fromJson(json.decode(response.body));
  }
  else{
    throw Exception('Failed to load post');
  }
}

// Future<Event> post(URL_READEVENT,
//         {Map<String, String> headers, body, Encoding encoding}) =>
//     _withClient((client) =>
//         client.post(url, headers: headers, body: body, encoding: encoding));
//  Future<Event> foo() async {
//     Map<String, dynamic> jsonMap = {
//       "query":{
// 		"key":"clubName",
// 		"value":"GDG"
// 	}
//     };
//     String jsonString = json.encode(jsonMap); // encode map to json
//     String paramName = 'param'; // give the post param a name
//     String formBody = paramName + '=' + Uri.encodeQueryComponent(jsonString);
//     List<int> bodyBytes = utf8.encode(formBody); // utf8 encode
//     Event request =
//         await http.post(_host, _port, '/a/b/c');
//     // it's polite to send the body length to the server
//     request.headers.set('Content-Length', bodyBytes.length.toString());
//     // todo add other headers here
//     request.add(bodyBytes);
//     return await request.close();
//   }
