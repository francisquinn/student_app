import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Student.dart';
import 'Teacher.dart';

// get a list of students from the database
Future<List<Student>> getStudent() async {
  //10.0.2.2 emulator IP 4000 port
  final response = await http.get('http://10.0.2.2:4000/api/student');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<Student> students = [];

    for (var u in jsonData) {
      Student student = Student(u['name'], u['studentEmail'], u['className'], u['grade']);
      students.add(student);
    }

    print(students.length);

    return students;
  } else {
    throw Exception('Failed to load Student');
  }
}

// Register a teacher through the REST API to the mongoDB
Future<Map> registerTeacher(String name, String email, String password) async {
  print(name);
  print(email);
  print(password);
  http.Response response = await http.post('http://10.0.2.2:4000/api/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }));

  if (response.statusCode == 200) {
    Map<String, String> success = {
      "field": 'success',
      "error": 'no errors'
    };
    return success;
    
  } else {
    Map<String, String> errors = {
      "field": response.body.substring(1, 3),
      "error": response.body
    };
    // print(errors);
    return errors;
  }
}

// login teacher, check credentials in DB
Future<Map> loginTeacher(String email, String password) async {
  
  http.Response response = await http.post('http://10.0.2.2:4000/api/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{  
        'email': email,
        'password': password,
      }));

  if (response.statusCode == 200){
    Map<String, String> success = {
      "field": 'success',
      "error": 'no errors'
    };
    return success;
    
  } else{
    Map<String, String> errors = {
      "field": response.body.substring(1, 3),
      "error": response.body
    };
    return errors;
    
  }
}

bool equalsIgnoreCase(final one, final two) {
  return one?.toLowerCase() == two?.toLowerCase();
}
