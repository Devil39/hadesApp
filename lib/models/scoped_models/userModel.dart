import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:hades_app/models/urls.dart';

import '../get_Organization.dart';

mixin UserModel on Model {
  String email, password, first_name, last_name, phone_number, description;
//  bool isLoggedIn;
  Future<dynamic> signUp(
      {String email,
      String password,
      String first_name,
      String last_name,
      String phone_number,
      String description}) async {
    var statuscode;
    var message;
    try {
      print("Sending Sign Up Request!");
      http.Response response = await http.post(url_signup,
          body: json.encode({
            'email': "$email",
            'password': "$password",
            'first_name': "$first_name",
            'last_name': "$last_name",
            'phone_number': "$phone_number",
          }));
      print("Response SignUp:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        //  print(response.body);
        final userDataBox = await Hive.openBox('userData');
        // userDataBox.put('token', "Something");
        userDataBox.put('token', jsonDecode(response.body)["token"]);
        userDataBox.put('email', email);
        print("Token saved!");
        print(userDataBox.get('token'));
        // Hive.close();
        return jsonDecode(response.body);
        // return response;Future<List<Organization>> org=s.getOrgList();
      } else {
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          throw "Server Error!";
        } else {
          print("This wala error!");
          message = jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
    } catch (err) {
      print("Error in signing up!....$err");
      return {"code": statuscode, "message": err};
    }
    //  Future signUpFuture() async {

    //  }
    //  return true;
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNvbWVvbmVAZ21haWwuY29tIiwib3JnX2lkIjowfQ.h9MhBU8OALtPuD3eo41jbE2Xdot_dTVLmuNEyWm-9lg"
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNvbWVvbmUxQGdtYWlsLmNvbSIsIm9yZ19pZCI6MH0.a84eb1jFdpwPwJOjOGDU2tUWJxxTp4p5Rnn_7nf1niw"
  }

  Future<dynamic> logIn({String email, String password}) async {
    var statuscode;
    var message;
    try {
      print("Sending Log In Request!");
      http.Response response = await http.post(url_login,
          body: json.encode({
            'email': "$email",
            'password': "$password",
          }));
      print("Response:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200) {
        //  print(response.body);
        final userDataBox = await Hive.openBox('userData');
        userDataBox.put('token', jsonDecode(response.body)["token"]);
        userDataBox.put('email', email);
        print("Token saved!");
        print(userDataBox.get('token'));
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
    //  Future signUpFuture() async {

    //  }
    //  return true;
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNvbWVvbmVAZ21haWwuY29tIiwib3JnX2lkIjowfQ.h9MhBU8OALtPuD3eo41jbE2Xdot_dTVLmuNEyWm-9lg"
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNvbWVvbmUxQGdtYWlsLmNvbSIsIm9yZ19pZCI6MH0.a84eb1jFdpwPwJOjOGDU2tUWJxxTp4p5Rnn_7nf1niw"
  }

  Future<String> getUserEmail() async {
    final userDataBox = await Hive.openBox('userData');
    return await userDataBox.get('email');
  }

  void testHive() async {
    final userDataBox = await Hive.openBox('userData');
    userDataBox.put('token',
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNvbWVvbmVAZ21haWwuY29tIiwib3JnX2lkIjowfQ.h9MhBU8OALtPuD3eo41jbE2Xdot_dTVLmuNEyWm-9lg");
    print("Token saved!");
    print(userDataBox.get('token'));
    Hive.close();
  }

  Future<bool> isLoggedIn() async {
    //  testHive();
    final userDataBox = await Hive.openBox('userData');
    var token = userDataBox.get('token');
    print(token);
    if (token != "" && token != null) {
      print("Logging In!");
      return true;
      // return false;
    } else {
      return false;
    }
  }

  Future<bool> showIntro() async {
    final userDataBox = await Hive.openBox('userData');
    bool sI = userDataBox.get('showIntro');
    if (sI == null) {
      userDataBox.put('showIntro', true);
      return true;
    }
    return false;
  }

  Future<bool> showJoinCreateOrgTutorial() async {
    final userDataBox = await Hive.openBox('userData');
    bool sI = userDataBox.get('showJoinCreateOrgTutorial');
    if (sI == null) {
      userDataBox.put('showJoinCreateOrgTutorial', true);
      return true;
    }
    return false;
  }

  void resetUserInfo() async {
    final userDataBox = await Hive.openBox('userData');
    final orgDataBox = await Hive.openBox('orgzData');
    await orgDataBox.put('orgList', Data(organization: []));
    userDataBox.put('token', '');
    print("Token Deleted!");
    return;
  }

  Future<String> getToken() async {
    final userDataBox = await Hive.openBox('userData');
    var token = await userDataBox.get('token');
    if (token != "") {
      return token;
    } else {
      return "";
    }
  }
}
