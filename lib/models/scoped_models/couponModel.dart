import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:hades_app/models/urls.dart';

mixin CouponModel on Model{
  Future<dynamic> createCoupon(int eventId, String name, String description, String day, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "name": name,
        "description": description,
        "day": int.parse(day)
      });
      print(body);
      print(orgToken);
    try{
      print("Sending create coupon request!");
      var response = await http.post(
        url_createCoupon,
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
      print("Error creating coupon!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> getAllCoupons(int eventId, String day, String orgToken) async {
    var statuscode, message;
    if(day==null)
     {
       day='1';
     }
    var body=json.encode({
        "event_id": eventId,
        "day": int.parse(day)
      });
    try{
      // print("Sending fetch all coupons request!");
      // print(body);
      // print(orgToken);
      var response = await http.post(
        url_getAllCoupons,
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
      print("Error fetching all coupons!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> redeemCoupon(int eventId, int couponId, String regNo, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "coupon_id": couponId,
        "reg_no": regNo
      });
      print(body);
      print(orgToken);
    try{
      print("Sending redeem coupon request!");
      var response = await http.post(
        url_redeemCoupon,
        headers: {
          "Content-type": "application/json",
          "Authorization": "$orgToken"
          },
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
      print("Error redeeming coupon!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }

  Future<dynamic> deleteCoupon(int eventId, int couponId, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "event_id": eventId,
        "coupon_id": couponId
      });
      print(body);
      print(orgToken);
    try{
      print("Sending delete coupon request!");
      var request = http.Request('DELETE', Uri.parse(url_deleteCoupon));
      request.headers.addAll({
        "Authorization": "$orgToken"
      });
      request.body = jsonEncode({
        "event_id": eventId,
        "coupon_id": couponId
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
      print("Error deleting coupon!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }
}