import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import './models/get_Organization.dart';
class SharedPreferencesTest {

   Future<List<String>> getOrganization() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'org';
    List<String> value = prefs.getStringList(key);
    return value;
  }
  setOrganization(List<String> value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'org';

    prefs.setStringList(key, value);
  }

  Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'token';
    String value = prefs.getString(key);
    return value;
  }
  setToken(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'token';

    prefs.setString(key, value);
  }
  Future<List<Organization>> getOrgList() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final key = 'org';
    // var value = prefs.getOrgList(key);
    // return value;
  }

  setOrgList(List<Organization> value) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final key = 'org';

    // prefs.setOrgList(key, value);
  }
   Future<bool> getLoginCheck() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();

     final key = 'check';
     var value = prefs.getBool(key);
    //  return value;
    return false;
   }

   setLoginCheck(bool value) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();

     final key = 'check';

     prefs.setBool(key, value);
   }
}