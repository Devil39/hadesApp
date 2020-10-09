import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/organization.dart';
import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/loading_card.dart';
import '../../ui_utils/widgets/message_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../ui_utils/widgets/success_card.dart';
import '../../ui_utils/widgets/text_area.dart';
import '../../utils/router.gr.dart';
import '../../utils/validators.dart';

class CreateEventPage extends StatefulWidget {
  CreateEventPage({
    @required this.org,
  });

  final Organization org;

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    _initializePage(model);
  }

  void _initializePage(MainModel model) async {
    await _getOrgToken();
  }

  Future<void> _getOrgToken() async {
    MainModel model = ScopedModel.of(context);
    String orgToken = await model.getOrgToken();
    setState(() {
      _orgToken = orgToken;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  bool _autoValidate = false, _loading = false, showPassword = false;

  String _orgToken = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.homePage);
        return false;
      },
      child: Scaffold(
        appBar: Header(
          title: 'Create Event',
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: BColors.blue,
            ),
            onPressed: () {
              ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.homePage);
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
    return
        //_loading
        //? Container(
        //    child: Center(
        //      child: CircularProgressIndicator(),
        //    ),
        //  )
        //:
        IgnorePointer(
      ignoring: _loading,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Form(
                //autovalidate: _autoValidate,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextArea(
                          title: 'Event Name',
                          hint: 'DevStack',
                          label: null,
                          obscureText: false,
                          validator: Validators.validateText,
                          controller: _nameController,
                        ),
                        TextArea(
                          title: 'Description',
                          hint: 'Description',
                          label: null,
                          obscureText: false,
                          validator: Validators.validateText,
                          controller: _descriptionController,
                        ),
                        TextArea(
                          title: 'Category',
                          hint: 'Hackathon',
                          label: null,
                          obscureText: false,
                          validator: Validators.validateText,
                          controller: _categoryController,
                        ),
                        TextArea(
                          title: 'Venue',
                          hint: 'Anna Auditorium, VIT Vellore',
                          label: null,
                          obscureText: false,
                          validator: Validators.validateText,
                          controller: _venueController,
                        ),
                        TextArea(
                          title: 'Duration',
                          hint: 'Days',
                          label: null,
                          obscureText: false,
                          validator: Validators.validateNumber,
                          controller: _durationController,
                        ),
                        //TextArea(
                        //  title: 'Budget',
                        //  hint: '10000',
                        //  label: '',
                        //  obscureText: false,
                        //  validator: Validators.validateNumber,
                        //  controller: _budgetController,
                        //),
                        SubmitButton(
                          buttonText: 'Create',
                          onPressed: () => createEvent(model),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _loading ? LoadingCard() : Container(),
        ],
      ),
    );
  }

  void createEvent(MainModel model) async {
    setState(() {
      _autoValidate = true;
    });
    if (_validateAll() && _orgToken != "") {
      setState(() {
        _loading = true;
      });
      var a = model.createEvent(
        _orgToken,
        _nameController.text.trim(),
        widget.org.org_id,
        _durationController.text.trim(),
        _budgetController.text.trim(),
        _descriptionController.text.trim(),
        _categoryController.text.trim(),
        _venueController.text.trim(),
      );
      var response;
      await a.then((res) {
        response = res;
      });
      if (response['code'] == 200) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => SuccessCard(
            onPressed: () {
              Navigator.pop(context);
              ExtendedNavigator.rootNavigator.popAndPushNamed(Routes.homePage);
            },
          ),
        );
      } else if (response['code'] == 403) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MessageCard(message: 'Unauthorized'),
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

  bool _validateAll() {
    return Validators.validateText(_nameController.text.trim()) == null &&
        Validators.validateText(_descriptionController.text.trim()) == null &&
        Validators.validateText(_categoryController.text.trim()) == null &&
        Validators.validateText(_venueController.text.trim()) == null &&
        //Validators.validateNumber(_budgetController.text.trim()) == null &&
        Validators.validateNumber(_durationController.text.trim()) == null;
  }
}
