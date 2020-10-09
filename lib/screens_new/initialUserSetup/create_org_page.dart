import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/loading_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../ui_utils/widgets/success_card.dart';
import '../../ui_utils/widgets/text_area.dart';
import '../../utils/router.gr.dart';
import '../../utils/validators.dart';

class CreateOrgPage extends StatefulWidget {
  const CreateOrgPage({this.from = 'login'});

  final String from;
  @override
  _CreateOrgPageState createState() => _CreateOrgPageState();
}

class _CreateOrgPageState extends State<CreateOrgPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  bool _autoValidate = false, _loading = false;

  String token;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _getToken(model);
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
    return WillPopScope(
      onWillPop: () async {
        ExtendedNavigator.rootNavigator.popAndPushNamed(
          Routes.joinOrgListPage,
          arguments: JoinOrgListPageArguments(
            from: 'home',
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: Header(
          title: 'Create Org',
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: BColors.blue,
            ),
            onPressed: () {
              ExtendedNavigator.rootNavigator.popAndPushNamed(
                Routes.joinOrgListPage,
                arguments: JoinOrgListPageArguments(
                  from: 'home',
                ),
              );
            },
          ),
        ),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return _buildBody(model);
        }),
      ),
    );
  }

  Widget _buildBody(MainModel model) {
    return IgnorePointer(
      ignoring: _loading,
      child: SingleChildScrollView(
        child: Form(
          //autovalidate: _autoValidate,
          //autovalidateMode: //_autoValidate
//              ? //AutovalidateMode.always
//              : //AutovalidateMode.disabled,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextArea(
                    title: 'Name of organization',
                    hint: 'DSC-VIT',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _nameController,
                  ),
                  TextArea(
                    title: 'Description',
                    hint: 'description',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _descriptionController,
                  ),
                  TextArea(
                    title: 'Location',
                    hint: 'VIT-Vellore',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _locationController,
                  ),
                  TextArea(
                    title: 'Website',
                    hint: 'dscvit.com',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateURL,
                    controller: _websiteController,
                  ),
                  SubmitButton(
                    buttonText: 'Create',
                    onPressed: () => createOrg(model),
                  ),
                ],
              ),
              _loading ? LoadingCard() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void createOrg(MainModel model) async {
    setState(() {
      _autoValidate = true;
    });
    if (_validateAllFields() && token != "") {
      setState(() {
        _loading = true;
      });
      var response = await model.createOrg(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        website: _websiteController.text.trim(),
        token: token,
      );
      print(response);
      if (response['code'] == 200) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => SuccessCard(
            onPressed: () {
              Navigator.pop(context);
              ExtendedNavigator.rootNavigator
                  .pushReplacementNamed(Routes.homePage);
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => FailureCard(),
        );
      }
    }
    setState(() {
      _loading = false;
    });
  }

  bool _validateAllFields() {
    return Validators.validateText(_nameController.text.trim()) == null &&
        Validators.validateText(_descriptionController.text.trim()) == null &&
        Validators.validateText(_locationController.text.trim()) == null &&
        Validators.validateURL(_websiteController.text.trim()) == null;
  }
}
