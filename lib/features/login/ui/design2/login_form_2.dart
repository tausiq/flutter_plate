import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/constants/assets.dart';
import 'package:flutter_plate/features/auth/bloc/bloc.dart';
import 'package:flutter_plate/features/login/bloc/bloc.dart';
import 'package:flutter_plate/util/validation.dart';
import 'package:flutter_plate/widgets/colored_button.dart';
import 'package:flutter_plate/widgets/input_form_field.dart';

class LoginForm2 extends StatefulWidget {
  final Function _navCallback;

  LoginForm2({
    Key key,
    Function navCallback,
  })  : _navCallback = navCallback,
        super(key: key);

  @override
  State<LoginForm2> createState() {
    return LoginForm2State();
  }
}

class LoginForm2State extends State<LoginForm2> {
  AuthBloc _authBloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Validation _validation = Validation();
  String _userNameText;
  String _passwordText;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  bool get isPopulated =>
      _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (
            BuildContext context,
            LoginState loginState,
          ) {
            return _form(loginState);
          },
        ));
  }

  Widget _form(LoginState loginState) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 24.0,
      child: Image.asset(Assets.appLogo),
    );

    final email = InputFormField(
        hintText: "abc@gmail.com",
        labelText: "Enter email address",
        text: _userNameText,
        obscureText: false,
        textInputType: TextInputType.emailAddress,
        textStyle: Theme.of(context).textTheme.title,
        verticalMargin: 4.0,
        horizontalMargin: 32.0,
        validateFunction: _validation.isValidEmail,
        autoFocus: true,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        onSaved: (String text) {
          _userNameText = text;
        });

    final password = InputFormField(
        hintText: "********",
        labelText: "Enter password",
        text: _passwordText,
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
          _passwordText = text;
        });

    final forgotLabel = FlatButton(
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
        textAlign: TextAlign.end,
      ),
      onPressed: () => {},
    );

    return Form(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 120.0, left: 120.0, right: 120.0, bottom: 40.0),
            child: logo,
          ),
          email,
          Divider(
            height: 24.0,
          ),
          password,
          Divider(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: forgotLabel,
              ),
            ],
          ),
          _loginButton(loginState),
          _textDivider("OR CONNECT WITH"),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0Xff3B5998),
                            onPressed: () => {},
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () => {},
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(
                                            const IconData(0xea90, fontFamily: 'icomoon'),
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            "FACEBOOK",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0Xffdb3236),
                            onPressed: () => {},
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () => {},
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(
                                            const IconData(0xea88, fontFamily: 'icomoon'),
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            "GOOGLE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _textDivider("OR"),
          ColoredButton("USE PHONE NUMBER", callBack: () => {}),
          _registrationButton(),
        ],
      ),
    );
  }

  Widget _loginButton(LoginState loginState) {
    if (loginState.isSubmitting)
      return Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator());

    return ColoredButton("LOGIN",
        callBack: isLoginButtonEnabled(loginState)
            ? _onLoginButtonPressed
            : _onLoginButtonPressed);
  }

  Widget _registrationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FlatButton(
            child: Text(
              "New here? Let\'s register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
            onPressed: widget._navCallback,
          ),
        ),
      ],
    );
  }

  Widget _textDivider(String txt) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(width: 0.25)),
            ),
          ),
          Text(
            txt,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(width: 0.25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(LoginState loginState) {
    if (loginState.isSubmitting)
      return Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator());
    return Container();
  }

//  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;
//  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.add(LoginWithCredentialsPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
