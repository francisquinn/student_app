import 'package:flutter/material.dart';
import 'package:student_app/pages/home.dart';
import 'package:student_app/pages/student_page.dart';
import 'package:student_app/pages/register.dart';
import 'package:student_app/pages/login.dart';
import 'package:student_app/model/api.dart';


void main() => runApp(MaterialApp(
  
  initialRoute: '/',
  routes: {
    
    '/' : (context) => Login(),
    '/home' : (context) => Home(),
    
  },
));

