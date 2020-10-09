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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _autoValidate = false, _loading = false, showPassword = false, _loadingCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'LOGIN',
        leading: Container(),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return _buildBody(model);
      }),
    );
  }

  Widget _buildBody(MainModel model) {
    return _loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : IgnorePointer(
            ignoring: _loadingCard,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    //autovalidate: _autoValidate,
                    // autovalidateMode: _autoValidate
                    //     ? AutovalidateMode.always
                    //     : AutovalidateMode.disabled,
                    //autovalidateMode: AutovalidateMode.always,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Image.asset('images/hades_logo.png'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
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
                            SubmitButton(
                              buttonText: 'Login',
                              onPressed: () => logIn(model),
                            ),
                            GestureDetector(
                              onTap: () {
                                ExtendedNavigator.rootNavigator
                                    .pushReplacementNamed(Routes.signUpPage);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    ExtendedNavigator.rootNavigator
                                        .pushReplacementNamed(Routes.signUpPage);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Don\'t have an account yet?',
                                        style: TextStyle(
                                          fontSize: Dimens.smallHeadingTextSize,
                                          color: BColors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Sign Up!',
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
                        _loadingCard
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
              ),
            ),
          );
  }

  void logIn(MainModel model) async {
    model.resetUserInfo();
    setState(() {
      _autoValidate = true;
    });
    if (_validateAll()) {
      setState(() {
        //_loading = true;
        _loadingCard = true;
      });
      var response = await model.logIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (response['code'] == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessCard(
            onPressed: () {
              Navigator.pop(context);
              ExtendedNavigator.rootNavigator.pushReplacementNamed(Routes.getOrganizationPage);
            },
          ),
        );
      } else if (response['code'] == 401 || response['code'] == 404) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MessageCard(
            message: 'Invalid credentials',
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
      //_loading = false;
      _loadingCard = false;
    });
  }

  bool _validateAll() {
    return Validators.validateEmail(_emailController.text.trim()) == null &&
        Validators.validatePassword(_passwordController.text.trim()) == null;
  }
}
