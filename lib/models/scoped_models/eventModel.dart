import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:hades_app/models/urls.dart';

mixin EventModel on Model{
  Future<dynamic> createEvent(String orgToken, String name, int orgId, String days, String budget, String description, String category, String venue) async {
    var statuscode, message;
    var body=json.encode({
        "days": int.parse(days),
        "org_id": orgId,
        "name": "$name",
        "budget": "$budget",
        "description": "$description",
        "category": "$category",
        "venue": "$venue",
      });
    // print(orgToken);
    // print(body);    
    try{
      print("Sending create event request!");
      var response = await http.post(
        url_createEvent,
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
      print("Error creating event!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> getEventList(String token) async {
    var statuscode, message;
    // print(token);
    try{
      print("Sending event list request!");
      var response = await http.get(
        "https://hades.dscvit.com/api/v2/org/events",
        headers: {"Authorization": "$token"},
        // body: body,
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
      print("Error getting event list!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> getNoOfDaysInEvent(int eventId, String orgToken) async {
    var statuscode, message;
    try{
      print("Sending no. of days get request!");
      var body=json.encode({
        "event_id": eventId
      });
      print(body);
      print(orgToken);
      var response = await http.post(
        url_getNoOfDaysInEvent,
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
      print("Error getting no. of days!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }
}