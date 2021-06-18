import 'package:flutter/material.dart';
import 'package:flutter_plate/constants/assets.dart';
import 'package:flutter_plate/util/validation.dart';
import 'package:flutter_plate/widgets/colored_button.dart';
import 'package:flutter_plate/widgets/input_form_field.dart';

class RegisterPage2 extends StatefulWidget {
  static String tag = 'register-page-2';

  Function _navCallback;

  RegisterPage2(this._navCallback);

  @override
  _RegisterPage2State createState() => new _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  Validation _validation = Validation();
  final GlobalKey<FormState> _regFormKey = GlobalKey<FormState>();
  String _emailText;
  String _passText;
  String _phoneText;
  String _nameText;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 24.0,
      child: Image.asset(Assets.appLogo),
    );

    final nameField = InputFormField(
        hintText: "Enter your name",
        labelText: "Name",
        obscureText: false,
        textInputType: TextInputType.text,
        textStyle: Theme.of(context).textTheme.title,
        verticalMargin: 4.0,
        horizontalMargin: 32.0,
        validateFunction: _validation.isFilled,
        autoFocus: true,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        onSaved: (String text) {
          _nameText = text;
        });

    final emailField = InputFormField(
        hintText: "abc@gmail.com",
        labelText: "Email",
        obscureText: false,
        textInputType: TextInputType.emailAddress,
        textStyle: Theme.of(context).textTheme.title,
        verticalMargin: 4.0,
        horizontalMargin: 32.0,
        validateFunction: _validation.isValidEmail,
        autoFocus: false,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        onSaved: (String text) {
          _emailText = text;
        });

    final passwordField = InputFormField(
        hintText: "********",
        labelText: "Password",
        obscureText: true,
        textInputType: TextInputType.text,
        textStyle: Theme.of(context).textTheme.title,
        verticalMargin: 4.0,
        horizontalMargin: 32.0,
        validateFunction: _validation.isFilled,
        autoFocus: false,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        onSaved: (String text) {
          _passText = text;
        });

    final confirmPasswordField = InputFormField(
        hintText: "********",
        labelText: "Confirm Password",
        obscureText: true,
        textInputType: TextInputType.text,
        textStyle: Theme.of(context).textTheme.title,
        verticalMargin: 4.0,
        horizontalMargin: 32.0,
        validateFunction: _validation.isFilled,
        autoFocus: false,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        onSaved: (String text) {
          _passText = text;
        });

//    final phoneField = InputFormField(
//        hintText: "Enter mobile number",
//        labelText: "Mobile",
//        obscureText: false,
//        textInputType: TextInputType.phone,
//        textStyle: Theme.of(context).textTheme.title,
//        verticalMargin: 4.0,
//        horizontalMargin: 32.0,
//        validateFunction: _validation.isValidPhone,
//        autoFocus: false,
//        labelStyle: TextStyle(
//          fontWeight: FontWeight.bold,
//          color: Theme.of(context).accentColor,
//        ),
//        onSaved: (String text) {
//          _phoneText = text;
//        });

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter:
                  new ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
              image: AssetImage(Assets.bgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _regFormKey,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 120.0, left: 120.0, right: 120.0, bottom: 40.0),
                  child: logo,
                ),
                _buildProgressBar(),
                nameField,
                Divider(
                  height: 24.0,
                ),
                emailField,
                Divider(
                  height: 24.0,
                ),
                passwordField,
                Divider(
                  height: 24.0,
                ),
                confirmPasswordField,
                Divider(
                  height: 24.0,
                ),
//                phoneField,
//                Divider(
//                  height: 24.0,
//                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: new FlatButton(
                        child: new Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: widget._navCallback,
                      ),
                    ),
                  ],
                ),
                ColoredButton(
                  "SIGN UP",
                  callBack: _onClickedRegistration,
                ),
              ]),
            ),
          )),
    );
  }

  Widget _buildProgressBar() {
    if (_isLoading)
      return Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator());
    return Container();
  }

  void _onClickedRegistration() {
    final FormState form = _regFormKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      // _tryRegistration();
    }
  }

  // void _tryRegistration() async {
  //   RegistrationResponse response = await ApiClient().register(
  //       RegistrationRequest(_nameText, _emailText, _phoneText, _passText));

  //   if (response.isSuccessful()) {
  //     Worker().tryLogin(context, _emailText, _passText).then((val) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       if (val.isSuccessful())
  //         Navigator.of(context).pushReplacementNamed(SetupPage.tag);
  //       else
  //         DialogUtils.toast(val.message);
  //     });
  //   } else
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   DialogUtils.toast(response.message);
  // }
}
