import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/model/api.dart';
import 'package:student_app/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_app/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _emailValidate = false;
  bool _passwordValidate = false;

  String error = '';
  Map<String, String> loginMessage = {};

  @override
  Widget build(BuildContext context) {
    final emailField = displayEmailField();
    final passwordField = displayPasswordField();
    final loginButton = displayLoginButton();
    final registerButton = displayRegisterButton();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  emailField,
                  SizedBox(height: 20.0),
                  passwordField,
                  SizedBox(
                    height: 40.0,
                  ),
                  loginButton,
                  registerButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField displayEmailField() {
    final emailField = TextField(
      controller: _emailController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        labelText: "Email",
        errorText: _emailValidate ? error : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    return emailField;
  }

  TextField displayPasswordField() {
    final passwordField = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        labelText: 'Password',
        errorText: _passwordValidate ? error : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    return passwordField;
  }

  RaisedButton displayLoginButton() {
    final loginButton = RaisedButton(
      onPressed: () async {
        setState(() async {
          _emailController.text.isEmpty
              ? _emailValidate = true
              : _emailValidate = false;
          _passwordController.text.isEmpty
              ? _passwordValidate = true
              : _passwordValidate = false;

          loginMessage = await loginTeacher(_emailController.text, _passwordController.text);
          
          

          var _list = loginMessage.values.toList();
          String field = _list[0];
          error = _list[1];
          print(_list[1]);

          if(field == 'success'){
            print('success in login page');
            loginUser();
          }

          if (field == 'em') {
            print('this is an email error');
            print('testing github');
            displayEmailError(error);
          }
          if (field == 'pa') {
            print('this is a password error');
            displayPasswordError(error);
          }
          if (field == 'ma'){
            displayLoginError(error);
          }
          
        });
      },
      child: Text('Login'),
      color: Colors.green[600],
      textColor: Colors.white,
    );
    return loginButton;
  }

  RaisedButton displayRegisterButton() {
    final registerButton = RaisedButton(
      onPressed: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Register()));
      },
      child: Text('Sign Up'),
      color: Colors.blueAccent,
      textColor: Colors.white,
    );
    return registerButton;
  }

  void displayEmailError(String fieldError) {
    setState(() {
      _emailValidate = true;
      _passwordValidate = false;
      error = fieldError;
    });
  }

  void displayPasswordError(String fieldError) {
    setState(() {
      _passwordValidate = true;
      _emailValidate = false;
      error = fieldError;
    });
  }

  void displayLoginError(String fieldError) {
    setState(() {
      _passwordValidate = true;
      _emailValidate = true;
      error = fieldError;
    });
  }

  void loginUser(){
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Home()));
  }
}


