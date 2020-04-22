import 'package:flutter/material.dart';
import 'dart:async';
import 'package:student_app/model/api.dart';
import 'package:student_app/pages/home.dart';
import 'package:student_app/main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _nameValidate = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;

  String error = '';
  String success = '';
  Map<String, String> regMessage = {};

  @override
  Widget build(BuildContext context) {
    final nameField = displayNameField();
    final emailField = displayEmailField();
    final passwordField = displayPasswordField();
    // final registerButton = displayRegisterButton();


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  SizedBox(
                    height: 20.0,
                  ),
                  emailField,
                  SizedBox(
                    height: 20.0,
                  ),
                  passwordField,
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // registration button
                  Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () async {
                        setState(() async {
                          nameController.text.isEmpty
                              ? _nameValidate = true
                              : _nameValidate = false;
                          emailController.text.isEmpty
                              ? _emailValidate = true
                              : _emailValidate = false;
                          passwordController.text.isEmpty
                              ? _passwordValidate = true
                              : _passwordValidate = false;

                          regMessage = await registerTeacher(
                              nameController.text,
                              emailController.text,
                              passwordController.text);

                          var _list = regMessage.values.toList();
                          String field = _list[0];
                          error = _list[1];
                          print(_list[1]);

                          if (field == 'success') {
                            nameController.clear();
                            emailController.clear();
                            passwordController.clear();
                            clearError();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('hi'),
                              duration: Duration(seconds: 3),
                            ));
                            /*success = 'Registeration sucess';
              displaySuccessMessage(success);*/

                          } else if (field == 'na') {
                            print('this is a name error');
                            displayNameError(error);
                          } else if (field == 'em') {
                            print('this is an email error');
                            displayEmailError(error);
                          } else if (field == 'pa') {
                            print('this is a password error');
                            displayPasswordError(error);
                          }
                        });
                      },
                      child: Text('Register'),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                    ),
                    //return registerButton;
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('go back to login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  void displayNameError(String fieldError) {
    setState(() {
      _nameValidate = true;
      _emailValidate = false;
      _passwordValidate = false;
      error = fieldError;
    });
  }

  void displayEmailError(String fieldError) {
    setState(() {
      _emailValidate = true;
      _nameValidate = false;
      _passwordValidate = false;
      error = fieldError;
    });
  }

  void displayPasswordError(String fieldError) {
    setState(() {
      _passwordValidate = true;
      _nameValidate = false;
      _emailValidate = false;
      error = fieldError;
    });
  }

  TextField displayNameField() {
    final nameField = TextField(
      controller: nameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        labelText: 'Username',
        errorText: _nameValidate ? error : null,
        suffixIcon: Icon(
          Icons.account_circle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    return nameField;
  }

  TextField displayEmailField() {
    final emailField = TextField(
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        labelText: 'Email',
        errorText: _emailValidate ? error : null,
        suffixIcon: Icon(
          Icons.email,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    return emailField;
  }

  TextField displayPasswordField() {
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        labelText: 'Password',
        errorText: _passwordValidate ? error : null,
        suffixIcon: Icon(
          Icons.lock,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
    return passwordField;
  }

  void clearError() {
    setState(() {
      _passwordValidate = false;
      _nameValidate = false;
      _emailValidate = false;
    });
  }
}
