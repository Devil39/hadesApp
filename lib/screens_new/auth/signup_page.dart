import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/scoped_models/mainModel.dart';
import '../../ui_utils/colors.dart';
import '../../ui_utils/dimens.dart';
import '../../ui_utils/widgets/app_bar.dart';
import '../../ui_utils/widgets/failure_card.dart';
import '../../ui_utils/widgets/loading_card.dart';
import '../../ui_utils/widgets/message_card.dart';
import '../../ui_utils/widgets/submit_button.dart';
import '../../ui_utils/widgets/success_card.dart';
import '../../ui_utils/widgets/text_area.dart';
import '../../utils/router.gr.dart';
import '../../utils/validators.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();

  bool _autoValidate = false,
      showPassword = false,
      showCPassword = false,
      _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'SIGN UP',
        leading: Container(),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return _buildBody(model);
      }),
    );
  }

  Widget _buildBody(MainModel model) {
    return IgnorePointer(
      ignoring: _loading,
      child: SingleChildScrollView(
        child: Form(
          //autovalidate: _autoValidate,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          //autovalidateMode: AutovalidateMode.always,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextArea(
                    title: 'First Name',
                    hint: 'Someone',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _firstNameController,
                  ),
                  TextArea(
                    title: 'Last Name',
                    hint: 'Doe',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _lastNameController,
                  ),
                  TextArea(
                    title: 'Phone Number',
                    hint: '9998887776',
                    label: null,
                    obscureText: false,
                    validator: Validators.validatePhoneNumber,
                    controller: _phoneNumberController,
                    inputType: TextInputType.phone,
                  ),
                  TextArea(
                    title: 'Email',
                    hint: 'someone@email.com',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateEmail,
                    controller: _emailController,
                  ),
                  TextArea(
                    title: 'Password',
                    hint: '*****',
                    label: null,
                    obscureText: !showPassword,
                    validator: Validators.validatePassword,
                    controller: _passwordController,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !showPassword ? Icons.visibility_off : Icons.visibility,
                        color: BColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  TextArea(
                    title: 'Confirm Password',
                    hint: '*****',
                    label: null,
                    obscureText: !showCPassword,
                    validator: (value) => Validators.validateCPassword(
                      _passwordController.text,
                      value,
                    ),
                    controller: _passwordCController,
                    suffixIcon: IconButton(
                      icon: Icon(
                        !showCPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: BColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          showCPassword = !showCPassword;
                        });
                      },
                    ),
                  ),
                  TextArea(
                    title: 'Organization',
                    hint: 'Developer Students Club',
                    label: null,
                    obscureText: false,
                    validator: Validators.validateText,
                    controller: _clubController,
                  ),
                  SubmitButton(
                    buttonText: 'Sign Up',
                    onPressed: () => signIn(model),
                  ),
                  GestureDetector(
                    onTap: () {
                      ExtendedNavigator.rootNavigator
                          .pushReplacementNamed(Routes.loginPage);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 27.0),
                      child: InkWell(
                        onTap: () {
                          ExtendedNavigator.rootNavigator
                              .pushReplacementNamed(Routes.loginPage);
                        },
                        child: Column(
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: Dimens.smallHeadingTextSize,
                                color: BColors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'LogIn',
                              style: TextStyle(
                                fontSize: Dimens.smallHeadingTextSize,
                                color: BColors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _loading
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: LoadingCard(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(MainModel model) async {
    setState(() {
      _autoValidate = true;
    });
    if (_validateAllFields()) {
      setState(() {
        _loading = true;
      });
      var response = await model.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        first_name: _firstNameController.text.trim(),
        last_name: _lastNameController.text.trim(),
        phone_number: _phoneNumberController.text.trim(),
      );
      if (response['code'] == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessCard(
            onPressed: () {
              ExtendedNavigator.rootNavigator.pop();
              ExtendedNavigator.rootNavigator
                  .pushReplacementNamed(Routes.joinOrgListPage);
            },
          ),
        );
      } else if (response['code'] == 409 || response['code'] == 404) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MessageCard(
            message: 'Already exists!',
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
    return Validators.validateText(_firstNameController.text.trim()) == null &&
        Validators.validateText(_lastNameController.text.trim()) == null &&
        Validators.validatePhoneNumber(_phoneNumberController.text.trim()) ==
            null &&
        Validators.validateEmail(_emailController.text.trim()) == null &&
        Validators.validatePassword(_passwordController.text.trim()) == null &&
        Validators.validateCPassword(_passwordController.text.trim(),
                _passwordCController.text.trim()) ==
            null &&
        Validators.validateText(_clubController.text.trim()) == null;
  }
}
