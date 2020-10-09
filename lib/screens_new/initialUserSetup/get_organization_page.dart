import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/get_Organization.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../utils/router.gr.dart';

class GetOrganizationPage extends StatefulWidget {
  @override
  _GetOrganizationPageState createState() => _GetOrganizationPageState();
}

class _GetOrganizationPageState extends State<GetOrganizationPage> {
  String token = '';
  bool loading = true;

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
    super.initState();
  }

  void _initializePage(MainModel model) async {
    await _getToken(model);
    final result = await fetchPosts(model);
    if (result == "") {
      ExtendedNavigator.rootNavigator
          .pushReplacementNamed(Routes.joinOrgListPage);
    } else {
      ExtendedNavigator.rootNavigator
          .pushReplacementNamed(Routes.homePage);
    }
  }

  Data _data;
  Future fetchPosts(MainModel model) async {
    if (token != '') {
      var a = model.getOrgList(token);
      var response;
      await a.then((res) {
        response = res;
      });
      print(response);
      if (response["code"] == 200) {
        var data = response;
        if (data["message"]
                .compareTo("Successfully retrieved user organizations") ==
            0) {
          if (data["organizations"] == null ||
              data["organizations"].length == 0) {
            return "";
          } else {
            _data = Data.fromJson(data);
            await model.setOrgList(_data);
            return _data.toString();
          }
        }
      } else {
        return "Server Error";
      }
    }
  }

  Future<String> _getToken(MainModel model) async {
    String _token = await model.getToken();
    setState(() {
      token = _token;
    });
    return token;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            child: Text("S"),
          ),
        ),
      );
    }
  }
}
