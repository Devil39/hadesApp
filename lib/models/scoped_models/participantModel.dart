import 'dart:async';
import 'dart:convert';

import 'package:hades_app/models/read_attendee.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/urls.dart';

mixin ParticipantModel on Model{
  Future<dynamic> createParticipant(String name, String regNo, String email, String gender, String mobNo, int eventId, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "name": name,
        "reg_no": regNo,
        "email": email,
        "gender": gender,
        "event_id": eventId,
        "phone_number": mobNo
      });
      // print(body);
      // print(orgToken);
    try{
      print("Sending create participant request!");
      var response = await http.post(
        url_createParticipant,
        headers: {"Authorization": "$orgToken"},
        body: body,
      );
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
       }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
         {
           throw "Server Error!";
         }
        else{
          message=jsonDecode(response.body)["message"];
          throw message;
        }
      }
    }
    catch(err){
      print("Error creating participant!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> getAllParticipants(String day, int eventId, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "day": int.parse(day)
      });
      // print(body);
      // print(orgToken);
    try{
      print("Sending read participants request!");
      var response = await http.post(
        url_getAllParticipants,
        headers: {"Authorization": "$orgToken"},
        body: body,
      );
      // print("Response:");
      // print(response.statusCode);
      // print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
       }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
         {
           throw "Server Error!";
         }
        else{
          message=jsonDecode(response.body)["message"];
          throw message;
        }
      }
    }
    catch(err){
      print("Error getting all participants!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> deleteParticipant(String regNo, int eventId, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "reg_no": regNo
      });
      // print(body);
      // print(orgToken);
    try{
      print("Sending delete participant request!");
      // var response = await http.delete(
      //   url_deleteParticipant,
      //   headers: {"Authorization": "$orgToken"},
      //   // body: body,
      // );
      // HttpClient client = new HttpClient();
      var request = http.Request('DELETE', Uri.parse(url_deleteParticipant));
      request.headers.addAll({
        "Authorization": "$orgToken"
      });
      request.body = jsonEncode({
        "event_id": eventId,
        "reg_no": regNo
      });
      var response = await request.send();
      print("Response:");
      print(response.statusCode);
      // print(response);
      // print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
         print("Done!");
        // return jsonDecode(response.body);
        return {
          "code": 200,
          "message": "Participant successfully deleted!"
        };
       }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
         {
           throw "Server Error!";
         }
        else{
          // message=jsonDecode(response.body)["message"];
          // var response=await response1.stream.bytesToString();
          message="Error deleting a participant";
          throw message;
        }
      }
    }
    catch(err){
      print("Error deleting attendee!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> markPresent(String regNo, String day, int eventId, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "reg_no": regNo,
        "day": int.parse(day)
      });
      print(body);
      print(orgToken);
    try{
      print("Sending mark participant present request!");
      var response = await http.post(
        url_markPresent,
        headers: {"Authorization": "$orgToken"},
        body: body,
      );
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
       }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
         {
           throw "Server Error!";
         }
        else{
          message=jsonDecode(response.body)["message"];
          throw message;
        }
      }
    }
    catch(err){
      print("Error marking participant present!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  List<ReadAttendee> searchParticipant(String value, List<dynamic> participants){
    List<ReadAttendee> searchList=[];
    value=value.toLowerCase();
    // print("Participant List:");
    // print(participants);
    for(int i=0; i<participants.length; i++)
     {
      // print(participants[i].registrationNumber);
      // print(participants[i].name.toLowerCase());
      // print(value);
      // print((participants[i].name.toLowerCase()).contains(value));
      // print(participants[i].registrationNumber.toLowerCase().contains(value));
      if((participants[i].name.toLowerCase()).contains(value))
       {
         searchList.add(participants[i]);
        //  continue;
       }
      else if(participants[i].phoneNumber.toLowerCase().contains(value))
       {
         print(participants[i].phoneNumber);
         searchList.add(participants[i]);
        //  continue;
       }
      else if(participants[i].registrationNumber.toLowerCase().contains(value))
       {
         print(participants[i].registrationNumber);
         searchList.add(participants[i]);
        //  continue;
       }
      else if(participants[i].email.toLowerCase().contains(value))
       {
         print(participants[i].email);
         searchList.add(participants[i]);
        //  continue;
       }
     }
    // searchList.map((data){
    //   print(data.name);
    //   print(data.registrationNumber);
    //   print(data.email);
    // });
    return searchList;
  }
}

/*{
	"event_id": 2,
	"reg_no": "18BCE0001",
	"day": 1
}*/