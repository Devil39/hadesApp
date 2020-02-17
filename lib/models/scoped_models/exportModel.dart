import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:hades_app/models/urls.dart';

mixin ExportModel on Model{
  
  List<dynamic> processJSONGender(String gender, List<dynamic> json){
    int i;
    List<dynamic> newJson=[];
    if(gender=='Both')
     {
       return json;
     }
    for(i=0;i<json.length; i++)
     {
       if(json[i]["gender"]==gender)
        {
          newJson.add(json[i]);
        }
     }
    return newJson;
  }

  dynamic processJSONType(String type, List<dynamic> json){
    int i;
    bool isPresent;
    List<dynamic> newJson=[];
    // print("Inside process JSON Type!");
    // print(type);
    if(type=='1')
     {
      //  searchType="";
      return json;
     }
    else if(type=='2')
     {
       isPresent=true;
     }
    else{
      isPresent=false;
    }
    for(i=0;i<json.length; i++)
     {
       if(json[i]["is_present"]==isPresent)
        {
          newJson.add(json[i]);
        }
     }
    // print(newJson);
    return newJson;
  }

  Future<dynamic> getAllInJson(String orgToken, int eventId, String day, String gender, String type) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "day": int.parse(day)
      });
    // print(orgToken);
    print(body);
    print(type);
    try{
      print("Sending request for getting all participants in json format!");
      var response = await http.post(
        url_getAllInJson,
        headers: {"Authorization": "$orgToken"},
        body: body,
      );
      // print("Response:");
      // print(response.statusCode);
      // print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        var a=await processJSONGender(gender, jsonDecode(response.body)["data"]);
        var b=await processJSONType(type, a);
        print(b);
          return {
            "code": 200,
            "data": b
          };
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
      print("Error getting participants in json format!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> getAllInCsv(String orgToken, int eventId, String day, String gender, String type) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "day": int.parse(day)
      });
    try{
      print("Sending request for getting all participants in csv format!");
      var response = await http.post(
        url_getAllInCsv,
        headers: {"Authorization": "$orgToken"},
        body: body,
      );
      print("Response:");
      print(response.statusCode);
      // print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
         print(response.body.runtimeType);
         print(response);
         print(response.body);
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
      print("Error getting participants in csv format!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }
}