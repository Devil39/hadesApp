//Remove token receive for getOrgList

import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:hades_app/models/urls.dart';
import 'package:hades_app/models/get_Organization.dart';
// import 'package:hades_app/models/get_Organization.dart';

mixin OrgModel on Model {
  void setOrgList(Data data) async {
    try {
      // final orgDataBox= await Hive.openBox('orgzData');
      final orgDataBox = await Hive.openBox('orgzData');
      // print(data.runtimeType);
      // print(data.organization[0].name);
      await orgDataBox.put('orgList', data.organization);
      // print("Organizations Saved!");
      // print(a);
      // print(data);
      print("Organizations Saved!");
      // Hive.close();
      // print(data.organization);
      // print(data.organization[0]);
      // print(data.organization[0].orgId);
      orgDataBox.put('currentOrgId', data.organization[0].orgId);
    } catch (err) {
      print(err);
    }
  }

  Future<dynamic> getStoredOrgList() async {
    final orgDataBox = await Hive.openBox('orgzData');
    var a = orgDataBox.get('orgList');
    // Hive.close();
    // print(a);
    return a;
  }

  Future<int> setCurrentOrgId(int orgId) async {
    print("Changing current Org ID: $orgId");
    final orgDataBox = await Hive.openBox('orgzData');
    orgDataBox.put('currentOrgId', orgId);
    return orgId;
  }

  Future<int> getCurrentOrgId() async {
    final orgDataBox = await Hive.openBox('orgzData');
    var orgId = orgDataBox.get('currentOrgId');
    return orgId;
  }

  Future<String> getOrgToken() async {
    final orgDataBox = await Hive.openBox('orgzData');
    print(orgDataBox.get('token'));
    var token = orgDataBox.get('token');
    return token;
  }

  Future<dynamic> getOrgDataById(int orgId) async {
    final orgDataBox = await Hive.openBox('orgzData');
    var orgs = orgDataBox.get('orgList');
    for (int i = 0; i < orgs.length; i++) {
      // print("Here!");
      if (orgs[i].orgId == orgId) {
        return orgs[i];
      }
    }
  }

  Future<dynamic> orgLogIn(String token, int orgId) async {
    var statuscode;
    var message;
    try {
      print("Sending organization Log In Request!");
      final orgDataBox = await Hive.openBox('orgzData');
      var email = orgDataBox.get('email');
      // print(email);
      // print(token);
      // print(orgId);
      var body = jsonEncode({"org_id": orgId, "email": "$email"});
      print(body);
      http.Response response = await http.post(url_orgLogIn,
          headers: {"Authorization": "$token"}, body: body);
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        //  print(response.body);
        final orgDataBox = await Hive.openBox('orgzData');
        orgDataBox.put('token', jsonDecode(response.body)["token"]);
        print("Token saved!");
        // print(orgDataBox.get('token'));
        // Hive.close();
        return jsonDecode(response.body);
        // return response;
      } else {
        // print(response.statusCode.runtimeType);
        // print(response.statusCode==400);
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          // print("This wala error!");
          message = jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error in signing up!....$err");
      return {"code": statuscode, "message": err};
    }
  }

  Future<dynamic> getOrgList(String token) async {
    var message, statuscode;
    print("Getting Organization List!");
    if (token != '') {
      try {
        var response = await http
            .get(url_getOrgList, headers: {"Authorization": "$token"});
        // print(response.body.toString());
        print(response.statusCode);
        print(response.body);
        statuscode = response.statusCode;
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          if (response.statusCode == 400 ||
              response.statusCode == 400 ||
              response.statusCode == 404) {
            throw "Server Error!";
          } else {
            message = jsonDecode(response.body)["message"];
            // throw jsonDecode(response.body)["message"];
            throw message;
          }
        }
      } catch (err) {
        print("Error...$err");
        return {"code": statuscode, "message": err};
      }
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   //  if(data["message"].compareTo("Successful")==0) {//
      //   // print(data["message"]);
      //   if (data["message"]
      //           .compareTo("Successfully retrieved user organizations") ==
      //       0) {
      //     //  if (data["data"]["organizations"] == null) {
      //     // print(data);
      //     print(data["organizations"]==[]);
      //     if (data["organizations"] == null || data["organizations"].length==0) {
      //       print("Returning yo!");
      //       return "yo";
      //     } else {
      //       print(data["organizations"]);
      //       //  _data = Data.fromJson(data["data"]);
      //       _data = Data.fromJson(data["organizations"]);
      //       print(data["organizations"]);
      //       s.setOrgList(_data.organization);
      //       // model.setOrgList();
      //       toHomePage();
      //       return _data;
      //     }
      //   }
      // } else {
      //   return "Server Error";
      // }
    }
  }

  Future<dynamic> createOrg(
      {String name,
      String location,
      String description,
      String tag = "",
      String website,
      String token}) async {
    var statuscode, message;
    // print("Here!");
    // return;
    try {
      print("Sending create organization request!");
      var response = await http.post(
        url_createOrg,
        headers: {"Authorization": "$token"},
        body: json.encode({
          "name": "$name",
          "location": "$location",
          "description": "$description",
          "website": "$website"
        }),
      );
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // return response;
      } else {
        // print(response.statusCode.runtimeType);
        // print(response.statusCode==400);
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          // print("This wala error!");
          message = jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error creating organization!....$err");
      return {"code": statuscode, "message": err};
    }
    // return;
  }

  Future<dynamic> getAllOrg(String token) async {
    final orgDataBox = await Hive.openBox('orgzData');
    // print(orgDataBox.get("allOrgsList"));
    // if (orgDataBox.get("allOrgsList") != null &&
    //     orgDataBox.get("allOrgsList").length > 0) {
    //   return orgDataBox.get("allOrgsList");
    // } else {
    //   // Hive.close();
    // }
    var statuscode, message;
    try {
      var response =
          await http.get(url_getAllOrg, headers: {"Authorization": "$token"});
      // var response = await http.get(url_getOrgList, headers: {"Authorization": "$token"});
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        //  print(response.body);
        final orgDataBox = await Hive.openBox('orgzData');
        orgDataBox.put('allOrgsList', jsonDecode(response.body));
        print("All Orgs. saved!");
        print(orgDataBox.get('token'));
        // Hive.close();
        return jsonDecode(response.body);
        // return response;
      } else {
        // print(response.statusCode.runtimeType);
        // print(response.statusCode==400);
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          // print("This wala error!");
          message = jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error getting all organizations!....$err");
      return {"code": statuscode, "message": err};
    }
    // return;
  }

  Future<dynamic> searchOrg(String searchString, String token) async {
    List<dynamic> orgs;
    List<dynamic> foundOrgs = [];
    var resp;
    var a = getAllOrg(token);
    print("Searching organizations!");
    // print(a);
    await a.then((res) {
      // print(res);
      // print(res["organizations"]);
      resp = res;
      // orgs=res["organizations"];
      orgs = res["orgs"];
    });
    searchString = searchString.toLowerCase();
    for (var i = 0; i < orgs.length; i++) {
      if ((orgs[i]["name"].toLowerCase()).contains(searchString)) {
        // print("Organization found!");
        // print(orgs[i]["name"]);
        foundOrgs.add(orgs[i]);
      }
    }
    // print(foundOrgs);
    // print("<--Reponse-->");
    // print(resp);
    resp["organizations"] = foundOrgs;
    // print(resp);
    return resp;
    // return;
  }

  Future<dynamic> sendReqToOrg(String token, int orgId, String website) async {
    //{"code":200,"message":"Join request created successfully"}
    var statuscode, message;
    try {
      var response = await http.post(url_reqToOrg,
          headers: {"Authorization": "$token"},
          body: jsonEncode({"org_id": orgId, "email": website}));
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          message = jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error sending request to given organization!....$err");
      return {"code": statuscode, "message": err};
    }
  }

  Future<dynamic> getAllReqOfOrg(
      String token, int orgId, String website) async {
    //{"code":200,"message":"Join request created successfully"}
    var body = jsonEncode({"org_id": orgId, "email": website});
    // print(token);
    // print(body);
    var statuscode, message;
    try {
      print("Sending request for getting all requests of an organization!");
      var response = await http.get(
        url_getAllJoinReq,
        headers: {"Authorization": token},
        // body: body
      );
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          message = jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error getting all requests of organization!....$err");
      return {"code": statuscode, "message": err};
    }
  }

  Future<dynamic> declineJoinReq(
      int orgId, String email, String orgToken) async {
    var statuscode, message;
    var body = json.encode({
      "org_id": orgId, 
      "email": email
    });
    print(body);
    print(orgToken);
    try {
      print("Sending decline join request!");
      var request = http.Request('DELETE', Uri.parse(url_declineJoinReq));
      request.headers.addAll({"Authorization": "$orgToken"});
      request.body = jsonEncode({
        // "org_id": eventId, "email": couponId
        "org_id": orgId,
        "email": email
      });
      var response = await request.send();
      print("Response:");
      print(response.statusCode);
      // print(response);
      // print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        //  print("Done!");
        // return jsonDecode(response.body);
        return {"code": 200, "message": "Request declined!"};
      } else {
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          // message=jsonDecode(response.body)["message"];
          // var response=await response1.stream.bytesToString();
          message = "Error decling request";
          throw message;
        }
      }
    } catch (err) {
      print("Error deleting coupon!....$err");
      return {"code": statuscode, "message": err};
    }
  }

  Future<dynamic> acceptJoinReq(int orgId, String email, String orgToken) async {
    var statuscode, message;
    var body=json.encode({
        "org_id": orgId,
        "email": email
      });
      print(body);
      print(orgToken);
    try{
      print("Sending accept join request!");
      var response = await http.post(
        url_acceptJoinReq,
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
      print("Error accepting join request!....$err");
      return {
        "code": statuscode,
        "message": err
      };
    }
  }
}
/*To get all requests to join an organization I called on this route, '/org/requests' but it is giving me "Method not allowed" as response, if this is a get request then please update it properly in the documentation, with all the details on how to send the request with org_id, email and token.*/
/*POST request on /org/requests gives "Method Not Allowed" as response.*/
